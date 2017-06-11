#include "script_component.hpp"

class CfgPatches
{
    class ADDON
    {
        name = "TMF: Admin Menu";
        author = "Bear, Snippers";
        url = "http://www.teamonetactical.com";
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"tmf_common", "A3_UI_F"};
        VERSION_CONFIG;
    };
};

#include "CfgFunctions.hpp"

//#include "defines.hpp"

#include "gui\adminMenu.hpp"