class GVARMAIN(AIGear) {
    // Code used to determine unit type
    code = "([_this] call BIS_fnc_objectType) select 1";

    // Code used to determine unit type,
    // must return string equal to one of the arrays below.
    MG[] = {
        "ar",3,
        "mmgg",1
    };
    AT[] = {
        "rat",3,
        "matg",1
    };
    Officer[] = {
        "pl",1
    };
    Pilot[] = {
        "pc",3,
        "jp",1
    };
    Medic[] = {
        "m",1
    };
    Sniper[] = {
        "sn",1,
        "dm",1
    };

    // Default if determined type isn't one of the above arrays
    default[] = {
        "r", 10,
        "ftl", 2,
        "aar", 2,
        "eng",1,
        "sl",1
    };
};
