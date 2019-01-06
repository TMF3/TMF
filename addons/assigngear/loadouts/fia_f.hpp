class baseMan {// Weaponless baseclass
    displayName = "Unarmed";
    // All randomized.
    uniform[] =
    {
        "U_BG_leader",
        "U_BG_Guerilla1_1",
        "U_BG_Guerilla2_1",
        "U_BG_Guerilla2_2",
        "U_BG_Guerilla2_3",
        "U_BG_Guerilla3_1",
        "U_BG_Guerilla3_2",
        "U_BG_Guerrilla_6_1"
    };
    vest[] = {"V_TacVest_blk","V_TacVest_camo","V_TacVest_oli"};
    backpack[] = {"B_AssaultPack_rgr"};
    headgear[] = {};
    goggles[] = {"default"};
    hmd[] = {};
    // Leave empty to remove all. "Default" > leave original item.
    faces[] = {"faceset:greek"};
    // Leave empty to not change faces.
    insignias[] = {};
    // Leave empty to not change insignias

    // All randomized
    primaryWeapon[] = {};
    scope[] = {};
    bipod[] = {};
    attachment[] = {};
    silencer[] = {};
    // Leave empty to remove all. "Default" for primaryWeapon > leave original weapon.

    // Only *Weapons[] arrays are randomized
    secondaryWeapon[] = {};
    secondaryAttachments[] = {};
    sidearmWeapon[] = {};
    sidearmAttachments[] = {};
    // Leave empty to remove all. "Default" for secondaryWeapon or sidearmWeapon > leave original weapon.

    // These are added to the uniform or vest
    magazines[] = {};
    items[] = {"FirstAidKit"};
    // These are added directly into their respective slots
    linkedItems[] = {
        "ItemMap",
        "ItemCompass",
        "ItemRadio",
        "ItemWatch"
    };

    // These are put into the backpack
    backpackItems[] = {};

    // This is executed after unit init is complete. argument: _this = _unit.
    code = "";
};
class r : baseMan
{
    displayName = "Rifleman";
    headgear[] =
    {
        "H_Shemag_olive",
        "H_ShemagOpen_tan",
        "H_Bandanna_khk",
        "H_Booniehat_khk",
        "H_Cap_oli",
        "H_Watchcap_blk"
    };
    backpack[] = {"B_TacticalPack_oli"};
    primaryWeapon[] = {"arifle_TRG21_F"};
    scope[] = {"optic_ACO_grn"};
    magazines[] =
    {
        LIST_11("30Rnd_556x45_Stanag"),
        LIST_2("30Rnd_556x45_Stanag_Tracer_Yellow"),
        LIST_2("HandGrenade"),
        LIST_2("SmokeShell")
    };
};
class g : r
{
    displayName = "Grenadier";
    primaryWeapon[] = {"arifle_TRG21_GL_F"};
    magazines[] +=
    {
        LIST_8("1Rnd_HE_Grenade_shell"),
        LIST_4("1Rnd_Smoke_Grenade_shell")
    };
};
class car : r
{
    displayName = "Carabinier";
    primaryWeapon[] = {"arifle_TRG20_F"};
};
class m : car
{
    displayName = "Medic";
};
class smg : r
{
    displayName = "Submachinegunner";
    primaryWeapon[] = {"SMG_01_F"};
    magazines[] =
    {
        LIST_10("30Rnd_45ACP_Mag_SMG_01"),
        LIST_2("HandGrenade"),
        LIST_2("SmokeShell")
    };
};
class ftl : g
{
    displayName = "Fireteam Leader";
    magazines[] +=
    {
        LIST_2("1Rnd_SmokeGreen_Grenade_shell")
    };
    linkedItems[] += {"Binocular","ItemGPS"};
};
class sl : ftl
{
    displayName = "Squad Leader";
    sidearmWeapon[] = {"hgun_P07_F"};
    magazines[] +=
    {
        LIST_4("16Rnd_9x21_Mag")
    };
    linkedItems[] =
    {
        "ItemMap",
        "ItemCompass",
        "ItemRadio",
        "ItemWatch",
        "Rangefinder",
        "ItemGPS"
    };
};
class co : sl
{
    displayName = "Platoon Leader";
};
class fac : co
{
    displayName = "Forward Air Controller";
};
class ar : r
{
    displayName = "Automatic Rifleman";
    primaryWeapon[] = {"LMG_Mk200_F"};
    bipod[] = {"bipod_03_F_oli"};
    sidearmWeapon[] = {"hgun_P07_F"};
    magazines[] =
    {
        LIST_2("200Rnd_65x39_cased_Box"),
        "200Rnd_65x39_cased_Box_Tracer",
        "HandGrenade",
        "SmokeShell",
        LIST_4("16Rnd_9x21_Mag")
    };
};
class aar : r
{
    displayName = "Assistant Automatic Rifleman";
    backpackItems[] =
    {
        LIST_2("200Rnd_65x39_cased_Box")
    };
    linkedItems[] += {"Binocular"};
};
class rat : car
{
    displayName = "Rifleman (AT)";
    secondaryWeapon[] = {"launch_RPG32_F"};
    magazines[] +=
    {
        "RPG32_F"
    };
};
class dm : r
{
    displayName = "Designated Marksman";
    primaryWeapon[] = {"srifle_DMR_06_olive_F"};
    scope[] = {"optic_MRCO"};
    magazines[] =
    {
        LIST_11("20Rnd_762x51_Mag"),
        LIST_2("HandGrenade"),
        LIST_2("SmokeShell")
    };
};
class mmgg : ar
{
    displayName = "MMG Gunner";
    primaryWeapon[] = {"MMG_02_camo_F"};
    scope[] = {"optic_MRCO"};
    magazines[] =
    {
        LIST_6("130Rnd_338_Mag"),
        "HandGrenade",
        "SmokeShell",
        LIST_4("16Rnd_9x21_Mag")
    };
};
class mmgac : r
{
    displayName = "MMG Ammo Carrier";
    backpackItems[] =
    {
        LIST_3("130Rnd_338_Mag")
    };
};
class mmgag : aar
{
    displayName = "MMG Assistant Gunner";
    linkedItems[] =
    {
        "ItemMap",
        "ItemCompass",
        "ItemRadio",
        "ItemWatch",
        "Rangefinder",
        "ItemGPS"
    };
    backpackItems[] =
    {
        LIST_3("130Rnd_338_Mag")
    };
};
class hmgg : car
{
    displayName = "HMG Gunner";
    backPack[] = {"I_HMG_01_weapon_F"};

};
class hmgac : r
{
    displayName = "HMG Ammo Carrier";
    backPack[] = {"B_HMG_01_weapon_F"};
};
class hmgag : car
{
    displayName = "HMG Assistant Gunner";
    backPack[] = {"I_HMG_01_support_F"};
    linkedItems[] =
    {
        "ItemMap",
        "ItemCompass",
        "ItemRadio",
        "ItemWatch",
        "Rangefinder",
        "ItemGPS"
    };
};
class matg : car
{
    displayName = "MAT Gunner";
    secondaryWeapon[] = {"launch_NLAW_F"};
    magazines[] +=
    {
        LIST_3("NLAW_F")
    };
};
class matac : r
{
    displayName = "MAT Ammo Carrier";
    backpackItems[] =
    {
        LIST_2("NLAW_F")
    };
};
class matag : car
{
    displayName = "MAT Assistant Gunner";
    linkedItems[] =
    {
        "ItemMap",
        "ItemCompass",
        "ItemRadio",
        "ItemWatch",
        "Rangefinder",
        "ItemGPS"
    };
    backpackItems[] =
    {
        LIST_2("NLAW_F")
    };
};
class hatg : car
{
    displayName = "HAT Gunner";
    backPack[] = {"I_AT_01_weapon_F"};
};
class hatac : r
{
    displayName = "HAT Ammo Carrier";
    backPack[] = {"B_AT_01_weapon_F"};
};
class hatag : car
{
    displayName = "HAT Assistant Gunner";
    backPack[] = {"I_HMG_01_support_F"};
    linkedItems[] =
    {
        "ItemMap",
        "ItemCompass",
        "ItemRadio",
        "ItemWatch",
        "Rangefinder",
        "ItemGPS"
    };
};
class mtrg : car
{
    displayName = "Mortar Gunner";
    backPack[] = {"I_Mortar_01_weapon_F"};
    linkedItems[] =
    {
        "ItemMap",
        "ItemCompass",
        "ItemRadio",
        "ItemWatch",
        "ItemGPS"
    };
};
class mtrac : r
{
    displayName = "Mortar Ammo Carrier";
    backPack[] = {"I_Mortar_01_weapon_F"};
};
class mtrag : car
{
    displayName = "Mortar Assistant Gunner";
    backPack[] = {"I_HMG_01_support_F"};
    linkedItems[] =
    {
        "ItemMap",
        "ItemCompass",
        "ItemRadio",
        "ItemWatch",
        "Rangefinder",
        "ItemGPS"
    };
};
class samg : car
{
    displayName = "AA Missile Specialist";
    secondaryWeapon[] = {"launch_I_Titan_F"};
    magazines[] +=
    {
        LIST_3("Titan_AA")
    };
};
class samag : car
{
    displayName = "AA Assistent Missile Specialist";
    linkedItems[] =
    {
        "ItemMap",
        "ItemCompass",
        "ItemRadio",
        "ItemWatch",
        "Rangefinder",
        "ItemGPS"
    };
    backpackItems[] =
    {
        LIST_2("Titan_AA")
    };
};
class sn : r
{
    displayName = "Sniper";
    uniform[] = {"U_I_GhillieSuit"};
    vest[] = {"V_Chestrig_oli"};
    headgear[] = {};
    goggles[] = {"default"};
    primaryWeapon[] = {"srifle_GM6_F"};
    scope[] = {"optic_SOS"};
    sidearmWeapon[] = {"hgun_P07_F"};
    magazines[] =
    {
        LIST_7("5Rnd_127x108_Mag"),
        LIST_2("HandGrenade"),
        LIST_4("16Rnd_9x21_Mag")
    };
};
class sp : g
{
    displayName = "Spotter";
    scope[] = {"optic_MRCO"};
    linkedItems[] =
    {
        "ItemMap",
        "ItemCompass",
        "ItemRadio",
        "ItemWatch",
        "Rangefinder",
        "ItemGPS"
    };
};
class vc : smg
{
    displayName = "Vehicle Commander";
    vest[] = {"V_TacVest_blk","V_TacVest_brn","V_TacVest_camo","V_TacVest_oli"};
    backpack[] = {};
    headgear[] = {"H_Cap_headphones"};
    linkedItems[] += {"Binocular","ItemGPS"};
};
class vd : smg
{
    displayName = "Vehicle Driver";
    vest[] = {"V_TacVest_blk","V_TacVest_brn","V_TacVest_camo","V_TacVest_oli"};
    backpack[] = {"B_AssaultPack_khk"};
    headgear[] = {"H_Cap_headphones"};
    linkedItems[] += {"ItemGPS"};
    backpackItems[] = {"ToolKit"};
};
class vg : smg
{
    displayName = "Vehicle Gunner";
    vest[] = {"V_TacVest_blk","V_TacVest_brn","V_TacVest_camo","V_TacVest_oli"};
    backpack[] = {};
    headgear[] = {"H_Cap_headphones"};
};
class pp : smg
{
    displayName = "Helicopter Pilot";
    vest[] = {"V_TacVest_blk","V_TacVest_brn","V_TacVest_camo","V_TacVest_oli"};
    backpack[] = {};
    headgear[] = {"H_Cap_headphones"};
    goggles[] = {"default"};
    linkedItems[] += {"ItemGPS"};
};
class pcc : smg
{

    displayName = "Helicopter Crew Chief";
    vest[] = {"V_TacVest_blk","V_TacVest_brn","V_TacVest_camo","V_TacVest_oli"};
    backpack[] = {"B_AssaultPack_khk"};
    headgear[] = {"H_Cap_headphones"};
    goggles[] = {"default"};
    linkedItems[] += {"ItemGPS"};
    backpackItems[] = {"ToolKit"};
};
class pc : smg
{
    displayName = "Helicopter Crew";
    vest[] = {"V_TacVest_blk","V_TacVest_brn","V_TacVest_camo","V_TacVest_oli"};
    backpack[] = {};
    headgear[] = {"H_Cap_headphones"};
    goggles[] = {"default"};
    linkedItems[] += {"ItemGPS"};
};
class eng : car
{
    displayName = "Combat Engineer (Explosives)";
    magazines[] +=
    {
        LIST_4("ClaymoreDirectionalMine_Remote_Mag")
    };
    backpackItems[] = {
        "MineDetector",
        "ToolKit",
        LIST_2("DemoCharge_Remote_Mag"),
        LIST_2("SLAMDirectionalMine_Wire_Mag")
    };
};
class engm : car
{
    displayName = "Combat Engineer (Mines)";
    items[] +=
    {
        LIST_2("APERSBoundingMine_Range_Mag"),
        LIST_2("APERSTripMine_Wire_Mag")
    };
    backpackItems[] = {
        "MineDetector",
        "ToolKit",
        "ATMine_Range_Mag"
    };
};
/*class UAV : car
{
    displayName = "UAV Operator";
    backpack[] = {"I_UAV_01_backpack_F"};
    linkedItems[] += {"I_UavTerminal"};
};*/