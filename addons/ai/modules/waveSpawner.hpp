class GVAR(wavespawn) : Module_F {
    scope = 2;
    displayName = "Wave Spawner";

    category = "Teamwork";
    icon = QPATHTOEF(common,UI\logo_tmf_small_ca.paa);
    function = QFUNC(waveInit);
    functionPriority = 10;
    isGlobal = false;
    isTriggerActivated = true;
    isDisposable = false;

    class EventHandlers: EventHandlers {
        init = "if(isServer && !is3DEN) then {[{_this call tmf_AI_fnc_waveInit;}, [_this select 0,[],false]] call CBA_fnc_execNextFrame;};_this call bis_fnc_moduleInit;";
    };

    class Attributes: AttributesBase {
        class Layers: Edit {
            property = QGVAR(wavespawn_Layers);
            displayName = "Mission layers";
            tooltip = "3DEN layers linked to this wavespawner.\nFormat: ""Layer 1"", ""Layer 2"", ""etc""";
        };
        class Delay: Default {
            property = QGVAR(wavespawn_Delay);
            displayName = "Execution delay";
            tooltip = "The time in seconds to wait before spawning the first wave";
            control = "SliderTime";
            typeName = "NUMBER";
            defaultValue = 0;
        };
        class Waves: Default {
            displayName = "Number of waves";
            property = QGVAR(wavespawn_Waves);
            control = "EditShort";
            typeName = "NUMBER";
            defaultValue = """1""";
        };
        class Time: Default {
            property = QGVAR(wavespawn_Time);
            displayName = "Time between waves";
            control = "SliderTime";
            typeName = "NUMBER";
            defaultValue = 300;
        };
        class WhenDead: Default {
            property = QGVAR(wavespawn_WhenDead);
            displayName = "% Losses needed";
            tooltip = "Percentage of units needing to be killed or unconscious before spawning a new wave";
            control = "Slider";
            typeName = "NUMBER";
            defaultValue = 0;
        };
        class WaveInit: Default {
            property = QGVAR(wavespawn_WaveInit);
            displayName = "Wave init code";
            tooltip = "Code executed every time a new wave is spawned";
            expression = QUOTE(                                                                                                                                                                \
                if (_value != 'params [ARR_7(""_wave"",""_spawnedGroups"",""_spawnedUnits"",""_spawnedVehicles"",""_spawnedObjects"",""_logic"",""_wavehandlerID"")];' && _value != '') then { \
                    [ARR_3(_this,compile _value,True)] call FUNC(addWaveHandler);                                                                                                              \
                };                                                                                                                                                                             \
            );
            defaultValue = "'params [""_wave"",""_spawnedGroups"",""_spawnedUnits"",""_spawnedVehicles"",""_spawnedObjects"",""_logic"",""_wavehandlerID""];'";
            control = "cba_common_EditCodeMulti10";
        };
        class ModuleDescription: ModuleDescription {};
    };
    class ModuleDescription: ModuleDescription {
        description = "Caches and deletes synced units for spawning later, either when triggered or after time delay.<br/>Spawns units directly on headless clients if synchronized to them.";
    };
};
