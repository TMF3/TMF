
class baseMan {// Weaponless baseclass
    displayName = "Unarmed";
    // All randomized.
     uniform[] = {"CUP_U_O_TK_MixedCamo","CUP_U_O_TK_Green"};
       vest[] = {};
       backpack[] = {"B_AssaultPack_mcamo"};
       headgear[] = {};
       goggles[] = {"default"};
       hmd[] = {};
    // Leave empty to remove all. "Default" > leave original item.

    // All randomized
    primaryWeapon[] = {};
    scope[] = {};
    bipod[] = {};
    attachment[] = {};
    silencer[] = {};
    primaryMagazine[] = {}; // Magazine to be placed in weapon. Optional. Place only one, unless weapon has grenade launcher.
    // Leave empty to remove all. "Default" for primaryWeapon > leave original weapon.

    // Only *Weapons[] arrays are randomized
    secondaryWeapon[] = {};
    secondaryAttachments[] = {};
    secondaryMagazine[] = {}; // Magazine to be placed in weapon. Optional. Place only one, unless weapon has grenade launcher.
    sidearmWeapon[] = {};
    sidearmAttachments[] = {};
    sidearmMagazine[] = {}; // Magazine to be placed in weapon. Optional. Place only one, unless weapon has grenade launcher.
    // Leave empty to remove all. "Default" for secondaryWeapon or sidearmWeapon > leave original weapon.

    // These are added to the uniform or vest
    magazines[] = {};
    items[] = {};
    // These are added directly into their respective slots
    linkedItems[] = {
        "ItemMap",
        "ItemCompass",
        "ItemWatch"
    };

    // These are put into the backpack
    backpackItems[] = {};

    // This is executed after unit init is complete. argument: _this = _unit.
    code = "";

    traits[] = {};  // https://community.bistudio.com/wiki/setUnitTrait
    insignias[] = {};
    // faces[] = {}; // examples: faces[] = {"faceset:african"}; faces[] = {"AfricanHead_01"};

    // These are acre item radios that will be added during the ACRE init. ACRE radios added via any other system will be erased.
    radios[] = {};
};
class r : baseMan
{
    displayName = "Rifleman";
    headgear[] = {"CUP_H_TK_Helmet","CUP_H_TK_Beret"};
    vest[] = {"CUP_V_O_TK_Vest_1"};
    backpack[] = {"rhs_sidor"};
    primaryWeapon[] = {"hlc_rifle_FAL5061"};
    scope[] = {};
    attachment[] = {};
    magazines[] =
    {
        LIST_11("hlc_20Rnd_762x51_B_fal"),
        LIST_2("hlc_20Rnd_762x51_t_fal"),
        LIST_2("HandGrenade"),
        LIST_2("SmokeShell")
    };
    items[] =
    {
        LIST_3("ACE_fieldDressing"),
        "ACE_morphine"
    };
};
class g : r
{
    displayName = "Grenadier";
    vest[] = {"CUP_V_O_TK_Vest_1"};
    primaryWeapon[] = {"rhs_weap_m16a4_carryhandle_M203"};
    magazines[] =
    {
        LIST_6("30Rnd_556x45_Stanag"),
        LIST_2("30Rnd_556x45_Stanag_Tracer_Red"),
        LIST_2("HandGrenade"),
        LIST_2("SmokeShell"),
        LIST_8("1Rnd_HE_Grenade_shell"),
        LIST_4("1Rnd_Smoke_Grenade_shell")
    };
};
class car : r
{
    displayName = "Carabinier";
    primaryWeapon[] = {"hlc_rifle_FAL5061"};
    magazines[] =
    {
        LIST_7("hlc_20Rnd_762x51_B_fal"),
        LIST_2("hlc_20Rnd_762x51_t_fal"),
        LIST_2("HandGrenade"),
        LIST_2("SmokeShell")
    };
};
class m : car
{
    displayName = "Medic";
    vest[] = {"CUP_V_O_TK_Vest_1"};
    backpackItems[] = {
        LIST_15("ACE_fieldDressing"),
        LIST_10("ACE_morphine"),
        LIST_6("ACE_epinephrine"),
        LIST_2("ACE_bloodIV"),
        LIST_2("SmokeShell")
    };
};
class smg : r
{
    displayName = "Submachinegunner";
    primaryWeapon[] = {"hlc_rifle_aks74u"};
    magazines[] =
    {
        LIST_6("hlc_30Rnd_545x39_B_AK"),
        "HandGrenade",
        LIST_2("SmokeShell")
    };
};
class ftl : g
{
    displayName = "Fireteam Leader";
    magazines[] +=
    {
        LIST_2("1Rnd_SmokeGreen_Grenade_shell"),
        LIST_2("1Rnd_SmokeRed_Grenade_shell"),
        LIST_2("SmokeShellGreen")
    };
    linkedItems[] += {"Rangefinder","ItemGPS"};
};
class sl : ftl
{
    displayName = "Squad Leader";
    sidearmWeapon[] = {"rhsusf_weap_m1911a1"};
    magazines[] +=
    {
        LIST_3("rhsusf_mag_7x45acp_MHP")
    };
    items[] += {"ACE_Maptools"};
    linkedItems[] =
    {
        "ItemMap",
        "ItemCompass",
        "ItemWatch",
        "Rangefinder",
        "ItemGPS"
    };
};
class co : sl
{
    displayName = "Platoon Leader";
    radios[] = {"ACRE_PRC117F"};
    magazines[] = {
        LIST_3("rhsusf_mag_7x45acp_MHP"),
        LIST_2("1Rnd_SmokeGreen_Grenade_shell"),
        LIST_3("1Rnd_SmokeRed_Grenade_shell"),
        LIST_2("SmokeShellGreen"),
        LIST_2("SmokeShellPurple"),
        LIST_3("1Rnd_HE_Grenade_shell"),
        LIST_2("1Rnd_Smoke_Grenade_shell"),
        LIST_7("30Rnd_556x45_Stanag"),
        LIST_2("30Rnd_556x45_Stanag_Tracer_Red"),
        "HandGrenade",
        LIST_2("SmokeShell")
    };
    backpackItems[] = {};
};
class fac : co
{
    displayName = "Forward Air Controller";
    backpackItems[] = {};
    radios[] = {"ACRE_PRC117F"};
    linkedItems[] = {
        "ItemMap",
        "ItemCompass",
        "ItemWatch",
        "ItemGPS",
        "ACE_Vector"
    };
    items[] = {
        LIST_3("ACE_fieldDressing"),
        "ACE_morphine",
        "ACE_Kestrel4500",
        "ACE_microDAGR",
        "ACE_Maptools"
    };
};
class ar : r
{
    displayName = "Automatic Rifleman";
    primaryWeapon[] = {"hlc_lmg_M60E4"};
    bipod[] = {};
    vest[] = {"CUP_V_O_TK_Vest_1"};
    sidearmWeapon[] = {"rhsusf_weap_m1911a1"};
    magazines[] =
    {
        LIST_6("hlc_100Rnd_762x51_B_M60E4"),
        LIST_2("hlc_100Rnd_762x51_T_M60E4"),
        "HandGrenade",
        "SmokeShell",
        LIST_4("rhsusf_mag_7x45acp_MHP")
    };
};
class aar : r
{
    displayName = "Assistant Automatic Rifleman";
    backpackItems[] =
    {
        LIST_4("hlc_100Rnd_762x51_B_M60E4")
    };
    linkedItems[] += {"Binocular"};
};
class rat : car
{
    displayName = "Rifleman (AT)";
    secondaryWeapon[] = {"rhs_weap_rpg7"};
};
class dm : r
{
    displayName = "Designated Marksman";
    primaryWeapon[] = {"rhs_weap_svdp_wd_npz"};
    scope[] = {"optic_SOS"};
    bipod[] = {"rhsusf_acc_harris_bipod"};
    magazines[] =
    {
        LIST_10("rhs_10Rnd_762x54mmR_7N1"),
        LIST_2("HandGrenade"),
        LIST_2("SmokeShell")
    };
};
class mmgg : ar
{
    displayName = "MMG Gunner";
    primaryWeapon[] = {"hlc_lmg_m60"};
    scope[] = {};
    magazines[] =
    {
        LIST_4("hlc_100Rnd_762x51_B_M60E4"),
        LIST_2("hlc_100Rnd_762x51_T_M60E4"),
        "HandGrenade",
        "SmokeShell",
        LIST_4("rhsusf_mag_7x45acp_MHP")
    };
};
class mmgac : r
{
    displayName = "MMG Ammo Carrier";
    backpackItems[] =
    {
        LIST_3("hlc_100Rnd_762x51_B_M60E4")
    };
};
class mmgag : aar
{
    displayName = "MMG Assistant Gunner";
    linkedItems[] =
    {
        "ItemMap",
        "ItemCompass",
        "ItemWatch",
        "Rangefinder",
        "ItemGPS"
    };
    backpackItems[] =
    {
        LIST_3("hlc_100Rnd_762x51_B_M60E4")
    };
};
class hmgg : car
{
    displayName = "HMG Gunner";
    backPack[] = {"RHS_M2_Gun_Bag"};

};
class hmgac : r
{
    displayName = "HMG Ammo Carrier";
    backPack[] = {"RHS_M2_Gun_Bag"};
};
class hmgag : car
{
    displayName = "HMG Assistant Gunner";
    backPack[] = {"RHS_M2_Tripod_Bag"};
    linkedItems[] =
    {
        "ItemMap",
        "ItemCompass",
        "ItemWatch",
        "Rangefinder",
        "ItemGPS"
    };
};
class matg : car
{
    displayName = "MAT Gunner";
    secondaryWeapon[] = {"CUP_launch_M47"};
    backpack[] = {"B_Carryall_khk"};
    secondaryAttachments[] = {};
    magazines[] +=
    {
        "CUP_Dragon_EP1_M"
    };
};
class matac : r
{
    displayName = "MAT Ammo Carrier";
    backpack[] = {"B_Carryall_khk"};
    backpackItems[] =
    {
        "CUP_Dragon_EP1_M"
    };
};
class matag : car
{
    displayName = "MAT Assistant Gunner";
    backpack[] = {"B_Carryall_khk"};
    vest[] = {"CUP_V_O_TK_Vest_1"};
    linkedItems[] =
    {
        "ItemMap",
        "ItemCompass",
        "ItemWatch",
        "Rangefinder",
        "ItemGPS"
    };
    backpackItems[] =
    {
        "CUP_Dragon_EP1_M"
    };
};
class hatg : car
{
    displayName = "HAT Gunner";
    secondaryWeapon[] = {"rhs_weap_fgm148"};
    backpack[] = {"B_Carryall_khk"};
    backpackItems[] =
    {
        "rhs_fgm148_magazine_AT"
    };
};
class hatac : r
{
    displayName = "HAT Ammo Carrier";
    backpack[] = {"B_Carryall_khk"};
    backpackItems[] =
    {
        LIST_2("rhs_fgm148_magazine_AT")
    };
};
class hatag : car
{
    displayName = "HAT Assistant Gunner";
    backpack[] = {"B_Carryall_khk"};
    backpackItems[] =
    {
        LIST_2("rhs_fgm148_magazine_AT")
    };
    linkedItems[] =
    {
        "ItemMap",
        "ItemCompass",
        "ItemWatch",
        "Rangefinder",
        "ItemGPS"
    };
};
class mtrg : car
{
    displayName = "Mortar Gunner";
    backPack[] = {"B_Mortar_01_weapon_F"};
    linkedItems[] =
    {
        "ItemMap",
        "ItemCompass",
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
    backPack[] = {"B_HMG_01_support_F"};
    linkedItems[] =
    {
        "ItemMap",
        "ItemCompass",
        "ItemWatch",
        "Rangefinder",
        "ItemGPS"
    };
};
class samg : car
{
    displayName = "AA Missile Specialist";
    secondaryWeapon[] = {"rhs_weap_fim92"};
    backpack[] = {"B_Carryall_khk"};
    magazines[] +=
    {
        LIST_2("rhs_fim92_mag")
    };
};
class samag : car
{
    displayName = "AA Assistant Missile Specialist";
    backpack[] = {"B_Carryall_khk"};
    linkedItems[] =
    {
        "ItemMap",
        "ItemCompass",
        "ItemWatch",
        "Rangefinder",
        "ItemGPS"
    };
    backpackItems[] =
    {
        LIST_2("rhs_fim92_mag")
    };
};
class sn : r
{
    displayName = "Sniper";
    uniform[] = {"CUP_U_O_TK_Ghillie"};
    vest[] = {"V_Chestrig_rgr"};
    headgear[] = {};
    goggles[] = {"default"};
    primaryWeapon[] = {"rhs_weap_svdp_wd_npz"};
    scope[] = {"rhsusf_acc_LEUPOLDMK4_2"};
    bipod[] = {"rhsusf_acc_harris_bipod"};
    sidearmWeapon[] = {"rhsusf_weap_m9"};
    magazines[] =
    {
        LIST_9("rhs_10Rnd_762x54mmR_7N1"),
        LIST_2("HandGrenade"),
        LIST_4("rhsusf_mag_15Rnd_9x19_FMJ")
    };
    backpack[] = {};
    linkedItems[] += {"ACE_Vector","ItemGPS"};
    items[] += {"ACE_Kestrel4500", "ACE_microDAGR"};
};
class sp : sn
{
    displayName = "Spotter";
    scope[] = {};
    primaryWeapon[] = {"rhs_weap_m16a4_carryhandle_M203"};
    magazines[] =
    {
        LIST_7("30Rnd_556x45_Stanag"),
        LIST_2("30Rnd_556x45_Stanag_Tracer_Red"),
        LIST_2("HandGrenade"),
        LIST_2("SmokeShell"),
        LIST_4("1Rnd_HE_Grenade_shell"),
        LIST_4("1Rnd_Smoke_Grenade_shell"),
        LIST_4("rhsusf_mag_15Rnd_9x19_FMJ")
    };
};
class vc : smg
{
    displayName = "Vehicle Commander";
    uniform[] = {"CUP_U_O_TK_Green"};
    vest[] = {"CUP_V_O_TK_Vest_1"};
    backpack[] = {"rhsusf_assault_eagleaiii_ucp"};
    radios[] = {"ACRE_PRC117F"};
    headgear[] = {"rhs_tsh4"};
    linkedItems[] += {"Binocular","ItemGPS"};
    magazines[] += {
        LIST_2("1Rnd_SmokeGreen_Grenade_shell")
    };
};
class vd : smg
{
    displayName = "Vehicle Driver";
    uniform[] = {"CUP_U_O_TK_Green"};
    vest[] = {"CUP_V_O_TK_Vest_1"};
    backpack[] = {"rhs_sidor"};
    headgear[] = {"rhs_tsh4"};
    linkedItems[] += {"ItemGPS"};
    backpackItems[] = {"ToolKit"};
};
class vg : vd
{
    displayName = "Vehicle Gunner";
    backpack[] = {};
    backpackItems[] = {};
};
class pp : smg
{
    displayName = "Helicopter Pilot";
    uniform[] = {"CUP_U_O_TK_Green"};
    vest[] = {"CUP_V_O_TK_Vest_1"};
    backpack[] = {"rhs_sidor"};
    radios[] = {"ACRE_PRC117F"};
    headgear[] = {"rhs_zsh7a_mike"};
    goggles[] = {"default"};
    linkedItems[] += {"ItemGPS"};
    magazines[] += {
        LIST_2("1Rnd_SmokeGreen_Grenade_shell")
    };
    items[] += {"ACE_DAGR"};
};
class pcc : smg
{
    displayName = "Helicopter Crew Chief";
    uniform[] = {"CUP_U_O_TK_Green"};
    vest[] = {"CUP_V_O_TK_Vest_1"};
    backpack[] = {"rhs_sidor"};
    headgear[] = {"rhs_zsh7a_mike"};
    goggles[] = {"default"};
    linkedItems[] += {"ItemGPS"};
    backpackItems[] = {"ToolKit"};
    magazines[] += {
        LIST_2("1Rnd_SmokeGreen_Grenade_shell")
    };
};
class pc : pcc
{
    displayName = "Helicopter Crew";
    backpack[] = {};
    backpackItems[] = {};
};
class jp : baseMan
{
    displayName = "Jet pilot";
    uniform[] = {"U_O_PilotCoveralls"};
    vest[] = {"V_TacVest_blk"};
    backpack[] = {"rhsusf_assault_eagleaiii_ucp"};
    radios[] = {"ACRE_PRC117F"};
    headgear[] = {"RHS_jetpilot_usaf"};
    goggles[] = {"default"};
    sidearmWeapon[] = {"rhsusf_weap_m9"};
    magazines[] =
    {
        LIST_4("rhsusf_mag_15Rnd_9x19_FMJ")
    };
    items[] =
    {
        LIST_3("ACE_fieldDressing"),
        "ACE_morphine"
    };
    linkedItems[] = {"ItemMap","ItemGPS","ItemCompass","ItemWatch"};
};
class eng : car
{
    displayName = "Combat Engineer (Explosives)";
    vest[] = {"CUP_V_O_TK_Vest_1"};
    backpack[] = {"B_Carryall_khk"};
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
    items[] += {"ACE_M26_Clacker","ACE_DefusalKit"};
};
class engm : car
{
    displayName = "Combat Engineer (Mines)";
    vest[] = {"CUP_V_O_TK_Vest_1"};
    items[] +=
    {
        LIST_2("APERSBoundingMine_Range_Mag"),
        LIST_2("APERSTripMine_Wire_Mag"),
        "ACE_M26_Clacker",
        "ACE_DefusalKit"
    };
    backpackItems[] = {
        "MineDetector",
        "ToolKit",
        "ATMine_Range_Mag"
    };
};
class UAV : car
{
    displayName = "UAV Operator";
    backpack[] = {"B_rhsusf_B_BACKPACK"};
    linkedItems[] += {"B_UavTerminal"};
};