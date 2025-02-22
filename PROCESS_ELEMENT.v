module PROCESS_ELEMENT # ( parameter WIDTH = 4 , WIDTH_SUM = 8  ) (
  input             wire                                   CLK            ,
  input             wire                                   RST            ,
  input             wire                                   ENABLE         , 
  input             wire       [ WIDTH - 1     : 0 ]       A_IN           ,
  input             wire       [ WIDTH - 1     : 0 ]       B_IN           ,
  output            reg        [ WIDTH - 1     : 0 ]       A_OUT          ,
  output            reg        [ WIDTH - 1     : 0 ]       B_OUT          ,   
  output            reg        [ WIDTH_SUM - 1 : 0 ]       SUM            ,
  output            reg                                    MULTI_OVER     
);

parameter S0 = 2'b 00  ;
parameter S1 = 2'b 01  ;
parameter S2 = 2'b 10  ;

reg  [ 1 : 0 ]  CURRENT_STATE   ;
reg  [ 1 : 0 ]  NEXT_STATE      ;

reg   [ WIDTH_SUM - 1 : 0 ]  MULTIPLICATION  ;

always @ ( posedge CLK or negedge RST )
begin
  if ( !RST )
    begin
      CURRENT_STATE = S0  ;
    end
  else 
    begin
      CURRENT_STATE = NEXT_STATE  ;
    end   
end


always @ ( * )
begin
  case ( CURRENT_STATE )
  S0      :   NEXT_STATE = ( ENABLE == 1 ) ? S1 : S2 ;
  S1      :   NEXT_STATE = ( ENABLE == 1 ) ? S1 : S2 ;
  S2      :   NEXT_STATE = ( ENABLE == 1 ) ? S1 : S2 ;
  default :   NEXT_STATE = S0  ;
  endcase
end


always @ ( posedge CLK or negedge RST  )
begin
  case ( CURRENT_STATE )
  S0 :  begin
           A_OUT  <= 4'b 0000  ;
           B_OUT  <= 4'b 0000  ;
           SUM    <= 4'b 0000  ;
           MULTIPLICATION <= 8'b 0000_0000 ;
           MULTI_OVER <= 1'b 0 ;
        end
  S1 :  begin
           MULTIPLICATION = A_IN * B_IN    ;
          { MULTI_OVER , SUM }  <= SUM +  MULTIPLICATION   ;
           A_OUT  <=  A_IN ;
           B_OUT  <=  B_IN ;
        end
  S2 :  begin
           A_OUT <= A_OUT ;
           B_OUT <= B_OUT ;
        end
  default : begin
           A_OUT  <= 4'b 0000  ;
           B_OUT  <= 4'b 0000  ;
           SUM    <= 4'b 0000  ;
           MULTIPLICATION <= 8'b 0000_0000 ;
           MULTI_OVER <= 1'b 0 ;
        end
  endcase
end

endmodule

