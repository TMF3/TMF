class baseMan {// Weaponless baseclass
    displayName = "Unarmed";
    // All randomized.
    uniform[] = {"U_O_CombatUniform_ocamo"};
    vest[] = {"V_TacVest_khk"};
    backpack[] = {"B_AssaultPack_ocamo"};
    headgear[] = {};
    goggles[] = {"default"};
    hmd[] = {};
    // Leave empty to remove all. "Default" > leave original item.
    faces[] = {"faceset:persian"};
    // Leave empty to not change faces.
    insignias[] = {"GryffinRegiment"};
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
    headgear[] = {"H_HelmetO_ocamo"};
    backpack[] = {"B_Kitbag_cbr"};
    primaryWeapon[] = {"arifle_Katiba_F"};
    scope[] = {"optic_ACO_grn"};
    attachment[] = {"acc_pointer_IR"};
    magazines[] =
    {
        LIST_11("30Rnd_65x39_caseless_green"),
        LIST_2("30Rnd_65x39_caseless_green_mag_Tracer"),
        LIST_2("HandGrenade"),
        LIST_2("SmokeShell")
    };
};
class g : r
{
    displayName = "Grenadier";
    primaryWeapon[] = {"arifle_Katiba_GL_F"};
    magazines[] +=
    {
        LIST_8("1Rnd_HE_Grenade_shell"),
        LIST_4("1Rnd_Smoke_Grenade_shell")
    };
};
class car : r
{
    displayName = "Carabinier";
    primaryWeapon[] = {"arifle_Katiba_C_F"};
};
class m : car
{
    displayName = "Medic";
};
class smg : r
{
    displayName = "Submachinegunner";
    primaryWeapon[] = {"SMG_02_F"};
    magazines[] =
    {
        LIST_10("30Rnd_9x21_Mag"),
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
    sidearmWeapon[] = {"hgun_Rook40_F"};
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
    primaryWeapon[] = {"LMG_Zafir_F"};
    bipod[] = {"bipod_02_F_hex"};
    sidearmWeapon[] = {"hgun_Rook40_F"};
    magazines[] =
    {
        LIST_4("150Rnd_762x54_Box"),
        LIST_2("150Rnd_762x54_Box_Tracer"),
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
        LIST_2("150Rnd_762x54_Box")
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
    primaryWeapon[] = {"srifle_DMR_05_hex_F"};
    scope[] = {"optic_MRCO"};
    bipod[] = {"bipod_02_F_hex"};
    magazines[] =
    {
        LIST_11("10Rnd_93x64_DMR_05_Mag"),
        LIST_2("HandGrenade"),
        LIST_2("SmokeShell")
    };
};
class mmgg : ar
{
    displayName = "MMG Gunner";
    primaryWeapon[] = {"MMG_01_hex_F"};
    scope[] = {"optic_MRCO"};
    magazines[] =
    {
        LIST_4("150Rnd_93x64_Mag"),
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
        LIST_3("150Rnd_93x64_Mag")
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
        LIST_3("150Rnd_93x64_Mag")
    };
};
class hmgg : car
{
    displayName = "HMG Gunner";
    backPack[] = {"O_HMG_01_weapon_F"};

};
class hmgac : r
{
    displayName = "HMG Ammo Carrier";
    backPack[] = {"O_HMG_01_weapon_F"};
};
class hmgag : car
{
    displayName = "HMG Assistant Gunner";
    backPack[] = {"O_HMG_01_support_F"};
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
    secondaryWeapon[] = {"launch_RPG32_F"};
    magazines[] +=
    {
        LIST_2("RPG32_F"),
        "RPG32_HE_F"
    };
};
class matac : r
{
    displayName = "MAT Ammo Carrier";
    backpackItems[] =
    {
        "NLAW_F",
        "RPG32_HE_F"
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
        "NLAW_F",
        "RPG32_HE_F"
    };
};
class hatg : car
{
    displayName = "HAT Gunner";
    backPack[] = {"O_AT_01_weapon_F"};
};
class hatac : r
{
    displayName = "HAT Ammo Carrier";
    backPack[] = {"O_AT_01_weapon_F"};
};
class hatag : car
{
    displayName = "HAT Assistant Gunner";
    backPack[] = {"O_HMG_01_support_F"};
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
    backPack[] = {"O_Mortar_01_weapon_F"};
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
    backPack[] = {"O_Mortar_01_weapon_F"};
};
class mtrag : car
{
    displayName = "Mortar Assistant Gunner";
    backPack[] = {"O_HMG_01_support_F"};
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
    secondaryWeapon[] = {"launch_O_Titan_F"};
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
    uniform[] = {"U_O_GhillieSuit"};
    vest[] = {"V_Chestrig_khk"};
    headgear[] = {};
    goggles[] = {"default"};
    primaryWeapon[] = {"srifle_GM6_F"};
    scope[] = {"optic_SOS"};
    sidearmWeapon[] = {"hgun_Pistol_heavy_01_F"};
    magazines[] =
    {
        LIST_7("5Rnd_127x108_Mag"),
        LIST_2("HandGrenade"),
        LIST_4("11Rnd_45ACP_Mag")
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
    uniform[] = {"U_O_SpecopsUniform_ocamo"};
    vest[] = {"V_HarnessO_brn"};
    backpack[] = {};
    headgear[] = {"H_HelmetCrew_O"};
    linkedItems[] += {"Binocular","ItemGPS"};
};
class vd : smg
{
    displayName = "Vehicle Driver";
    uniform[] = {"U_O_SpecopsUniform_ocamo"};
    vest[] = {"V_HarnessO_brn"};
    backpack[] = {"B_AssaultPack_ocamo"};
    headgear[] = {"H_HelmetCrew_O"};
    linkedItems[] += {"ItemGPS"};
    backpackItems[] = {"ToolKit"};
};
class vg : smg
{
    displayName = "Vehicle Gunner";
    uniform[] = {"U_O_SpecopsUniform_ocamo"};
    vest[] = {"V_HarnessO_brn"};
    backpack[] = {};
    headgear[] = {"H_HelmetCrew_O"};
};
class pp : smg
{
    displayName = "Helicopter Pilot";
    uniform[] = {"U_O_PilotCoveralls"};
    vest[] = {"V_HarnessO_brn"};
    backpack[] = {};
    headgear[] = {"H_PilotHelmetHeli_O"};
    goggles[] = {"default"};
    linkedItems[] += {"ItemGPS"};
};
class pcc : smg
{

    displayName = "Helicopter Crew Chief";
    uniform[] = {"U_O_PilotCoveralls"};
    vest[] = {"V_HarnessO_brn"};
    backpack[] = {"B_AssaultPack_ocamo"};
    headgear[] = {"H_PilotHelmetHeli_O"};
    goggles[] = {"default"};
    linkedItems[] += {"ItemGPS"};
    backpackItems[] = {"ToolKit"};
};
class pc : smg
{
    displayName = "Helicopter Crew";
    uniform[] = {"U_O_PilotCoveralls"};
    vest[] = {"V_HarnessO_brn"};
    backpack[] = {};
    headgear[] = {"H_PilotHelmetHeli_O"};
    goggles[] = {"default"};
    linkedItems[] += {"ItemGPS"};
};
class jp : pc
{
    displayName = "Jet Pilot";
    uniform[] = {"U_O_PilotCoveralls"};
    vest[] = {"V_HarnessO_brn"};
    backpack[] = {};
    headgear[] = {"H_PilotHelmetHeli_O"};
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
class UAV : car
{
    displayName = "UAV Operator";
    backpack[] = {"O_UAV_01_backpack_F"};
    linkedItems[] += {"O_UavTerminal"};
};
