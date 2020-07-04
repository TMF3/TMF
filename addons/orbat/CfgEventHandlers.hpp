
XEH_PRESTART;
XEH_PREINIT;
XEH_POSTINIT;

class Extended_DisplayLoad_EventHandlers {
    class RscCustomInfoMiniMap {
        tmf_orbat = QUOTE(((_this select 0) displayCtrl 101) ctrlAddEventHandler [ARR_2('draw',{_this call FUNC(draw)})]);
    };
    class RscDiary {
        tmf_orbat = QUOTE(((_this select 0) displayCtrl 51) ctrlAddEventHandler [ARR_2('draw',{_this call FUNC(draw)})]);
    };
};
