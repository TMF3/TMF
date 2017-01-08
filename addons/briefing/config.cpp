#include "script_component.hpp"

class cfgPatches
{
    class ADDON
    {
        name = "TMF: Briefing";
        author = "Snippers";
        url = "http://www.teamonetactical.com";
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"tmf_common"};
        VERSION_CONFIG;
    };
};

#include "CfgFunctions.hpp"
#include "Cfg3DEN.hpp"
#include "CfgDiary.hpp"
#include "CfgEventHandlers.hpp"

#include "display3DEN.hpp"

class TMF_autotest {
    class tmf_briefing_test {
        code = QUOTE([] call FUNC(testBriefings));
    };
};