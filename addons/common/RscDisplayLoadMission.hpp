class RscStandardDisplay;
class RscControlsGroupNoScrollbars;

// Display TMF logo on supported missions
class RscDisplayLoadMission: RscStandardDisplay {
    class Controls {
        class Mission: RscControlsGroupNoScrollbars {
            class controls {
                class MissionPicture;
                class GVARMAIN(logo): MissionPicture {
                    text = QPATHTOF(UI\LoadingImageTemplate.paa);
                    idc = 108;
                    onLoad = QUOTE(with uiNamespace do {                   \
                        params ['_ctrl'];                                       \
                        _ctrl ctrlShow false;                                   \
                        if ([[ARR_3(1,1,1)]] call FUNC(checkTMFVersion)) then { \
                            _ctrl ctrlShow true;                                \
                        };                                                      \
                    });
                };
            };
        };
    };
};

class RscDisplayNotFreeze: RscStandardDisplay {
    class Controls {
        class Mission: RscControlsGroupNoScrollbars {
            class controls {
                class MissionPicture;
                class GVARMAIN(logo): MissionPicture {
                    text = QPATHTOF(UI\LoadingImageTemplate.paa);
                    idc = 108;
                    onLoad = QUOTE(with uiNamespace do {                   \
                        params ['_ctrl'];                                       \
                        _ctrl ctrlShow false;                                   \
                        if ([[ARR_3(1,1,1)]] call FUNC(checkTMFVersion)) then { \
                            _ctrl ctrlShow true;                                \
                        };                                                      \
                    });
                };
            };
        };
    };
};
