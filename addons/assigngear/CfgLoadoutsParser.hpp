class CfgLoadoutsParser {
    // Appearance/equipment
    class uniform {
        priority = 5;
        type = "Array";
        #include "loadoutsParser\uniform.hpp"
    };
    class vest {
        priority = 5;
        type = "Array";
        #include "loadoutsParser\vest.hpp"
    };
    class backpack {
        priority = 5;
        type = "Array";
        #include "loadoutsParser\backpack.hpp"
    };
    class headgear {
        priority = 5;
        type = "Array";
        #include "loadoutsParser\headgear.hpp"
    };
    class goggles {
        priority = 5;
        type = "Array";
        #include "loadoutsParser\goggles.hpp"
    };
    class hmd {
        priority = 5;
        type = "Array";
		#include "loadoutsParser\hmd.hpp"
    };
    class faces {
        priority = 5;
        type = "Array";
		#include "loadoutsParser\faces.hpp"
    };
    class insignias {
        priority = 10;
        type = "Array";
		#include "loadoutsParser\insignias.hpp"
    };

    // Items/magazines
    class items {
        priority = 9;
        type = "Array";
        #include "loadoutsParser\items.hpp"
    };
    class magazines : items {
        priority = 10;
    };
    class linkedItems {
        priority = 10;
        type = "Array";
        code = "{_this linkItem _x} forEach %1;";
    };
    class backpackItems {
        priority = 8;
        type = "Array";
        code = "{_this addItemToBackpack _x} forEach %1;";
    };

    // Primary weapon
    class primaryWeapon {
        priority = 15;
        type = "Array";
		#include "loadoutsParser\addWeapon.hpp"
    };
    class attachment {
        priority = 20;
        type = "Array";
	    code = "_this addPrimaryWeaponItem selectRandom %1;";
    };
    class scope : attachment {};
    class bipod : attachment {};
    class silencer : attachment {};

    // Secondary Weapon
    class secondaryWeapon : primaryWeapon {};
    class secondaryAttachments {
        priority = 20;
        type = "Array";
        code = "{_this addSecondaryWeaponItem _x} forEach %1;";
    };

    // Sidearm Weapon
    class sidearmWeapon : primaryWeapon {};
    class sidearmAttachments {
        priority = 20;
        type = "Array";
        code = "{_this addHandgunItem _x} forEach %1;";
    };

    // Other
    class traits {
        priority = 3;
        type = "Array";
        #include "loadoutsParser\traits.hpp"
    };
    class code {
        priority = 99;
        type = "String";
        code = "%1";
    };
};
