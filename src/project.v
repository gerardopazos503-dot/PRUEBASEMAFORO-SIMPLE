`default_nettype none

module tt_um_semaforo (          // debe coincidir con top_module en info.yaml
    input  wire [7:0] ui_in,
    output wire [7:0] uo_out,
    input  wire [7:0] uio_in,
    output wire [7:0] uio_out,
    output wire [7:0] uio_oe,
    input  wire       ena,
    input  wire       clk,
    input  wire       rst_n
);
    wire x = ui_in[0];           // X: sentido de la secuencia
    reg  a, b;                   // estado en código Gray

    always @(posedge clk) begin
        if (!rst_n) begin
            a <= 1'b0;
            b <= 1'b0;
        end else begin
            a <= x ^ b;
            b <= ~(x ^ a);
        end
    end

    wire R = ~a & ~b;
    wire A =  a & ~b;
    wire V =  b;

    assign uo_out  = {5'b0, V, A, R};
    assign uio_out = 8'b0;
    assign uio_oe  = 8'b0;

    wire _unused = &{ena, ui_in[7:1], uio_in, 1'b0};
endmodule
