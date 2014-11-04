module input_capture(
    input clk,
    input rst,
    output [3:0] channel,
    input new_sample,
    input [9:0] sample,
    input [3:0] sample_channel,
    output [7:0] led
);
 
assign channel = 4'd0; // only read A0
 
reg [6:0] sample_d, sample_q;
wire pwm;
 
pwm #(.CTR_LEN(20)) led_pwm ( // 10bit PWM
    .clk(clk),
    .rst(rst),
    .compare(sample_q),
    .pwm(pwm)
);
 
assign led = {8{pwm}}; // duplicate the PWM signal to each LED
 
always @(*) begin
    sample_d = sample_q;
 
    if (new_sample && sample_channel == 4'd0) // valid sample
        sample_d = ~sample[9:3];
end
 
always @(posedge clk) begin
    if (rst) begin
        sample_q <= 10'd0;
    end else begin
        sample_q <= sample_d;
    end
end
 
endmodule