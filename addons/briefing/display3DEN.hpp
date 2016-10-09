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
                    items[] += {"TMF_Briefing"};
                };
                class TMF_Briefing
                {
                    text = "TMF Briefing Settings";
                    action = "edit3DENMissionAttributes 'TMF_MissionBriefingAttributes';";
                    //picture = "\x\tmf\addons\common\UI\icon_gear_ca";
                };
            };
        };
    };
};