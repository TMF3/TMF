class CfgMarkerBrushes {
    class BDiagonal;
    class DiagGrid;
    class FDiagonal;
    class Grid;
    class Horizontal;
    class Vertical;
    class Cross;
    class GVARMAIN(BDiagonalBorder): BDiagonal {
        drawBorder = 1;
        name = "Backward diagonal (Border)";
    };
    class GVARMAIN(DiagGridBorder): DiagGrid {
        drawBorder = 1;
        name = "Grid diagonal (Border)";
    };
    class GVARMAIN(FDiagonalBorder): FDiagonal {
        drawBorder = 1;
        name = "Forward diagonal (Border)";
    };
    class GVARMAIN(GridBorder): Grid {
        drawBorder = 1;
        name = "Grid (Border)";
    };
    class GVARMAIN(HorizontalBorder): Horizontal {
        drawBorder = 1;
        name = "Horizontal (Border)";
    };
    class GVARMAIN(VerticalBorder): Vertical {
        drawBorder = 1;
        name = "Vertical (Border)";
    };
    class GVARMAIN(CrossBorder): Cross {
        drawBorder = 1;
        name = "Cross (Border)";
    };
};
