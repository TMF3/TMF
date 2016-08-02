class ctrlMenuStrip;
class display3DEN
{
	class Controls
	{
		class MenuStrip : ctrlMenuStrip
		{
			class Items
			{
				class TMF_Folder {
					items[] += {"TMF_Spectator_Settings"};
				};
				class TMF_Spectator_Settings
				{
					text = "TMF Spectator Settings";
					action = "edit3DENMissionAttributes 'TMF_Spectator_Settings';";
					picture = "\x\tmf\addons\common\UI\icon_gear_ca";
				};
			};
		};
	};
};