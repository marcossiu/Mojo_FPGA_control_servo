module message_printer (
    input clk,
    input rst,
    input [7:0] rx_data,
    input new_rx_data,
	 output step
);
 
reg [3:0] addr_d, addr_q;

reg [6:0] step_d, step;//, negative_step_size;

//NOVO
//wire pwm;
//assign step_size = 7'd15;
//assign negative_step_size = ~7'd15+1'b1;

 
always @(*) begin
    state_d = state_q; // default values
    addr_d = addr_q;   // needed to prevent latches
	 if (new_rx_data) begin
			if (rx_data == "+")
				step_d = 7'd20;
				
			if (rx_data == "-")
			   step_d = ~7'd20+1;
    end
    
end

assign step = step_d;
 
always @(posedge clk) begin
    if (rst) begin
        state_q <= IDLE;
    end else begin
        state_q <= state_d;
    end
    
	 addr_q <= addr_d;
end
 
endmodule

