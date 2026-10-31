class CfgVehicles {
    class Logic;
    class GVAR(hideMapObjects) : Logic {
        displayName = "[TMF] Hide Map Objects";
        class EventHandlers {
            init = "call cba_xeh_fnc_init";
        };
    };
};
