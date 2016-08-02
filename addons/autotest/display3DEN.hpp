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
					items[] += {"TMF_AutoTest"};
				};
				class TMF_AutoTest
				{
					text = "TMF Autotest";
					action = "edit3DENMissionAttributes 'TMF_AutoTestAttributes';";
					//picture = "\x\tmf\addons\common\UI\icon_gear_ca";
				};
			};
		};
	};
};