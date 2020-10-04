class GVARMAIN(RscDisplayAttributesModuleAIGear): RscDisplayAttributes {
    INIT_DISPLAY(GVARMAIN(RscDisplayAttributesModuleAIGear),ADDON)
    curatorObjectAttributes = true;
    class Controls: Controls {
        class Background: Background{};
        class Title: Title{};
        class Content: Content {
            class Controls: controls {
                class Text: RscAttributeText {
                    class Controls: controls {
                        class Title: Title {
                            text = "Bulk applies loadouts to AI units. Cannot be undone/disabled!";
                        };
                    };
                };
                class Faction: GVARMAIN(RscAttributeFaction) {};
                class Loadout: GVARMAIN(RscAttributeLoadout) {};
                class Retroactive: GVARMAIN(RscAttributeRetroactive) {};
            };
        };
        class ButtonOK: ButtonOK{};
        class ButtonCancel: ButtonCancel{};
    };
};
