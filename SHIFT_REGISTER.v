module SHIFT_REGISTER # ( parameter WIDTH = 4 , ROW = 3 , COLOUM = 3  ) (
  input             wire                                   CLK            ,
  input             wire                                   RST            ,
  input             wire                                   ENABLE         , 
  input             wire       [ ( WIDTH * COLOUM ) - 1 : 0 ]       A_IN_ROW_1           ,
  input             wire       [ ( WIDTH * COLOUM ) - 1 : 0 ]       A_IN_ROW_2           ,
  input             wire       [ ( WIDTH * COLOUM ) - 1 : 0 ]       A_IN_ROW_3           ,
  input             wire       [ ( WIDTH * ROW    ) - 1 : 0 ]       B_IN_COLOUM_1        ,
  input             wire       [ ( WIDTH * ROW    ) - 1 : 0 ]       B_IN_COLOUM_2        ,
  input             wire       [ ( WIDTH * ROW    ) - 1 : 0 ]       B_IN_COLOUM_3        ,
  output            reg        [ WIDTH - 1  : 0 ]       A_OUT_ROW_1          ,
  output            reg        [ WIDTH - 1  : 0 ]       A_OUT_ROW_2          ,
  output            reg        [ WIDTH - 1  : 0 ]       A_OUT_ROW_3          ,
  output            reg        [ WIDTH - 1  : 0 ]       B_OUT_COLOUM_1       ,  
  output            reg        [ WIDTH - 1  : 0 ]       B_OUT_COLOUM_2       , 
  output            reg        [ WIDTH - 1  : 0 ]       B_OUT_COLOUM_3            
);

parameter S0 = 3'b 000  ;
parameter S1 = 3'b 001  ;
parameter S2 = 3'b 010  ;
parameter S3 = 3'b 011  ;
parameter S4 = 3'b 100  ;
parameter S5 = 3'b 101  ;

reg  [ 2 : 0 ]  CURRENT_STATE   ;
reg  [ 2 : 0 ]  NEXT_STATE      ;

reg   [ ( WIDTH * COLOUM ) - 1 : 0 ]    A_WIRE_ROW_1      ;
reg   [ ( WIDTH * COLOUM ) - 1 : 0 ]    A_WIRE_ROW_2      ;
reg   [ ( WIDTH * COLOUM ) - 1 : 0 ]    A_WIRE_ROW_3      ;
reg   [ ( WIDTH * ROW    ) - 1 : 0 ]    B_WIRE_COLOUM_1   ;
reg   [ ( WIDTH * ROW    ) - 1 : 0 ]    B_WIRE_COLOUM_2   ;
reg   [ ( WIDTH * ROW    ) - 1 : 0 ]    B_WIRE_COLOUM_3   ; 


always @ ( posedge CLK or negedge RST )
begin
  if ( !RST )
    begin
      CURRENT_STATE = S0 ;
    end
  else if ( ENABLE )
    begin 
      CURRENT_STATE = NEXT_STATE ;
    end
  else
    begin
      CURRENT_STATE = S5 ;
    end
end

always @ ( * )
begin 
  case ( CURRENT_STATE )
  S0 : NEXT_STATE =  S1  ;
  S1 : NEXT_STATE =  S2  ;
  S2 : NEXT_STATE =  S3  ;
  S3 : NEXT_STATE =  S4  ;
  S4 : NEXT_STATE =  S4  ;
  S5 : NEXT_STATE =  NEXT_STATE  ;
  default : NEXT_STATE = S0 ;
  endcase
end

always @ ( posedge CLK or negedge RST )
begin
  case ( CURRENT_STATE )
  S0 :  begin
          A_OUT_ROW_1 = 4'b 0000  ;
          A_OUT_ROW_2 = 4'b 0000  ;
          A_OUT_ROW_3 = 4'b 0000  ;
          B_OUT_COLOUM_1 = 4'b 0000  ;
          B_OUT_COLOUM_2 = 4'b 0000  ;
          B_OUT_COLOUM_3 = 4'b 0000  ;
          A_WIRE_ROW_1     = 12'b 0000_0000_0000  ;
          A_WIRE_ROW_2     = 12'b 0000_0000_0000  ;
          A_WIRE_ROW_3     = 12'b 0000_0000_0000  ;
          B_WIRE_COLOUM_1  = 12'b 0000_0000_0000  ;
          B_WIRE_COLOUM_2  = 12'b 0000_0000_0000  ;
          B_WIRE_COLOUM_3  = 12'b 0000_0000_0000  ;
        end
    S1 :  begin
          A_WIRE_ROW_1     = A_IN_ROW_1     ;
          A_WIRE_ROW_2     = A_IN_ROW_2     ;
          A_WIRE_ROW_3     = A_IN_ROW_3     ;
          B_WIRE_COLOUM_1  = B_IN_COLOUM_1  ;
          B_WIRE_COLOUM_2  = B_IN_COLOUM_2  ;
          B_WIRE_COLOUM_3  = B_IN_COLOUM_3  ;
        end
  S2 :  begin
          A_OUT_ROW_1  = A_WIRE_ROW_1 [ 11 : 8 ]  ;
          A_WIRE_ROW_1 = { A_WIRE_ROW_1 , 4'b 0000 } ;
          B_OUT_COLOUM_1  = B_WIRE_COLOUM_1 [ 11 : 8 ]  ;
          B_WIRE_COLOUM_1 = { B_WIRE_COLOUM_1 , 4'b 0000 } ;
        end
  S3 :  begin
          
          A_OUT_ROW_1  = A_WIRE_ROW_1 [ 11 : 8 ]  ;
          A_WIRE_ROW_1 = { A_WIRE_ROW_1 , 4'b 0000 } ;
          A_OUT_ROW_2  = A_WIRE_ROW_2 [ 11 : 8 ]  ;
          A_WIRE_ROW_2 = { A_WIRE_ROW_2 , 4'b 0000 } ;
          B_OUT_COLOUM_1  = B_WIRE_COLOUM_1 [ 11 : 8 ]  ;
          B_WIRE_COLOUM_1 = { B_WIRE_COLOUM_1 , 4'b 0000 } ;
          B_OUT_COLOUM_2  = B_WIRE_COLOUM_2 [ 11 : 8 ] ;
          B_WIRE_COLOUM_2 = { B_WIRE_COLOUM_2 , 4'b 0000 } ;
        end
  S4 :  begin
          A_OUT_ROW_1  = A_WIRE_ROW_1 [ 11 : 8 ]  ;
          A_WIRE_ROW_1 = { A_WIRE_ROW_1 , 4'b 0000 } ;
          A_OUT_ROW_2  = A_WIRE_ROW_2 [ 11 : 8 ]  ;
          A_WIRE_ROW_2 = { A_WIRE_ROW_2 , 4'b 0000 } ;
          A_OUT_ROW_3  = A_WIRE_ROW_3 [ 11 : 8 ]  ;
          A_WIRE_ROW_3 = { A_WIRE_ROW_3 , 4'b 0000 } ;
          B_OUT_COLOUM_1  = B_WIRE_COLOUM_1 [ 11 : 8 ]  ;
          B_WIRE_COLOUM_1 = { B_WIRE_COLOUM_1 , 4'b 0000 } ;
          B_OUT_COLOUM_2  = B_WIRE_COLOUM_2 [ 11 : 8 ] ;
          B_WIRE_COLOUM_2 = { B_WIRE_COLOUM_2 , 4'b 0000 } ;
          B_OUT_COLOUM_3  = B_WIRE_COLOUM_3 [ 11 : 8 ]  ;
          B_WIRE_COLOUM_3 = { B_WIRE_COLOUM_3 , 4'b 0000 } ;
        end
  S5 :  begin
          A_OUT_ROW_1 = A_OUT_ROW_1  ;
          A_OUT_ROW_2 = A_OUT_ROW_2  ;
          A_OUT_ROW_3 = A_OUT_ROW_3  ;
          B_OUT_COLOUM_1 = B_OUT_COLOUM_1  ;
          B_OUT_COLOUM_2 = B_OUT_COLOUM_2  ;
          B_OUT_COLOUM_3 = B_OUT_COLOUM_3  ;
        end
  default : begin
          A_OUT_ROW_1 = 4'b 0000  ;
          A_OUT_ROW_2 = 4'b 0000  ;
          A_OUT_ROW_3 = 4'b 0000  ;
          B_OUT_COLOUM_1 = 4'b 0000  ;
          B_OUT_COLOUM_2 = 4'b 0000  ;
          B_OUT_COLOUM_3 = 4'b 0000  ;
          A_WIRE_ROW_1     = 12'b 0000_0000_0000  ;
          A_WIRE_ROW_2     = 12'b 0000_0000_0000  ;
          A_WIRE_ROW_3     = 12'b 0000_0000_0000  ;
          B_WIRE_COLOUM_1  = 12'b 0000_0000_0000  ;
          B_WIRE_COLOUM_2  = 12'b 0000_0000_0000  ;
          B_WIRE_COLOUM_3  = 12'b 0000_0000_0000  ;
        end
  endcase
end

endmodule

