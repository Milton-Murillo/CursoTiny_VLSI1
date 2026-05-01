`default_nettype none

module tt_um_example (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path
    input  wire       ena,      // Always 1 when powered
    input  wire       clk,      // Clock
    input  wire       rst_n     // Active-low reset
);

    // Señales internas
    wire        reg_load_i;
    wire        lfsr_enable_i;
    wire [7:0]  reg_data_o;
    wire        lfsr_done_o;

    // Asignación de entradas
    assign reg_load_i     = ui_in[0];
    assign lfsr_enable_i  = ena;

    // Asignación de salidas
    assign uo_out = reg_data_o;

    assign uio_out[0]   = lfsr_done_o;
    assign uio_out[7:1] = 7'b0;

    // Todos los uio se dejan como entradas
    assign uio_oe = 8'b0;

    // Entradas no usadas para evitar warnings
    wire _unused = &{ui_in[7:1], uio_in, 1'b0};

    tt_um_top_lfsr_register_8bit dut (
        .clk_i           (clk),
        .reset_n_i       (rst_n),
        .lfsr_enable_i   (lfsr_enable_i),
        .reg_load_i      (reg_load_i),
        .reg_data_o      (reg_data_o),
        .lfsr_done_o     (lfsr_done_o)
    );

endmodule
