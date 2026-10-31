class ctrlMenu; /*proto*/
class Display3DEN
{
    class ContextMenu: ctrlMenu
    {
        class Items
        {
            items[] += {"Patrol"};
            class Patrol
            {
                text = "Generate patrol";
                action = "findDisplay 313 createDisplay 'tmf_patrol_editBox';";
                conditionShow = selectedGroup;
                value = 0;
            };
        };
    };
};
