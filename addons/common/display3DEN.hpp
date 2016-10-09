class ctrlMenuStrip;
class display3DEN
{
    class Controls
    {
        class MenuStrip : ctrlMenuStrip
        {
            class Items
            {
                items[] += {"TMF_Folder"};
                class TMF_Folder {
                    text = "Teamwork";
                    items[] = {"TMF_Documentation", "TMF_Settings"};
                };
                class TMF_Settings
                {
                    text = "TMF Settings";
                    action = "edit3DENMissionAttributes 'TMF_Settings';";
                    picture = "\x\tmf\addons\common\UI\icon_gear_ca";
                };
                class TMF_Documentation
                {
                    text = "TMF Wiki...";
                    data = "HelpFeedback";
                    picture = "\a3\3DEN\Data\Controls\ctrlMenu\link_ca.paa";
                    weblink = "http://teamonetactical.com/wiki/doku.php?id=tmf:start";
                    opensNewWindow = 1;
                };
            };
        };
    };
};