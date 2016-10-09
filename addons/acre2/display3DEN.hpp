class ctrlMenuStrip;
class display3DEN
{
    class Controls
    {
        class MenuStrip : ctrlMenuStrip
        {
            class Items
            {
                class TMF_Folder {
                    items[] += {"TMF_ACRE2"};
                };
                class TMF_ACRE2
                {
                    text = "TMF ACRE2 Settings";
                    action = "edit3DENMissionAttributes 'TMF_MissionAcre2Attributes';";
                    //picture = "\x\tmf\addons\common\UI\icon_gear_ca";
                };
            };
        };
    };
};