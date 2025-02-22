////////////////////////////////////////////////////////
//////////////// Module Difinition ///////////////////// 
////////////////////////////////////////////////////////

module SYSTOLIC_ARRAY_TB ();


////////////////////////////////////////////////////////
/////////////////// DUT Signals //////////////////////// 
////////////////////////////////////////////////////////

parameter WIDTH_SUM = 8 ;
parameter WIDTH = 12 ;

reg  ENABLE ;
reg  CLK  ;
reg  RST  ;

reg   [ WIDTH - 1 : 0 ]   A_ROW1    ;
reg   [ WIDTH - 1 : 0 ]   A_ROW2    ;
reg   [ WIDTH - 1 : 0 ]   A_ROW3    ; 

reg   [ WIDTH - 1 : 0 ]   B_COLOUM1    ;
reg   [ WIDTH - 1 : 0 ]   B_COLOUM2    ;
reg   [ WIDTH - 1 : 0 ]   B_COLOUM3    ;


wire   [ WIDTH_SUM - 1 : 0 ]    C_OUT_1x1   ;
wire   [ WIDTH_SUM - 1 : 0 ]    C_OUT_1x2   ;
wire   [ WIDTH_SUM - 1 : 0 ]    C_OUT_1x3   ;
wire   [ WIDTH_SUM - 1 : 0 ]    C_OUT_2x1   ;
wire   [ WIDTH_SUM - 1 : 0 ]    C_OUT_2x2   ;
wire   [ WIDTH_SUM - 1 : 0 ]    C_OUT_2x3   ;
wire   [ WIDTH_SUM - 1 : 0 ]    C_OUT_3x1   ;
wire   [ WIDTH_SUM - 1 : 0 ]    C_OUT_3x2   ;
wire   [ WIDTH_SUM - 1 : 0 ]    C_OUT_3x3   ;

wire    MULTI_OVER  ;

////////////////////////////////////////////////////////
/////////////////// DUT Instantation ///////////////////
////////////////////////////////////////////////////////

SYSTOLIC_ARRAY DUT ( CLK , RST , ENABLE , A_ROW1 , A_ROW2 , A_ROW3 , B_COLOUM1 , B_COLOUM2 , B_COLOUM3 , C_OUT_1x1 , 
                     C_OUT_1x2 , C_OUT_1x3 , C_OUT_2x1 , C_OUT_2x2 , C_OUT_2x3 , C_OUT_3x1 , C_OUT_3x2 , C_OUT_3x3 , MULTI_OVER ) ;


////////////////////////////////////////////////////////
////////////////// Clock Generator  ////////////////////
////////////////////////////////////////////////////////

always    #5       CLK = ~ CLK  ;

////////////////////////////////////////////////////////
////////////////// initial block /////////////////////// 
////////////////////////////////////////////////////////

initial 
begin
  CLK = 1'b 0 ;
  ENABLE = 1'b 1 ;
  RST = 1'b 0 ;  
  A_ROW1 = 12'b 0001_0010_0011  ;  A_ROW2 = 12'b 0100_0101_0110  ;  A_ROW3 = 12'b 0111_1000_1001  ; 
  B_COLOUM1 = 12'b 0001_0100_0111  ; B_COLOUM2 = 12'b 0010_0101_1000  ;  B_COLOUM3 = 12'b 0011_0110_1001  ;  #10
  RST = 1'b 1 ; #90 

  RST = 1'b 0 ; 
  A_ROW1 = 12'b 0111_0010_0010  ;  A_ROW2 = 12'b 0100_0000_1001  ;  A_ROW3 = 12'b 0111_1000_1001  ; 
  B_COLOUM1 = 12'b 1010_0100_0111  ; B_COLOUM2 = 12'b 0010_0101_1000  ;  B_COLOUM3 = 12'b 0100_1011_0010  ;  #10
  RST = 1'b 1 ; #95 $stop ;
end


endmodule
