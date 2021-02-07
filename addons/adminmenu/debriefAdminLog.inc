/*
    Author: Freddo

    Creates a debriefing section for admins containing all
    log messasges sent during the mission.
    Displayed in mission debriefing screen.

    Include this file in description.ext of your mission

    Example:
    class CfgDebriefingSections {
        #include "\x\tmf\addons\adminmenu\debriefAdminLog.inc"
    };
*/

class tmf_adminlog
{
    title = "TMF Log";
    variable = "TMF_adminmenu_debrief";
};
