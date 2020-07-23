class GVARMAIN(RscDisplayAttributesModuleAIGear): RscDisplayAttributes {
    INIT_DISPLAY(GVARMAIN(RscDisplayAttributesModuleAIGear),ADDON)
    curatorObjectAttributes = true;
    class Controls: Controls {
		class Background: Background{};
		class Title: Title{};
		class Content: Content {
			class Controls: controls {
				class Loadout: GVARMAIN(RscAttributeLoadout) {};
				class Faction: GVARMAIN(RscAttributeFaction) {};
                class Retroactive: GVARMAIN(RscAttributeRetroactive) {};
			};
		};
		class ButtonOK: ButtonOK{};
		class ButtonCancel: ButtonCancel{};
	};
};
