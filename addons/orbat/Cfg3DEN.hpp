
#include "\a3\3DEN\UI\resincl.inc"
#include "\a3\3DEN\UI\macros.inc"

#define GROUP_MARKER_PREVIEW "x\tmf\addons\orbat\textures\empty.paa", \
"x\tmf\addons\orbat\textures\yellow_inf.paa", \
"x\tmf\addons\orbat\textures\yellow_inf_airmobile.paa", \
"x\tmf\addons\orbat\textures\yellow_inf_mech.paa", \
"x\tmf\addons\orbat\textures\yellow_inf_mech_wheeled.paa", \
"x\tmf\addons\orbat\textures\yellow_inf_motor.paa", \
"x\tmf\addons\orbat\textures\yellow_inf_para.paa", \
"x\tmf\addons\orbat\textures\yellow_amphi.paa", \
"x\tmf\addons\orbat\textures\yellow_amphi_mech_inf.paa", \
"x\tmf\addons\orbat\textures\yellow_airdef.paa", \
"x\tmf\addons\orbat\textures\yellow_airdef_not_a_nipple.paa", \
"x\tmf\addons\orbat\textures\yellow_antitank.paa", \
"x\tmf\addons\orbat\textures\yellow_antitank_rocket.paa", \
"x\tmf\addons\orbat\textures\yellow_armor.paa", \
"x\tmf\addons\orbat\textures\yellow_armor_wheeled.paa", \
"x\tmf\addons\orbat\textures\yellow_arm_airdef.paa", \
"x\tmf\addons\orbat\textures\yellow_arm_spaag.paa", \
"x\tmf\addons\orbat\textures\yellow_artillery.paa", \
"x\tmf\addons\orbat\textures\yellow_rotarywing.paa", \
"x\tmf\addons\orbat\textures\yellow_helo_attack.paa", \
"x\tmf\addons\orbat\textures\yellow_helo_cargo.paa", \
"x\tmf\addons\orbat\textures\yellow_fixedwing.paa", \
"x\tmf\addons\orbat\textures\yellow_hq.paa", \
"x\tmf\addons\orbat\textures\yellow_logistics.paa", \
"x\tmf\addons\orbat\textures\yellow_mg.paa", \
"x\tmf\addons\orbat\textures\yellow_mg_m.paa", \
"x\tmf\addons\orbat\textures\yellow_mg_h.paa", \
"x\tmf\addons\orbat\textures\yellow_mortar.paa", \
"x\tmf\addons\orbat\textures\yellow_motor.paa", \
"x\tmf\addons\orbat\textures\yellow_para.paa", \
"x\tmf\addons\orbat\textures\yellow_para_mech.paa", \
"x\tmf\addons\orbat\textures\yellow_recon.paa", \
"x\tmf\addons\orbat\textures\yellow_recon_mech.paa", \
"x\tmf\addons\orbat\textures\yellow_recon_mech_wheeled.paa", \
"x\tmf\addons\orbat\textures\yellow_recon_motor.paa", \
"x\tmf\addons\orbat\textures\yellow_engineer.paa", \
"x\tmf\addons\orbat\textures\yellow_service.paa", \
"x\tmf\addons\orbat\textures\yellow_sf.paa", \
"x\tmf\addons\orbat\textures\yellow_signal.paa", \
"x\tmf\addons\orbat\textures\yellow_spaag.paa", \
"x\tmf\addons\orbat\textures\yellow_transport.paa", \
"x\tmf\addons\orbat\textures\yellow_uav.paa", \
"x\tmf\addons\orbat\textures\yellow_blank.paa"

#define GROUP_MARKER_DESCRIPTIONS "No Marker",\
"Infantry",\
"Infantry Air Mobile",\
"Infantry Mechanized",\
"Infantry Mechanized Wheeled",\
"Infantry Motorized",\
"Infantry Para",\
"Amphibious",\
"Amphibious Mechanized Infantry",\
"Air Defense",\
"Air Defense Missle",\
"Anti-tank",\
"Anti-tank Rocket",\
"Armour",\
"Armour wheeled",\
"Armoured Air Defense",\
"Armoured Air Defense SPAAG",\
"Artillery",\
"Helicopter",\
"Attack helicopter",\
"Cargo helicopter",\
"Fixed wing",\
"HQ",\
"Logistics",\
"Machinegun (Light ~5.56mm)",\
"Machinegun (Medium ~7.62mm)",\
"Machinegun (Heavy ~12.7mm)",\
"Mortar",\
"Motor",\
"Para",\
"Para Mechanized",\
"Recon",\
"Recon Mechanized",\
"Recon Mechanized Wheeled",\
"Recon Motorized",\
"Engineer",\
"Service",\
"Special Forces",\
"Signal (communications)",\
"SPAAG",\
"Transport",\
"UAV",\
"Plain"

#define GROUP_MARKER_POSTFIX "",\
"_inf.paa",\
"_inf_airmobile.paa",\
"_inf_mech.paa",\
"_inf_mech_wheeled.paa",\
"_inf_motor.paa",\
"_inf_para.paa",\
"_amphi.paa",\
"_amphi_mech_inf.paa",\
"_airdef.paa",\
"_airdef_not_a_nipple.paa",\
"_antitank.paa",\
"_antitank_rocket.paa",\
"_armor.paa",\
"_armor_wheeled.paa",\
"_arm_airdef.paa",\
"_arm_spaag.paa",\
"_artillery.paa",\
"_rotarywing.paa",\
"_helo_attack.paa",\
"_helo_cargo.paa",\
"_fixedwing.paa",\
"_hq.paa",\
"_logistics.paa",\
"_mg.paa",\
"_mg_m.paa",\
"_mg_h.paa",\
"_mortar.paa",\
"_motor.paa",\
"_para.paa",\
"_para_mech.paa",\
"_recon.paa",\
"_recon_mech.paa",\
"_recon_mech_wheeled.paa",\
"_recon_motor.paa",\
"_engineer.paa",\
"_service.paa",\
"_sf.paa",\
"_signal.paa",\
"_spaag.paa",\
"_transport.paa",\
"_uav.paa",\
"_blank.paa"

#define UNIT_MARKER_PREVIEW "x\tmf\addons\orbat\textures\empty.paa", \
"x\tmf\addons\orbat\textures\yellow_cross.paa", \
"x\tmf\addons\orbat\textures\yellow_chevrons.paa", \
"x\tmf\addons\orbat\textures\yellow_sl_flag.paa"

#define UNIT_MARKER_DESCRIPTIONS "No Marker",\
"Medic",\
"Plt Sgt",\
"Squad Leader"

#define UNIT_MARKER_POSTFIX "_blank.paa",\
"_cross.paa",\
"_chevrons.paa",\
"_sl_flag.paa"


class ctrlDefault;
class ctrlDefaultText;// : ctrlDefault;
class ctrlStatic;// : ctrlDefaultText;
class ctrlListNBox;// : ctrlDefaultText;
class ctrlTree;// : ctrlDefaultText;
class ctrlEdit;// : ctrlDefaultText;
class ctrlToolBox;// : ctrlDefaultText;
class ctrlCombo;

class RscButtonMenu;
class RscText;

class cfgScriptPaths
{
    TMF_orbat = "x\tmf\addons\orbat\ui_scripts\"; // " // comment here for Bad parser.
};

class Cfg3DEN
{
    #include "Cfg3DEN\Mission.hpp"
    #include "Cfg3DEN\Object.hpp"
    #include "Cfg3DEN\Group.hpp"
    #include "Cfg3DEN\Attributes.hpp"
};
