
`default_nettype none

module tt_um_SEMAFORO (
    input  wire [7:0] ui_in,
    output wire [7:0] uo_out,
    input  wire [7:0] uio_in,
    output wire [7:0] uio_out,
    output wire [7:0] uio_oe,
    input  wire       ena,
    input  wire       clk,
    input  wire       rst_n
);

    // Selector de dirección
    wire X = ui_in[0];

    // Variables de estado
    reg a;
    reg b;

    // Siguiente estado
    wire a_next = X ^ b;
    wire b_next = ~(a ^ X);

    // Registros de estado
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            a <= 1'b0;
            b <= 1'b0;
        end else begin
            a <= a_next;
            b <= b_next;
        end
    end

    // Salidas originales del semáforo
    wire led_rojo     = ~a & ~b;
    wire led_amarillo =  a & ~b;
    wire led_verde    =  b;

    // Salidas generales
    assign uo_out[0] = led_verde;
    assign uo_out[1] = led_amarillo;
    assign uo_out[2] = led_rojo;
    assign uo_out[3] = 1'b0;
    assign uo_out[4] = 1'b0;
    assign uo_out[5] = 1'b0;
    assign uo_out[6] = 1'b0;
    assign uo_out[7] = 1'b0;
    
    assign uio_out[0] = 1'b0;
    assign uio_out[1] = 1'b0;
    assign uio_out[2] = 1'b0;
    assign uio_out[3] = 1'b0;
    assign uio_out[4] = 1'b0;
    assign uio_out[5] = 1'b0;
    assign uio_out[6] = 1'b0;
    assign uio_out[7] = 1'b0;
    
    assign uio_oe[0] = 1'b0;
    assign uio_oe[1] = 1'b0;
    assign uio_oe[2] = 1'b0;
    assign uio_oe[3] = 1'b0;
    assign uio_oe[4] = 1'b0;
    assign uio_oe[5] = 1'b0;
    assign uio_oe[6] = 1'b0;
    assign uio_oe[7] = 1'b0;

    // Señales no utilizadas
    wire _unused = &{ena, ui_in[7:1], uio_in, 1'b0};

endmodule

`default_nettype wire

