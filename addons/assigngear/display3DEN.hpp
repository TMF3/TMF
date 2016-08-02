
/*
[<text>,(<title>,<buttonOK>,<buttonCancel>,<icon>,<parentDisplay>)] call BIS_fnc_3DENShowMessage;

    * text: STRING - message body or property name from Cfg3DEN >> Messages
    * title: STRING - title
    * buttonOK: STRING (button text) or ARRAY in format [<text>,<code>]
        * text: STRING - button text
        * code: CODE - expression executed upon clicking
    * buttonCancel: Same format as buttonOK
    * icon: STRING - image path to icon on left
    * parentDisplay: DISPLAY - display from which the window is opened from */

class ctrlMenu; /*proto*/
class display3DEN
{
	class ContextMenu: ctrlMenu
	{
		class Items
		{
			class Arsenal
            {
                //text = $STR_A3_Arsenal;
                //data = "Arsenal";
                //value = 0;
                action = "['It is recommended to use the TMF Assign Gear system instead of using the Arsenal (See TMF Wiki). Continue to arsenal?','Arsenal',['OK',{ ['arsenal'] spawn bis_fnc_3DENEntityMenu;}]] spawn BIS_fnc_3DENShowMessage;";
                // ['arsenal'] call bis_fnc_3DENEntityMenu;";
                //conditionShow = hoverObjectBrain AND NOT(hoverObjectVehicle);
                //picture = "\a3\3DEN\Data\Displays\Display3DEN\EntityMenu\arsenal_ca.paa";
            };
		};
	};
};