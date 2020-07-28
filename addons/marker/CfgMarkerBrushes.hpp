class CfgMarkerBrushes {
    class BDiagonal;
    class DiagGrid;
    class FDiagonal;
    class Grid;
    class Horizontal;
    class Vertical;
    class Cross;
    class GVARMAIN(BDiagonalBorder): BDiagonal {
        drawBorder = true;
        name = "Backward diagonal (Border)";
    };
    class GVARMAIN(DiagGridBorder): DiagGrid {
        drawBorder = true;
        name = "Grid diagonal (Border)";
    };
    class GVARMAIN(FDiagonalBorder): FDiagonal {
        drawBorder = true;
        name = "Forward diagonal (Border)";
    };
    class GVARMAIN(GridBorder): Grid {
        drawBorder = true;
        name = "Grid (Border)";
    };
    class GVARMAIN(HorizontalBorder): Horizontal {
        drawBorder = true;
        name = "Horizontal (Border)";
    };
    class GVARMAIN(VerticalBorder): Vertical {
        drawBorder = true;
        name = "Vertical (Border)";
    };
    class GVARMAIN(CrossBorder): Cross {
        drawBorder = true;
        name = "Cross (Border)";
    };
};
