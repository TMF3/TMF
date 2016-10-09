#include "script_component.hpp"

class cfgPatches {
    class ADDON {
        name = "TMF: Main";
        author = "Nick";
        url = "http://www.teamonetactical.com";
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        /* Require CBA and all components below */
        requiredAddons[] = {"cba_main"};
        VERSION_CONFIG;
    };
};

class CfgMods {
    class PREFIX {
        action = "http://www.teamonetactical.com";
        dir = "";
        hideName = 0;
        hidePicture = 0;
        logo = "logo_tmf_small_ca.paa";
        logoOver = "logo_tmf_small_glow_ca.paa";
        logoSmall = "logo_tmf_small_ca.paa";
        name = "Teamwork Mission Framework";
        overview = "Teamwork Mission Framework";
        picture = "x\tmf\addons\main\logo_tmf_ca.paa";
        tooltip = "Teamwork Mission Framework";
    };
};
class CfgFactionClasses
{
    class NO_CATEGORY;
    class TEAMWORK: NO_CATEGORY
    {
        displayName = "Teamwork";
    };
};
