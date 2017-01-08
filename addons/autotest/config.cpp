#include "script_component.hpp"

class cfgPatches
{
    class ADDON
    {
        name = "TMF: Autotest";
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
#include "display3DEN.hpp"

class TMF_autotest {
  /* class exampleTest {
      code = "";
  };

  Code should return an array of warnings (array consisting of a number and a string)
  [
    [-1,"test here"]
  ]

  1 = Error
  -1 = Success
  0 = Warning

  */
};