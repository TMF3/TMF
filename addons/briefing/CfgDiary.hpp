class CfgDiary {
    class FixedPages {
        class Diary    {
            text = "%TEXT";
        };
        class Tasks {
            text = "%LINK_SET_CURRENT_TASK<br /><br />%TASK_DESCRIPTION";
        };
    };
};

class RscHTML;
class RscControlsGroup;

class RscDisplayMainMap {
    class controls {
        class CA_ContentBackgroundd: RscText {
            w = "21.5 * (((safezoneW / safezoneH) min 1.2) / 40) * 1.75"; // *1.75 = TMF
            h = "18 *  ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
        };
        class CA_DiaryGroup: RscControlsGroup {
            h = "safezoneH - 7 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "21.5 *           (((safezoneW / safezoneH) min 1.2) / 40) * 1.75"; // *1.75 = TMF
            class controls {
                class CA_Diary: RscHTML {
                    h = 100;
                    w = "20.5 * (((safezoneW / safezoneH) min 1.2) / 40) * 1.75"; // *1.75 = TMF
                };
            };
        };
    };
};

class RscDisplayDiary {
    class controls {
        class CA_ContentBackgroundd: RscText {
            w = "21.5 * (((safezoneW / safezoneH) min 1.2) / 40) * 1.75"; // *1.75 = TMF
            h = "18 *  ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
        };
        class CA_DiaryGroup: RscControlsGroup {
            h = "safezoneH - 7 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "21.5 *           (((safezoneW / safezoneH) min 1.2) / 40) * 1.75"; // *1.75 = TMF
            class controls {
                class CA_Diary: RscHTML {
                    h = 100;
                    w = "20.5 * (((safezoneW / safezoneH) min 1.2) / 40) * 1.75"; // *1.75 = TMF
                };
            };
        };
    };
};

class RscDisplayGetReady: RscDisplayMainMap {
    class controls {
        class CA_ContentBackgroundd: RscText {
            w = "21.5 * (((safezoneW / safezoneH) min 1.2) / 40) * 1.75"; // *1.75 = TMF
            h = "18 *  ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
        };
        class CA_DiaryGroup: RscControlsGroup {
            h = "safezoneH - 7 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "21.5 *           (((safezoneW / safezoneH) min 1.2) / 40) * 1.75"; // *1.75 = TMF
            class controls {
                class CA_Diary: RscHTML {
                    h = 100;
                    w = "20.5 * (((safezoneW / safezoneH) min 1.2) / 40) * 1.75"; // *1.75 = TMF
                };
            };
        };
    };
};

class RscDisplayServerGetReady: RscDisplayGetReady {
    class controls {
        class CA_ContentBackgroundd: RscText {
            w = "21.5 * (((safezoneW / safezoneH) min 1.2) / 40) * 1.75"; // *1.75 = TMF
            h = "18 *  ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
        };
        class CA_DiaryGroup: RscControlsGroup {
            h = "safezoneH - 7 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "21.5 *           (((safezoneW / safezoneH) min 1.2) / 40) * 1.75"; // *1.75 = TMF
            class controls {
                class CA_Diary: RscHTML {
                    h = 100;
                    w = "20.5 * (((safezoneW / safezoneH) min 1.2) / 40) * 1.75"; // *1.75 = TMF
                };
            };
        };
    };
};

class RscDisplayClientGetReady: RscDisplayGetReady {
    class controls {
        class CA_ContentBackgroundd: RscText {
            w = "21.5 * (((safezoneW / safezoneH) min 1.2) / 40) * 1.75"; // *1.75 = TMF
            h = "18 *  ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
        };
        class CA_DiaryGroup: RscControlsGroup {
            h = "safezoneH - 7 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            w = "21.5 *           (((safezoneW / safezoneH) min 1.2) / 40) * 1.75"; // *1.75 = TMF
            class controls {
                class CA_Diary: RscHTML {
                    h = 100;
                    w = "20.5 * (((safezoneW / safezoneH) min 1.2) / 40) * 1.75"; // *1.75 = TMF
                };
            };
        };
    };
};