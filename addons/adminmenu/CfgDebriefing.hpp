class CfgDebriefing
{
    class GVAR(victory)
    {
        title = "Mission Successful";
        description = "";
        subtitle = "";
        pictureBackground = "";
        picture = "\a3\3den\Data\Attributes\TaskStates\succeeded_ca.paa";
        pictureColor[] = {1.0,1.0,1.0,1};
    };

    class GVAR(defeat)
    {
        title = "Mission Failed";
        description = "";
        subtitle = "";
        pictureBackground = "";
        picture = "\a3\3den\Data\Attributes\TaskStates\failed_ca.paa";
        pictureColor[] = {1.0,1.0,1.0,1};
    };

    class GVAR(draw)
    {
        title = "Draw";
        description = "";
        subtitle = "";
        pictureBackground = "";
        picture = "\a3\3den\Data\Attributes\TaskStates\canceled_ca.paa";
        pictureColor[] = {1.0,1.0,1.0,1};
    };

    class GVAR(technical_issues)
    {
        title = "Technical Issues";
        description = "";
        subtitle = "";
        pictureBackground = "\a3\ui_f\data\IGUI\RscTitles\Static\FeedStatic_03_CA.paa";
        picture = "\a3\Ui_f\data\GUI\Cfg\Debriefing\endDefault_ca.paa";
        pictureColor[] = {1.0,1.0,1.0,1};
    };
};
