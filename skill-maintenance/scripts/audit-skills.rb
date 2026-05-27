#!/usr/bin/env ruby
# frozen_string_literal: true

require "digest"
require "optparse"
require "set"

options = {
  roots: [],
  long_description: 280,
  long_body_lines: 220,
  long_body_chars: 7_000,
  long_section_lines: 80,
  overlap: 0.55,
  body_overlap: 0.82,
  min_body_words: 120,
  deprecated: ["enforcing-test-coverage-vitest-playwright"]
}

OptionParser.new do |parser|
  parser.banner = "Usage: audit-skills.rb --root PATH [--root PATH ...]"
  parser.on("--root PATH", "Skill root to scan") { |path| options[:roots] << path }
  parser.on("--long-description N", Integer, "Long description threshold") { |value| options[:long_description] = value }
  parser.on("--long-body-lines N", Integer, "Long body line-count threshold") { |value| options[:long_body_lines] = value }
  parser.on("--long-body-chars N", Integer, "Long body character-count threshold") { |value| options[:long_body_chars] = value }
  parser.on("--long-section-lines N", Integer, "Long heading section threshold") { |value| options[:long_section_lines] = value }
  parser.on("--overlap FLOAT", Float, "Description-overlap threshold") { |value| options[:overlap] = value }
  parser.on("--body-overlap FLOAT", Float, "Near-body duplicate threshold") { |value| options[:body_overlap] = value }
  parser.on("--min-body-words N", Integer, "Minimum body word count for near-body duplicate checks") { |value| options[:min_body_words] = value }
  parser.on("--deprecated NAME", "Deprecated/superseded skill name to flag") { |value| options[:deprecated] << value }
end.parse!

home = Dir.home

def expand(path)
  path.start_with?("~/") ? File.join(Dir.home, path[2..]) : path
end

def read_frontmatter(file)
  text = File.read(file)
  match = text.match(/\A---\n(.*?)\n---\n/m)
  return [{}, text] unless match

  data = {}
  match[1].each_line do |line|
    next unless line =~ /\A([A-Za-z0-9_-]+):\s*(.*)\z/

    key = Regexp.last_match(1)
    value = Regexp.last_match(2).strip
    value = value[1...-1] if value.start_with?('"') && value.end_with?('"')
    data[key] = value
  end
  [data, text[(match[0].length)..] || ""]
end

def words(value)
  value.downcase.scan(/[a-z0-9][a-z0-9-]{2,}/).to_set
end

def jaccard(a, b)
  return 0.0 if a.empty? || b.empty?

  (a & b).length.to_f / (a | b).length
end

def sections(body)
  result = []
  current = { heading: "(intro)", lines: 0, chars: 0 }

  body.each_line do |line|
    if line.start_with?("## ")
      result << current if current[:lines].positive?
      current = { heading: line.sub(/\A#+\s*/, "").strip, lines: 1, chars: line.each_char.count }
    else
      current[:lines] += 1
      current[:chars] += line.each_char.count
    end
  end

  result << current if current[:lines].positive?
  result
end

roots = options[:roots].map { |root| File.expand_path(expand(root)) }.select { |root| Dir.exist?(root) }.uniq

skills = []
roots.each do |root|
  Dir.glob(File.join(root, "**", "SKILL.md")).sort.each do |file|
    data, body = read_frontmatter(file)
    name = (data["name"] || File.basename(File.dirname(file))).strip
    description = (data["description"] || "").strip
    rel = file.sub("#{home}/", "~/")
    skills << {
      root: root,
      file: file,
      display_file: rel,
      name: name,
      description: description,
      description_length: description.each_char.count,
      body_lines: body.lines.count,
      body_chars: body.each_char.count,
      sections: sections(body),
      body_hash: Digest::SHA256.hexdigest(body.downcase.gsub(/\s+/, " ")),
      body_words: words(body),
      description_words: words(description)
    }
  end
end

puts "# Skill Inventory Audit"
puts
puts "- Roots checked: #{roots.length}"
roots.each { |root| puts "  - #{root.sub("#{home}/", "~/")}" }
puts "- Skills found: #{skills.length}"
puts

puts "## Skills By Root"
skills.group_by { |skill| skill[:root] }.sort.each do |root, list|
  puts "- #{root.sub("#{home}/", "~/")}: #{list.length}"
end
puts

long = skills.select { |skill| skill[:description_length] >= options[:long_description] }
             .sort_by { |skill| [-skill[:description_length], skill[:name]] }
puts "## Long Descriptions"
if long.empty?
  puts "- None above #{options[:long_description]} characters."
else
  long.each do |skill|
    puts "- #{skill[:description_length]} chars: #{skill[:name]} (#{skill[:display_file]})"
  end
end
puts

duplicates = skills.group_by { |skill| skill[:name] }.select { |_name, list| list.length > 1 }
puts "## Duplicate Names"
if duplicates.empty?
  puts "- None."
else
  duplicates.sort.each do |name, list|
    puts "- #{name} (#{list.length})"
    list.each { |skill| puts "  - #{skill[:display_file]}" }
  end
end
puts

same_body = skills.group_by { |skill| skill[:body_hash] }.select { |_hash, list| list.length > 1 }
puts "## Identical Bodies"
if same_body.empty?
  puts "- None."
else
  same_body.each_value do |list|
    puts "- #{list.map { |skill| skill[:name] }.uniq.sort.join(', ')}"
    list.each { |skill| puts "  - #{skill[:display_file]}" }
  end
end
puts

puts "## Body Bloat"
long_bodies = skills.select do |skill|
  skill[:body_lines] >= options[:long_body_lines] || skill[:body_chars] >= options[:long_body_chars]
end.sort_by { |skill| [-skill[:body_chars], -skill[:body_lines], skill[:name]] }

if long_bodies.empty?
  puts "- None above #{options[:long_body_lines]} lines or #{options[:long_body_chars]} chars."
else
  long_bodies.each do |skill|
    puts "- #{skill[:body_lines]} lines, #{skill[:body_chars]} chars: #{skill[:name]} (#{skill[:display_file]})"
  end
end
puts

puts "## Near Body Duplicates"
body_pairs = []
skills.combination(2) do |a, b|
  next if a[:body_words].length < options[:min_body_words] || b[:body_words].length < options[:min_body_words]

  score = jaccard(a[:body_words], b[:body_words])
  body_pairs << [score, a, b] if score >= options[:body_overlap]
end

if body_pairs.empty?
  puts "- None above #{options[:body_overlap]} with at least #{options[:min_body_words]} body words."
else
  body_pairs.sort_by { |score, _a, _b| -score }.each do |score, a, b|
    puts "- #{format('%.2f', score)}: #{a[:name]} <-> #{b[:name]}"
    puts "  - #{a[:body_lines]} lines, #{a[:body_chars]} chars: #{a[:display_file]}"
    puts "  - #{b[:body_lines]} lines, #{b[:body_chars]} chars: #{b[:display_file]}"
  end
end
puts

puts "## Large Sections"
large_sections = skills.flat_map do |skill|
  skill[:sections].select { |section| section[:lines] >= options[:long_section_lines] }.map do |section|
    [skill, section]
  end
end.sort_by { |skill, section| [-section[:lines], -section[:chars], skill[:name], section[:heading]] }

if large_sections.empty?
  puts "- None above #{options[:long_section_lines]} lines."
else
  large_sections.each do |skill, section|
    puts "- #{section[:lines]} lines, #{section[:chars]} chars: #{skill[:name]} > #{section[:heading]}"
    puts "  - #{skill[:display_file]}"
  end
end
puts

puts "## Repeated Section Headings"
heading_groups = skills.flat_map do |skill|
  skill[:sections].map { |section| [section[:heading].downcase, section[:heading], skill] }
end.group_by { |normalized, _heading, _skill| normalized }
 .reject { |heading, _list| heading == "(intro)" }
 .select { |_heading, list| list.map { |_normalized, _heading, skill| skill[:name] }.uniq.length >= 4 }

if heading_groups.empty?
  puts "- None repeated across 4 or more skills."
else
  heading_groups.sort_by { |heading, list| [-list.length, heading] }.each do |_normalized, list|
    heading = list.first[1]
    names = list.map { |_n, _h, skill| skill[:name] }.uniq.sort
    puts "- #{heading}: #{names.length} skills (#{names.join(', ')})"
  end
end
puts

puts "## Body Cleanup Recommendations"
if long_bodies.empty? && large_sections.empty? && body_pairs.empty?
  puts "- No body cleanup candidates from current thresholds."
else
  long_bodies.first(10).each do |skill|
    largest = skill[:sections].max_by { |section| [section[:lines], section[:chars]] }
    next unless largest

    if largest[:lines] >= options[:long_section_lines]
      puts "- Split or compress #{skill[:name]} > #{largest[:heading]} (#{largest[:lines]} lines)."
    else
      puts "- Review #{skill[:name]} body size (#{skill[:body_lines]} lines, #{skill[:body_chars]} chars)."
    end
  end
  body_pairs.first(10).each do |score, a, b|
    puts "- Compare #{a[:name]} and #{b[:name]} for duplicated body prose (#{format('%.2f', score)} overlap)."
  end
end
puts

puts "## Description Overlap"
pairs = []
skills.combination(2) do |a, b|
  next if a[:name] == b[:name]

  score = jaccard(a[:description_words], b[:description_words])
  pairs << [score, a, b] if score >= options[:overlap]
end
if pairs.empty?
  puts "- None above #{options[:overlap]}."
else
  pairs.sort_by { |score, _a, _b| -score }.each do |score, a, b|
    puts "- #{format('%.2f', score)}: #{a[:name]} <-> #{b[:name]}"
    puts "  - #{a[:display_file]}"
    puts "  - #{b[:display_file]}"
  end
end
puts

puts "## Superseded Skill Names"
deprecated = skills.select { |skill| options[:deprecated].include?(skill[:name]) || options[:deprecated].any? { |name| skill[:file].include?(name) } }
if deprecated.empty?
  puts "- None found."
else
  deprecated.each { |skill| puts "- #{skill[:name]} (#{skill[:display_file]})" }
end
