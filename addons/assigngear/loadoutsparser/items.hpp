code = "{ \
    switch true do { \
        case (_this canAddItemToUniform _x): {_this addItemToUniform _x;}; \
        case (_this canAddItemToVest _x): {_this addItemToVest _x;}; \
        default {_this addItemToBackpack _x;}; \
    }; \
} forEach %1;";
