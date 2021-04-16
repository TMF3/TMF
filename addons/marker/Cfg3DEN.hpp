#include "\a3\3den\UI\macros.inc"

class Cfg3DEN
{
    class Marker
    {
        class AttributeCategories
        {
            class State
            {
                displayName = "Visibility";
                class Attributes
                {
                    class GVAR(visibility)
                    {
                        property = QGVAR(visibility);
                        displayName = "Marker visible to";
                        tooltip = "Choose a team.";
                        control = "TMF_VisibleTo";
                        expression = "if(_value != -1) then {[_this,_value] remoteExec ['tmf_marker_fnc_hide',0,true];};";
                        defaultValue = "-1";
                        wikiType = "[[Number]]";
                    };
                };
            };
        };
    };
    class Attributes
    {
        class Title;
        class Combo;
        class Value;
        class Controls;
        class TMF_VisibleTo : Combo
        {
            attributeLoad = "\
                _ctrlSide = _this controlsGroupCtrl 100;\
                if (_value isEqualType true) then {_value = -1};\
                if (_value == 0) then {_value = 2};\
                if (_value == -1) then {_value = 0};\
                _ctrlSide lbSetCurSel _value;\
            ";
            attributeSave = "\
                _ctrlSide = _this controlsGroupCtrl 100;\
                _ctrlSide lbValue lbCurSel _ctrlSide\
            ";
            class Controls : Controls
            {
                class Title : Title {};
                class ValueSide : Value
                {
                    idc = 100;
                    class Items
                    {
                        class All
                        {
                            text = "All sides";
                            tooltip = "All sides";
                            data = "None";
                            value = -1;
                        };
                        class West
                        {
                            text = "Blufor";
                            tooltip = "Blufor";
                            data = "None";
                            value = 1;
                        };
                        class East
                        {
                            text = "Opfor";
                            tooltip = "Opfor";
                            data = "None";
                            value = 0;
                        };
                        class Resistance
                        {
                            text = "Independent";
                            tooltip = "Independent";
                            data = "None";
                            value = 2;
                        };
                        class Civilian
                        {
                            text = "Civilian";
                            tooltip = "Civilian";
                            data = "None";
                            value = 3;
                        };
                        class None
                        {
                            text = "None";
                            tooltip = "None";
                            data = "None";
                            value = 4;
                        };
                    };
                };
            };
        };
    };
};
