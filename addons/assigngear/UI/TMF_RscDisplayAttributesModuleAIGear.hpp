class GVARMAIN(RscDisplayAttributesModuleAIGear): RscDisplayAttributes {
    scriptName = QGVARMAIN(RscDisplayAttributesModuleAIGear);
    scriptPath = QUOTE(ADDON);
    onLoad = QUOTE([ARR_4('onLoad',_this,QQGVARMAIN(RscDisplayAttributesModuleAIGear),QUOTE(QUOTE(ADDON)))] call (uiNamespace getVariable 'BIS_fnc_initDisplay'));
    onUnload = QUOTE([ARR_4('onUnload',_this,QQGVARMAIN(RscDisplayAttributesModuleAIGear),QUOTE(QUOTE(ADDON)))] call (uiNamespace getVariable 'BIS_fnc_initDisplay'));
    curatorObjectAttributes = true;
    class Controls: Controls {
        class Background: Background{};
        class Title: Title{};
        class Content: Content {
            class Controls: Controls {
                class Text: RscAttributeText {
                    class Controls: Controls {
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
