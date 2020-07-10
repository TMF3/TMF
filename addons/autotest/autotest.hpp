class ADDON {
    /* class exampleTest {
      code = "";
    };

    Code should return an array of warnings (array consisting of a number and a string)
    [
    [-1,"test here"]
    ]

    1 = Error
    -1 = Success
    0 = Warning

    */
    class GVAR(testInit) {
        code = QUOTE([] call FUNC(testInit));
    };
    class GVAR(testEndings) {
        code = QUOTE([] call FUNC(testEndings));
    };
    class GVAR(testGroups) {
        code = QUOTE([] call FUNC(testGroups));
        warningAmount = 200;
    };
    class GVAR(testAI) {
        code = QUOTE([] call FUNC(testAI));
        warningAmount = 160;
        errorAmount = 200;
    };
    class GVAR(testDLC) {
        code = QUOTE([] call FUNC(testDLC));
        ignoredDLC[] = {/*798390*/};
    };
    class GVAR(testHCs) {
        code = QUOTE([] call FUNC(testHCs));
        expectedHCs = 0;
    };
};
