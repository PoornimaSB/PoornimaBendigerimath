module parking_system(clk,reset,front_s,back_s, pass1, pass2,GREEN_LED,RED_LED);
input clk,reset;
input front_s,back_s;
input [1:0] pass1, pass2;
output wire GREEN_LED,RED_LED;
reg red_tmp,green_tmp;
output reg [6:0] HEX_1, HEX_2;

parameter RIGHT_PASS = 3'b000, WRONG_PASS = 3'b001,NEW_CAR_PASSWORD = 3'b010,STOP = 3'b100,STEADY = 3'b110;
 
 reg[2:0] cur_state, nxt_state;
 reg[31:0] count_wait;
 
 always @(posedge clk or negedge rst)
 begin
 if(~rst) 
 cur_state = STEADY;
 else
 cur_state = nxt_state;
 end
 
 always @(posedge clk or negedge rst) 
 begin
 if(~rst) 
 count_wait <= 0;
 else if(cur_state==NEW_CAR_PASSWORD)
 count_wait <= count_wait + 1;
 else 
 count_wait <= 0;
 end
 
 always @(*)
 begin
 case(cur_state)
STEADY: begin
         if(front_s== 1)
 nxt_state = NEW_CAR_PASSWORD;
 else
 nxt_state = STEADY;
 end
 NEW_CAR_PASSWORD: begin
 if(count_wait <= 3)
 net_state = NEW_CAR_PASSWORD;
 else 
 begin
 if((pass1==2'b01)&&(pass2==2'b10))
 nxt_state = RIGHT_PASS;
 else
 nxt_state = WRONG_PASS;
 end
 end
 WRONG_PASS: begin
 if((pass1==2'b01)&&(pass2==2'b10))
 nxt_state = RIGHT_PASS;
 else
 nxt_state = WRONG_PASS;
 end
 RIGHT_PASS: begin
 if(front_s==1 && back_s== 1)
 nxt_state = STOP;
 else if(back_s== 1)
 nxt_state = STEADY;
 else
 nxt_state = RIGHT_PASS;
 end
 STOP: begin
 if((pass1==2'b01)&&(pass2==2'b10))
 nxt_state = RIGHT_PASS;
 else
 nxt_state = STOP;
 end
 default: nxt_state = STAEDY;
 endcase
 end
 
 always @(posedge clk) begin 
 case(cur_state)
STAEDY: begin
 green_tmp = 1'b0;
 red_tmp = 1'b0;
 HEX_1 = 7'b1111111; // off
 HEX_2 = 7'b1111111; // off
 end
NEW_CAR_PASSWORD: begin
 HEX_1 = 7'b000_0110; 
 HEX_2 = 7'b010_1011; 
 end
 WRONG_PASS: begin
 green_tmp = 1'b0;
 red_tmp = ~red_tmp;
 HEX_1 = 7'b000_0110; 
 HEX_2 = 7'b000_0110; 
 end
 RIGHT_PASS: begin
 green_tmp = ~green_tmp;
 red_tmp = 1'b0; 
 HEX_1 = 7'b000_0010; // 6
 HEX_2 = 7'b100_0000; // 0 
 end
 STOP: begin
 green_tmp = 1'b0;
 red_tmp = ~red_tmp;
 HEX_1 = 7'b001_0010; // 5
 HEX_2 = 7'b000_1100; // P 
 end
 endcase
 end
 assign RED_LED = red_tmp  ;
 assign GREEN_LED = green_tmp;

endmodule



