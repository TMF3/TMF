class CfgVehicles {
    class All;
    class Logic : All {
        class EventHandlers;
    };
    class GVAR(hideMapObjects) : Logic {
        displayName = "[TMF] Hide Map Objects";
        class EventHandlers {
            init = "call cba_xeh_fnc_init";
        };
    };
};
