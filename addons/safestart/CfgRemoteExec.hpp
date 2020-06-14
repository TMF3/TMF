class CfgRemoteExec
{
    // List of script functions allowed to be sent from client via remoteExec
    class Functions
    {
        class FUNC(set) { allowedTargets=0; };
        class FUNC(end) { allowedTargets=0; };
    };
};
