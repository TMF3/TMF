#include "script_component.hpp"

class cfgPatches
{
    class ADDON
    {
        name = "TMF: Safestart";
        author = "Head";
        url = "http://www.teamonetactical.com";
        units[] = {GVAR(module)};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"tmf_common"};
        VERSION_CONFIG;
    };
};

#include "CfgFunctions.hpp"
#include "CfgModules.hpp"
#include "CfgRemoteExec.hpp"
#include "CfgEventhandlers.hpp"

class RscText;
class RscDisplayMainMap;
#include "RscDisplayGetReady.hpp"
#include "RscTitles.hpp"
