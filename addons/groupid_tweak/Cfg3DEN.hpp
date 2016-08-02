
class Cfg3DEN
{
	class Group
	{
        class AttributeCategories
        {
            class Init
            {
                class Attributes
                {
                    class Callsign
                    {
                        expression = "_this setGroupId [_value]; [{ params ['_group','_value']; _group setGroupIdGlobal [_value]; }, [_this,_value], 0] call CBA_fnc_waitAndExecute;";
                    };
                };
            };
        };
	};
};
