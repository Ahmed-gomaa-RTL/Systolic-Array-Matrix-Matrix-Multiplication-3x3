module SYSTOLIC_ARRAY # ( parameter WIDTH = 4 , WIDTH_SUM = 8 , ROW = 3 , COLOUM = 3 )  ( 
  input             wire                                            CLK                  ,
  input             wire                                            RST                  ,
  input             wire                                            ENABLE               , 
  input             wire       [ ( WIDTH * COLOUM ) - 1 : 0 ]       A_IN_ROW_1           ,
  input             wire       [ ( WIDTH * COLOUM ) - 1 : 0 ]       A_IN_ROW_2           ,
  input             wire       [ ( WIDTH * COLOUM ) - 1 : 0 ]       A_IN_ROW_3           ,
  input             wire       [ ( WIDTH * ROW    ) - 1 : 0 ]       B_IN_COLOUM_1        ,
  input             wire       [ ( WIDTH * ROW    ) - 1 : 0 ]       B_IN_COLOUM_2        ,
  input             wire       [ ( WIDTH * ROW    ) - 1 : 0 ]       B_IN_COLOUM_3        ,
  output            wire       [ WIDTH_SUM - 1 : 0 ]                C_OUT_1x1            ,
  output            wire       [ WIDTH_SUM - 1 : 0 ]                C_OUT_1x2            ,
  output            wire       [ WIDTH_SUM - 1 : 0 ]                C_OUT_1x3            ,
  output            wire       [ WIDTH_SUM - 1 : 0 ]                C_OUT_2x1            ,
  output            wire       [ WIDTH_SUM - 1 : 0 ]                C_OUT_2x2            ,
  output            wire       [ WIDTH_SUM - 1 : 0 ]                C_OUT_2x3            ,
  output            wire       [ WIDTH_SUM - 1 : 0 ]                C_OUT_3x1            ,
  output            wire       [ WIDTH_SUM - 1 : 0 ]                C_OUT_3x2            ,
  output            wire       [ WIDTH_SUM - 1 : 0 ]                C_OUT_3x3            ,
  output            wire                                            MULTI_OVER                

);



wire    [ WIDTH - 1  : 0 ]    A_OUT_ROW_1      ;
wire    [ WIDTH - 1  : 0 ]    A_OUT_ROW_2      ;
wire    [ WIDTH - 1  : 0 ]    A_OUT_ROW_3      ;
wire    [ WIDTH - 1  : 0 ]    B_OUT_COLOUM_1   ;
wire    [ WIDTH - 1  : 0 ]    B_OUT_COLOUM_2   ;
wire    [ WIDTH - 1  : 0 ]    B_OUT_COLOUM_3   ;


wire    [ WIDTH - 1  : 0 ]    A1x1  ;
wire    [ WIDTH - 1  : 0 ]    A1x2  ;
wire    [ WIDTH - 1  : 0 ]    A1x3  ;
wire    [ WIDTH - 1  : 0 ]    A2x1  ;
wire    [ WIDTH - 1  : 0 ]    A2x2  ;
wire    [ WIDTH - 1  : 0 ]    A2x3  ;
wire    [ WIDTH - 1  : 0 ]    A3x1  ;
wire    [ WIDTH - 1  : 0 ]    A3x2  ;
wire    [ WIDTH - 1  : 0 ]    A3x3  ; 

wire    [ WIDTH - 1  : 0 ]    B1x1  ;
wire    [ WIDTH - 1  : 0 ]    B1x2  ;
wire    [ WIDTH - 1  : 0 ]    B1x3  ;
wire    [ WIDTH - 1  : 0 ]    B2x1  ;
wire    [ WIDTH - 1  : 0 ]    B2x2  ;
wire    [ WIDTH - 1  : 0 ]    B2x3  ;
wire    [ WIDTH - 1  : 0 ]    B3x1  ;
wire    [ WIDTH - 1  : 0 ]    B3x2  ;
wire    [ WIDTH - 1  : 0 ]    B3x3  ; 

wire   MULTI_OVER1   ;
wire   MULTI_OVER2   ;
wire   MULTI_OVER3   ;
wire   MULTI_OVER4   ;
wire   MULTI_OVER5   ;
wire   MULTI_OVER6   ;
wire   MULTI_OVER7   ;
wire   MULTI_OVER8   ;
wire   MULTI_OVER9   ;



SHIFT_REGISTER # ( .WIDTH(WIDTH) , .ROW(ROW) , .COLOUM(COLOUM)  ) G1 (
      CLK               ,
      RST               ,
      ENABLE            , 
      A_IN_ROW_1        ,
      A_IN_ROW_2        ,
      A_IN_ROW_3        ,
      B_IN_COLOUM_1     ,
      B_IN_COLOUM_2     ,
      B_IN_COLOUM_3     ,
      A_OUT_ROW_1       ,
      A_OUT_ROW_2       ,
      A_OUT_ROW_3       ,
      B_OUT_COLOUM_1    ,  
      B_OUT_COLOUM_2    , 
      B_OUT_COLOUM_3            
);



PROCESS_ELEMENT # ( .WIDTH(WIDTH)  , .WIDTH_SUM(WIDTH_SUM)  ) G2  ( CLK , RST , ENABLE , A_OUT_ROW_1 , B_OUT_COLOUM_1 , A1x1 , B1x1 , C_OUT_1x1 , MULTI_OVER1 ) ;
PROCESS_ELEMENT # ( .WIDTH(WIDTH)  , .WIDTH_SUM(WIDTH_SUM)  ) G3  ( CLK , RST , ENABLE , A1x1        , B_OUT_COLOUM_2 , A1x2 , B1x2 , C_OUT_1x2 , MULTI_OVER2 ) ;
PROCESS_ELEMENT # ( .WIDTH(WIDTH)  , .WIDTH_SUM(WIDTH_SUM)  ) G4  ( CLK , RST , ENABLE , A1x2        , B_OUT_COLOUM_3 , A1x3 , B1x3 , C_OUT_1x3 , MULTI_OVER3 ) ;
PROCESS_ELEMENT # ( .WIDTH(WIDTH)  , .WIDTH_SUM(WIDTH_SUM)  ) G5  ( CLK , RST , ENABLE , A_OUT_ROW_2 , B1x1           , A2x1 , B2x1 , C_OUT_2x1 , MULTI_OVER4 ) ;
PROCESS_ELEMENT # ( .WIDTH(WIDTH)  , .WIDTH_SUM(WIDTH_SUM)  ) G6  ( CLK , RST , ENABLE , A2x1        , B1x2           , A2x2 , B2x2 , C_OUT_2x2 , MULTI_OVER5 ) ;
PROCESS_ELEMENT # ( .WIDTH(WIDTH)  , .WIDTH_SUM(WIDTH_SUM)  ) G7  ( CLK , RST , ENABLE , A2x2        , B1x3           , A2x3 , B2x3 , C_OUT_2x3 , MULTI_OVER6 ) ;
PROCESS_ELEMENT # ( .WIDTH(WIDTH)  , .WIDTH_SUM(WIDTH_SUM)  ) G8  ( CLK , RST , ENABLE , A_OUT_ROW_3 , B2x1           , A3x1 , B3x1 , C_OUT_3x1 , MULTI_OVER7 ) ;
PROCESS_ELEMENT # ( .WIDTH(WIDTH)  , .WIDTH_SUM(WIDTH_SUM)  ) G9  ( CLK , RST , ENABLE , A3x1        , B2x2           , A3x2 , B3x2 , C_OUT_3x2 , MULTI_OVER8 ) ;
PROCESS_ELEMENT # ( .WIDTH(WIDTH)  , .WIDTH_SUM(WIDTH_SUM)  ) G10 ( CLK , RST , ENABLE , A3x2        , B2x3           , A3x3 , B3x3 , C_OUT_3x3 , MULTI_OVER9 ) ;


assign MULTI_OVER = MULTI_OVER1 | MULTI_OVER2 | MULTI_OVER3 | MULTI_OVER4 | MULTI_OVER5 | MULTI_OVER6 | MULTI_OVER7 | MULTI_OVER8 | MULTI_OVER9 ;


endmodule


