import {
	BaseComponentElement,
	bindTemplateElement,
	customElement,
} from '../../libs/base-component';
import '../data-panel';
import template from './staratlas-profile.html?raw';
import style from './staratlas-profile.css?inline';
import { DacMembership, PlayerProfileWithMemberships } from '../../types/userdata';
import '../panel';
import { DAC } from '../../types/dacs';

declare global {
	interface HTMLElementTagNameMap {
		'astral-staratlas-profile': AstralStarAtlasProfileElement;
	}
}

@customElement('astral-staratlas-profile')
export class AstralStarAtlasProfileElement extends BaseComponentElement {
	static factionIconPath = '/staratlas/';
	
	@bindTemplateElement('#staratlas-profile-template')
	private profileTemplateEl: HTMLTemplateElement | null = null;

	@bindTemplateElement('#dac-item-template')
	private dacItemTemplateEl: HTMLTemplateElement | null = null;

	@bindTemplateElement('#dac-surplus-template')
	private dacSurplusTemplateEl: HTMLTemplateElement | null = null;

	@bindTemplateElement('#profile-name')
	private profileNameEl: HTMLElement | null = null;

	@bindTemplateElement('#profile-key')
	private profileKeyEl: HTMLElement | null = null;

	@bindTemplateElement('#profile-avatar')
	private profileAvatarEl: HTMLImageElement | null = null;

	@bindTemplateElement('#faction-logo')
	private factionLogoEl: HTMLImageElement | null = null;

	@bindTemplateElement('#dac-list')
	private dacListEl: HTMLUListElement | null = null;

	@bindTemplateElement('#subprofile-container')
	private subprofileContainerEl: HTMLElement | null = null;

	private profiles: PlayerProfileWithMemberships[] = [];
	private avatarUrl: string | undefined;
	private dacs: DAC[] = [];

	constructor() {
		super(template, style);
	}

	setProfileData(profiles: PlayerProfileWithMemberships[], dacData: DAC[], avatarUrl?: string) {
		if (!profiles || profiles.length === 0) {
			this.remove();
			return;
		}

		this.profiles = [...profiles];
		this.avatarUrl = avatarUrl;
		this.dacs = dacData;

		if (this.isConnected) {
			this.render();
		}
	}

	protected render() {
		if (
			!this.profileNameEl ||
			!this.profileKeyEl ||
			!this.profileAvatarEl ||
			!this.factionLogoEl ||
			!this.dacListEl
		) {
			throw new Error('Profile elements not found in the template');
		}
		if (!this.profiles.length) {
			return;
		}

		if (this.avatarUrl) {
			this.profileAvatarEl.setAttribute('src', this.avatarUrl);
		}

		const profiles = [...this.profiles];
		const { name, id, faction, dacMemberships } = profiles.shift() as PlayerProfileWithMemberships;

		this.profileNameEl.textContent = name || 'Unknown Player';
		this.profileKeyEl.textContent = id || 'Unknown Wallet';

		if (faction) {
			this.factionLogoEl.setAttribute(
				'src',
				`${AstralStarAtlasProfileElement.factionIconPath}${faction.toLowerCase()}.png`
			);
		}

		this.renderSurplusProfiles(profiles);

		this.renderDacs(dacMemberships, this.dacListEl, 4);
	}

	private renderSurplusProfiles(profiles: PlayerProfileWithMemberships[]) {
		if (!this.profileTemplateEl) {
			throw new Error('Profile template element not found');
		}

		if (!this.subprofileContainerEl) {
			throw new Error('Subprofile container element not found');
		}

		const otherProfiles = profiles.map((profile, idx) => {
			console.log('rendering profile', idx, profile);
			const profileItemEl = this.profileTemplateEl!.content.cloneNode(true) as DocumentFragment;
			if (!profileItemEl) {
				throw new Error('Failed to clone profile template');
			}
			const profileEl = profileItemEl.firstElementChild!;

			profileEl.querySelector('.subprofile__number')!.textContent = `${idx + 2}`;
			profileEl.querySelector('.subprofile__name')!.textContent = profile.name || 'Unknown Player';
			profileEl.querySelector('.subprofile__key')!.textContent = profile.id || 'Unknown Wallet';

			if (profile.faction) {
				const factionLogoEl = profileEl.querySelector('.subprofile__faction img') as HTMLImageElement;
				factionLogoEl.setAttribute(
					'src',
					`${AstralStarAtlasProfileElement.factionIconPath}${profile.faction.toLowerCase()}.png`
				);
			}

			const dacsListEl = profileEl.querySelector<HTMLUListElement>('.subprofile__dacs');
			this.renderDacs(profile.dacMemberships, dacsListEl!, 2);

			return profileItemEl;
		});

		this.subprofileContainerEl.append(...otherProfiles);
	}

	private renderDacs(dacMemberships: DacMembership[], containerEl: HTMLUListElement, maxItems: number) {
		const dacItemsEls = this.getDacItems(dacMemberships, maxItems);

		console.log('DAC surplus items:', dacItemsEls.length);
		containerEl.append(...dacItemsEls);
		containerEl.classList.add(`dac-list--${Math.max(1, Math.min(3, dacItemsEls.length))}`);
	}

	private getDacItems(dacMemberships: DacMembership[], maxItems: number): DocumentFragment[] {
		if (!this.dacItemTemplateEl || !this.dacSurplusTemplateEl) {
			throw new Error('DAC item template element not found');
		}

		if (!this.dacs || this.dacs.length === 0) {
			return [];
		}

		const dacItemsEls = dacMemberships
			.map((dac) => {
				const dacData = this.dacs.find((d) => d.id === dac.dacId);
				if (!dacData) {
					console.warn(`DAC with ID ${dac.dacId} not found in the provided DAC data`);
					return;
				}

				const dacItemEl = this.dacItemTemplateEl!.content.cloneNode(true) as DocumentFragment;
				const iconEl = dacItemEl.querySelector('.dac__logo') as HTMLImageElement | null;
				if (iconEl) {
					iconEl.setAttribute('src', dacData.profile || '/staratlas/default-dac-icon.png');
					iconEl.setAttribute('alt', dacData.name || 'DAC Icon');
				} else {
					console.warn('DAC icon element not found in the template');
				}

				return dacItemEl;
			})
			.filter((el): el is DocumentFragment => !!el);

		if (dacItemsEls.length > maxItems) {
			const surplusItems = dacItemsEls.splice(maxItems - 1);
			const surplusEl = this.dacSurplusTemplateEl!.content.cloneNode(true) as DocumentFragment;
			surplusEl.firstElementChild!.textContent = `+${surplusItems.length}`;
			dacItemsEls.push(surplusEl);

			console.log('DAC surplus items:', dacItemsEls.length, surplusItems.length);
		}

		return dacItemsEls;
	}
}
