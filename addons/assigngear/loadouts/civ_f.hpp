class baseMan {// Weaponless baseclass
    displayName = "Unarmed";
    // All randomized.
    uniform[] = {"U_C_Poloshirt_blue"};
    vest[] = {};
    backpack[] = {};
    headgear[] = {};
    goggles[] = {"default"};
    hmd[] = {};
    // Leave empty to remove all. "Default" > leave original item.
    faces[] = {};
    // Leave empty to not change faces.
    insignias[] = {};
    // Leave empty to not change insignias

    // All randomized
    primaryWeapon[] = {};
    scope[] = {};
    bipod[] = {};
    attachment[] = {};
    silencer[] = {};
    primaryMagazine[] = {};  // use to put magazine directly into weapon if it doesn't fit into unit's inventory.
    primaryGrenade[] = {};  // use to put grenade directly into weapon if it doesn't fit into unit's inventory.
    // Leave empty to remove all. "Default" for primaryWeapon > leave original weapon.

    // Only *Weapons[] arrays are randomized
    secondaryWeapon[] = {};
    secondaryAttachments[] = {};
    secondaryMagazine[] = {};  // use to put magazine directly into weapon if it doesn't fit into unit's inventory.
    sidearmWeapon[] = {};
    sidearmAttachments[] = {};
    sidearmMagazine[] = {};  // use to put magazine directly into weapon if it doesn't fit into unit's inventory.
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