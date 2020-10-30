// SPDX-License-Identifier: Apache-2.0
// Copyright 2019,2020 Western Digital Corporation or its affiliates.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
`ifdef VERILATOR
module tb_top ( input bit core_clk );
`else
module tb_top;
    bit                         core_clk;
`endif
    logic                       rst_l;
    logic                       porst_l;
    logic                       nmi_int;

    logic        [31:0]         reset_vector;
    logic        [31:0]         nmi_vector;
    logic        [31:1]         jtag_id;


    logic [`RV_NUM_THREADS-1:0][63:0]    trace_rv_i_insn_ip;
    logic [`RV_NUM_THREADS-1:0][63:0]    trace_rv_i_address_ip;
    logic [`RV_NUM_THREADS-1:0][2:0]     trace_rv_i_valid_ip;
    logic [`RV_NUM_THREADS-1:0][2:0]     trace_rv_i_exception_ip;
    logic [`RV_NUM_THREADS-1:0][4:0]     trace_rv_i_ecause_ip;
    logic [`RV_NUM_THREADS-1:0][2:0]     trace_rv_i_interrupt_ip;
    logic [`RV_NUM_THREADS-1:0][31:0]    trace_rv_i_tval_ip;

    logic                       o_debug_mode_status;


    logic                       jtag_tdo;
    logic                       o_cpu_halt_ack;
    logic                       o_cpu_halt_status;
    logic                       o_cpu_run_ack;

    logic                       mailbox_write;
    logic        [63:0]         dma_hrdata;
    logic        [63:0]         dma_hwdata;
    logic                       dma_hready;
    logic                       dma_hresp;

    logic                       mpc_debug_halt_req;
    logic                       mpc_debug_run_req;
    logic                       mpc_reset_run_req;
    logic                       mpc_debug_halt_ack;
    logic                       mpc_debug_run_ack;
    logic                       debug_brkpt_status;

    bit        [31:0]           cycleCnt;
    logic                       mailbox_data_val;

    wire                        dma_hready_out;
    int                         commit_count[2];

    logic [1:0]                 wb_valid;
    logic [1:0][4:0]            wb_dest;
    logic [1:0][31:0]           wb_data;
    logic [1:0]                 wb_tid;

   //-------------------------- LSU AXI signals--------------------------
   // AXI Write Channels
    wire                        lsu_axi_awvalid;
    wire                        lsu_axi_awready;
    wire [`RV_LSU_BUS_TAG-1:0]  lsu_axi_awid;
    wire [31:0]                 lsu_axi_awaddr;
    wire [3:0]                  lsu_axi_awregion;
    wire [7:0]                  lsu_axi_awlen;
    wire [2:0]                  lsu_axi_awsize;
    wire [1:0]                  lsu_axi_awburst;
    wire                        lsu_axi_awlock;
    wire [3:0]                  lsu_axi_awcache;
    wire [2:0]                  lsu_axi_awprot;
    wire [3:0]                  lsu_axi_awqos;

    wire                        lsu_axi_wvalid;
    wire                        lsu_axi_wready;
    wire [63:0]                 lsu_axi_wdata;
    wire [7:0]                  lsu_axi_wstrb;
    wire                        lsu_axi_wlast;

    wire                        lsu_axi_bvalid;
    wire                        lsu_axi_bready;
    wire [1:0]                  lsu_axi_bresp;
    wire [`RV_LSU_BUS_TAG-1:0]  lsu_axi_bid;

    // AXI Read Channels
    wire                        lsu_axi_arvalid;
    wire                        lsu_axi_arready;
    wire [`RV_LSU_BUS_TAG-1:0]  lsu_axi_arid;
    wire [31:0]                 lsu_axi_araddr;
    wire [3:0]                  lsu_axi_arregion;
    wire [7:0]                  lsu_axi_arlen;
    wire [2:0]                  lsu_axi_arsize;
    wire [1:0]                  lsu_axi_arburst;
    wire                        lsu_axi_arlock;
    wire [3:0]                  lsu_axi_arcache;
    wire [2:0]                  lsu_axi_arprot;
    wire [3:0]                  lsu_axi_arqos;

    wire                        lsu_axi_rvalid;
    wire                        lsu_axi_rready;
    wire [`RV_LSU_BUS_TAG-1:0]  lsu_axi_rid;
    wire [63:0]                 lsu_axi_rdata;
    wire [1:0]                  lsu_axi_rresp;
    wire                        lsu_axi_rlast;

    //-------------------------- IFU AXI signals--------------------------
    // AXI Write Channels
    wire                        ifu_axi_awvalid;
    wire                        ifu_axi_awready;
    wire [`RV_IFU_BUS_TAG-1:0]  ifu_axi_awid;
    wire [31:0]                 ifu_axi_awaddr;
    wire [3:0]                  ifu_axi_awregion;
    wire [7:0]                  ifu_axi_awlen;
    wire [2:0]                  ifu_axi_awsize;
    wire [1:0]                  ifu_axi_awburst;
    wire                        ifu_axi_awlock;
    wire [3:0]                  ifu_axi_awcache;
    wire [2:0]                  ifu_axi_awprot;
    wire [3:0]                  ifu_axi_awqos;

    wire                        ifu_axi_wvalid;
    wire                        ifu_axi_wready;
    wire [63:0]                 ifu_axi_wdata;
    wire [7:0]                  ifu_axi_wstrb;
    wire                        ifu_axi_wlast;

    wire                        ifu_axi_bvalid;
    wire                        ifu_axi_bready;
    wire [1:0]                  ifu_axi_bresp;
    wire [`RV_IFU_BUS_TAG-1:0]  ifu_axi_bid;

    // AXI Read Channels
    wire                        ifu_axi_arvalid;
    wire                        ifu_axi_arready;
    wire [`RV_IFU_BUS_TAG-1:0]  ifu_axi_arid;
    wire [31:0]                 ifu_axi_araddr;
    wire [3:0]                  ifu_axi_arregion;
    wire [7:0]                  ifu_axi_arlen;
    wire [2:0]                  ifu_axi_arsize;
    wire [1:0]                  ifu_axi_arburst;
    wire                        ifu_axi_arlock;
    wire [3:0]                  ifu_axi_arcache;
    wire [2:0]                  ifu_axi_arprot;
    wire [3:0]                  ifu_axi_arqos;

    wire                        ifu_axi_rvalid;
    wire                        ifu_axi_rready;
    wire [`RV_IFU_BUS_TAG-1:0]  ifu_axi_rid;
    wire [63:0]                 ifu_axi_rdata;
    wire [1:0]                  ifu_axi_rresp;
    wire                        ifu_axi_rlast;

    //-------------------------- SB AXI signals--------------------------
    // AXI Write Channels
    wire                        sb_axi_awvalid;
    wire                        sb_axi_awready;
    wire [`RV_SB_BUS_TAG-1:0]   sb_axi_awid;
    wire [31:0]                 sb_axi_awaddr;
    wire [3:0]                  sb_axi_awregion;
    wire [7:0]                  sb_axi_awlen;
    wire [2:0]                  sb_axi_awsize;
    wire [1:0]                  sb_axi_awburst;
    wire                        sb_axi_awlock;
    wire [3:0]                  sb_axi_awcache;
    wire [2:0]                  sb_axi_awprot;
    wire [3:0]                  sb_axi_awqos;

    wire                        sb_axi_wvalid;
    wire                        sb_axi_wready;
    wire [63:0]                 sb_axi_wdata;
    wire [7:0]                  sb_axi_wstrb;
    wire                        sb_axi_wlast;

    wire                        sb_axi_bvalid;
    wire                        sb_axi_bready;
    wire [1:0]                  sb_axi_bresp;
    wire [`RV_SB_BUS_TAG-1:0]   sb_axi_bid;

    // AXI Read Channels
    wire                        sb_axi_arvalid;
    wire                        sb_axi_arready;
    wire [`RV_SB_BUS_TAG-1:0]   sb_axi_arid;
    wire [31:0]                 sb_axi_araddr;
    wire [3:0]                  sb_axi_arregion;
    wire [7:0]                  sb_axi_arlen;
    wire [2:0]                  sb_axi_arsize;
    wire [1:0]                  sb_axi_arburst;
    wire                        sb_axi_arlock;
    wire [3:0]                  sb_axi_arcache;
    wire [2:0]                  sb_axi_arprot;
    wire [3:0]                  sb_axi_arqos;

    wire                        sb_axi_rvalid;
    wire                        sb_axi_rready;
    wire [`RV_SB_BUS_TAG-1:0]   sb_axi_rid;
    wire [63:0]                 sb_axi_rdata;
    wire [1:0]                  sb_axi_rresp;
    wire                        sb_axi_rlast;

   //-------------------------- DMA AXI signals--------------------------
   // AXI Write Channels
    wire                        dma_axi_awvalid;
    wire                        dma_axi_awready;
    wire [`RV_DMA_BUS_TAG-1:0]  dma_axi_awid;
    wire [31:0]                 dma_axi_awaddr;
    wire [2:0]                  dma_axi_awsize;
    wire [2:0]                  dma_axi_awprot;
    wire [7:0]                  dma_axi_awlen;
    wire [1:0]                  dma_axi_awburst;


    wire                        dma_axi_wvalid;
    wire                        dma_axi_wready;
    wire [63:0]                 dma_axi_wdata;
    wire [7:0]                  dma_axi_wstrb;
    wire                        dma_axi_wlast;

    wire                        dma_axi_bvalid;
    wire                        dma_axi_bready;
    wire [1:0]                  dma_axi_bresp;
    wire [`RV_DMA_BUS_TAG-1:0]  dma_axi_bid;

    // AXI Read Channels
    wire                        dma_axi_arvalid;
    wire                        dma_axi_arready;
    wire [`RV_DMA_BUS_TAG-1:0]  dma_axi_arid;
    wire [31:0]                 dma_axi_araddr;
    wire [2:0]                  dma_axi_arsize;
    wire [2:0]                  dma_axi_arprot;
    wire [7:0]                  dma_axi_arlen;
    wire [1:0]                  dma_axi_arburst;

    wire                        dma_axi_rvalid;
    wire                        dma_axi_rready;
    wire [`RV_DMA_BUS_TAG-1:0]  dma_axi_rid;
    wire [63:0]                 dma_axi_rdata;
    wire [1:0]                  dma_axi_rresp;
    wire                        dma_axi_rlast;

    wire                        lmem_axi_arvalid;
    wire                        lmem_axi_arready;

    wire                        lmem_axi_rvalid;
    wire [`RV_LSU_BUS_TAG-1:0]  lmem_axi_rid;
    wire [1:0]                  lmem_axi_rresp;
    wire [63:0]                 lmem_axi_rdata;
    wire                        lmem_axi_rlast;
    wire                        lmem_axi_rready;

    wire                        lmem_axi_awvalid;
    wire                        lmem_axi_awready;

    wire                        lmem_axi_wvalid;
    wire                        lmem_axi_wready;

    wire [1:0]                  lmem_axi_bresp;
    wire                        lmem_axi_bvalid;
    wire [`RV_LSU_BUS_TAG-1:0]  lmem_axi_bid;
    wire                        lmem_axi_bready;


    wire[63:0] WriteData;


    assign mailbox_write = lmem.mailbox_write;
    assign WriteData = lmem.WriteData;
    assign mailbox_data_val = WriteData[7:0] > 8'h5 && WriteData[7:0] < 8'h7f;

wire [31:0] minstret[2], mcycle[2];
assign minstret[0] = rvtop.swerv.dec.tlu.tlumt[0].tlu.minstretl;
assign mcycle[0]   = rvtop.swerv.dec.tlu.tlumt[0].tlu.mcyclel;
assign minstret[1] = rvtop.swerv.dec.tlu.tlumt[`RV_NUM_THREADS-1].tlu.minstretl;
assign mcycle[1]   = rvtop.swerv.dec.tlu.tlumt[`RV_NUM_THREADS-1].tlu.mcyclel;


    parameter MAX_CYCLES = 10_000_000;

    integer fd, tp, el;

    always @(negedge core_clk) begin
        cycleCnt <= cycleCnt+1;
        // Test timeout monitor
        if(cycleCnt == MAX_CYCLES) begin
            $display ("Hit max cycle count (%0d) .. stopping",cycleCnt);
            $finish;
        end
        // console Monitor
        if( mailbox_data_val & mailbox_write) begin
            $fwrite(fd,"%c", WriteData[7:0]);
            $write("%c", WriteData[7:0]);
        end
        // End Of test monitor
        if(mailbox_write && WriteData[7:0] == 8'hff) begin
            $display("TEST_PASSED");
            $display("\nFinished hart0 : minstret = %0d, mcycle = %0d", minstret[0],mcycle[0]);
            if(`RV_NUM_THREADS == 2)
                $display("Finished hart1 : minstret = %0d, mcycle = %0d", minstret[1], mcycle[1]);
            $display("See \"exec.log\" for execution trace with register updates..\n");
            $finish;
        end
        else if(mailbox_write && WriteData[7:0] == 8'h1) begin
            $display("TEST_FAILED");
            $finish;
        end
    end


    // trace monitor
    always @(posedge core_clk) begin
         wb_valid[1:0]  <= '{rvtop.swerv.dec.dec_i1_wen_wb,   rvtop.swerv.dec.dec_i0_wen_wb};
         wb_dest        <= '{rvtop.swerv.dec.dec_i1_waddr_wb, rvtop.swerv.dec.dec_i0_waddr_wb};
         wb_data        <= '{rvtop.swerv.dec.dec_i1_wdata_wb, rvtop.swerv.dec.dec_i0_wdata_wb};
         wb_tid         <= '{rvtop.swerv.dec.dec_i1_tid_wb,   rvtop.swerv.dec.dec_i0_tid_wb};
         for(int t=0; t<`RV_NUM_THREADS; t++)
             if (trace_rv_i_valid_ip[t] !== 0) begin
                $fwrite(tp,"t%0d %b,%h,%h,%0h,%0h,3,%b,%h,%h,%b\n",t, trace_rv_i_valid_ip[t], trace_rv_i_address_ip[t][63:32], trace_rv_i_address_ip[t][31:0],
                       trace_rv_i_insn_ip[t][63:32], trace_rv_i_insn_ip[t][31:0],trace_rv_i_exception_ip[t],trace_rv_i_ecause_ip[t],
                       trace_rv_i_tval_ip[t],trace_rv_i_interrupt_ip[t]);
                // Basic trace - no exception register updates
                // #1 0 ee000000 b0201073 c 0b02       00000000
                for (int i=0; i<2; i++)
                    if (trace_rv_i_valid_ip[t][i]==1) begin
                        bit i0;
                        i0 = i != 0 || trace_rv_i_valid_ip[t]!=3 && wb_tid[1] == t && wb_valid[1];
                        commit_count[t]++;
                        $fwrite (el, "%10d : %6s %0d %h %h %s\n",cycleCnt, $sformatf("#%0d",commit_count[t]), t,
                               trace_rv_i_address_ip[t][31+i*32 -:32], trace_rv_i_insn_ip[t][31+i*32-:32],
                               (wb_dest[i0] !=0 && wb_valid[i0]) ?  $sformatf("r%0d=%h", wb_dest[i0], wb_data[i0]) : "");
                    end
            end
    end


    initial begin
    // tie offs
        jtag_id[31:28] = 4'b1;
        jtag_id[27:12] = '0;
        jtag_id[11:1]  = 11'h45;
        reset_vector = 32'h0;
        nmi_vector   = 32'hee000000;
        nmi_int   = 0;

        $readmemh("data.hex",     lmem.mem);
        $readmemh("program.hex",  imem.mem);
        tp = $fopen("trace_port.csv","w");
        el = $fopen("exec.log","w");
        $fwrite (el, "//Cycle : #inst 0  pc opcode reg regnum value\n");
        fd = $fopen("console.log","w");
        preload_dccm();
        preload_iccm();

`ifndef VERILATOR
        if($test$plusargs("dumpon")) $dumpvars;
        forever  core_clk = #5 ~core_clk;
`endif
    end


    assign rst_l = cycleCnt > 5;
    assign porst_l = cycleCnt > 2;

   //=========================================================================-
   // RTL instance
   //=========================================================================-
eh2_swerv_wrapper rvtop (
    .rst_l                  ( rst_l         ),
    .dbg_rst_l              ( porst_l       ),
    .clk                    ( core_clk      ),
    .rst_vec                ( reset_vector[31:1]),
    .nmi_int                ( nmi_int       ),
    .nmi_vec                ( nmi_vector[31:1]),
    .jtag_id                ( jtag_id[31:1]),

    //-------------------------- LSU AXI signals--------------------------
    // AXI Write Channels
    .lsu_axi_awvalid        (lsu_axi_awvalid),
    .lsu_axi_awready        (lsu_axi_awready),
    .lsu_axi_awid           (lsu_axi_awid),
    .lsu_axi_awaddr         (lsu_axi_awaddr),
    .lsu_axi_awregion       (lsu_axi_awregion),
    .lsu_axi_awlen          (lsu_axi_awlen),
    .lsu_axi_awsize         (lsu_axi_awsize),
    .lsu_axi_awburst        (lsu_axi_awburst),
    .lsu_axi_awlock         (lsu_axi_awlock),
    .lsu_axi_awcache        (lsu_axi_awcache),
    .lsu_axi_awprot         (lsu_axi_awprot),
    .lsu_axi_awqos          (lsu_axi_awqos),

    .lsu_axi_wvalid         (lsu_axi_wvalid),
    .lsu_axi_wready         (lsu_axi_wready),
    .lsu_axi_wdata          (lsu_axi_wdata),
    .lsu_axi_wstrb          (lsu_axi_wstrb),
    .lsu_axi_wlast          (lsu_axi_wlast),

    .lsu_axi_bvalid         (lsu_axi_bvalid),
    .lsu_axi_bready         (lsu_axi_bready),
    .lsu_axi_bresp          (lsu_axi_bresp),
    .lsu_axi_bid            (lsu_axi_bid),


    .lsu_axi_arvalid        (lsu_axi_arvalid),
    .lsu_axi_arready        (lsu_axi_arready),
    .lsu_axi_arid           (lsu_axi_arid),
    .lsu_axi_araddr         (lsu_axi_araddr),
    .lsu_axi_arregion       (lsu_axi_arregion),
    .lsu_axi_arlen          (lsu_axi_arlen),
    .lsu_axi_arsize         (lsu_axi_arsize),
    .lsu_axi_arburst        (lsu_axi_arburst),
    .lsu_axi_arlock         (lsu_axi_arlock),
    .lsu_axi_arcache        (lsu_axi_arcache),
    .lsu_axi_arprot         (lsu_axi_arprot),
    .lsu_axi_arqos          (lsu_axi_arqos),

    .lsu_axi_rvalid         (lsu_axi_rvalid),
    .lsu_axi_rready         (lsu_axi_rready),
    .lsu_axi_rid            (lsu_axi_rid),
    .lsu_axi_rdata          (lsu_axi_rdata),
    .lsu_axi_rresp          (lsu_axi_rresp),
    .lsu_axi_rlast          (lsu_axi_rlast),

    //-------------------------- IFU AXI signals--------------------------
    // AXI Write Channels
    .ifu_axi_awvalid        (ifu_axi_awvalid),
    .ifu_axi_awready        (ifu_axi_awready),
    .ifu_axi_awid           (ifu_axi_awid),
    .ifu_axi_awaddr         (ifu_axi_awaddr),
    .ifu_axi_awregion       (ifu_axi_awregion),
    .ifu_axi_awlen          (ifu_axi_awlen),
    .ifu_axi_awsize         (ifu_axi_awsize),
    .ifu_axi_awburst        (ifu_axi_awburst),
    .ifu_axi_awlock         (ifu_axi_awlock),
    .ifu_axi_awcache        (ifu_axi_awcache),
    .ifu_axi_awprot         (ifu_axi_awprot),
    .ifu_axi_awqos          (ifu_axi_awqos),

    .ifu_axi_wvalid         (ifu_axi_wvalid),
    .ifu_axi_wready         (ifu_axi_wready),
    .ifu_axi_wdata          (ifu_axi_wdata),
    .ifu_axi_wstrb          (ifu_axi_wstrb),
    .ifu_axi_wlast          (ifu_axi_wlast),

    .ifu_axi_bvalid         (ifu_axi_bvalid),
    .ifu_axi_bready         (ifu_axi_bready),
    .ifu_axi_bresp          (ifu_axi_bresp),
    .ifu_axi_bid            (ifu_axi_bid),

    .ifu_axi_arvalid        (ifu_axi_arvalid),
    .ifu_axi_arready        (ifu_axi_arready),
    .ifu_axi_arid           (ifu_axi_arid),
    .ifu_axi_araddr         (ifu_axi_araddr),
    .ifu_axi_arregion       (ifu_axi_arregion),
    .ifu_axi_arlen          (ifu_axi_arlen),
    .ifu_axi_arsize         (ifu_axi_arsize),
    .ifu_axi_arburst        (ifu_axi_arburst),
    .ifu_axi_arlock         (ifu_axi_arlock),
    .ifu_axi_arcache        (ifu_axi_arcache),
    .ifu_axi_arprot         (ifu_axi_arprot),
    .ifu_axi_arqos          (ifu_axi_arqos),

    .ifu_axi_rvalid         (ifu_axi_rvalid),
    .ifu_axi_rready         (ifu_axi_rready),
    .ifu_axi_rid            (ifu_axi_rid),
    .ifu_axi_rdata          (ifu_axi_rdata),
    .ifu_axi_rresp          (ifu_axi_rresp),
    .ifu_axi_rlast          (ifu_axi_rlast),

    //-------------------------- SB AXI signals--------------------------
    // AXI Write Channels
    .sb_axi_awvalid         (sb_axi_awvalid),
    .sb_axi_awready         (sb_axi_awready),
    .sb_axi_awid            (sb_axi_awid),
    .sb_axi_awaddr          (sb_axi_awaddr),
    .sb_axi_awregion        (sb_axi_awregion),
    .sb_axi_awlen           (sb_axi_awlen),
    .sb_axi_awsize          (sb_axi_awsize),
    .sb_axi_awburst         (sb_axi_awburst),
    .sb_axi_awlock          (sb_axi_awlock),
    .sb_axi_awcache         (sb_axi_awcache),
    .sb_axi_awprot          (sb_axi_awprot),
    .sb_axi_awqos           (sb_axi_awqos),

    .sb_axi_wvalid          (sb_axi_wvalid),
    .sb_axi_wready          (sb_axi_wready),
    .sb_axi_wdata           (sb_axi_wdata),
    .sb_axi_wstrb           (sb_axi_wstrb),
    .sb_axi_wlast           (sb_axi_wlast),

    .sb_axi_bvalid          (sb_axi_bvalid),
    .sb_axi_bready          (sb_axi_bready),
    .sb_axi_bresp           (sb_axi_bresp),
    .sb_axi_bid             (sb_axi_bid),


    .sb_axi_arvalid         (sb_axi_arvalid),
    .sb_axi_arready         (sb_axi_arready),
    .sb_axi_arid            (sb_axi_arid),
    .sb_axi_araddr          (sb_axi_araddr),
    .sb_axi_arregion        (sb_axi_arregion),
    .sb_axi_arlen           (sb_axi_arlen),
    .sb_axi_arsize          (sb_axi_arsize),
    .sb_axi_arburst         (sb_axi_arburst),
    .sb_axi_arlock          (sb_axi_arlock),
    .sb_axi_arcache         (sb_axi_arcache),
    .sb_axi_arprot          (sb_axi_arprot),
    .sb_axi_arqos           (sb_axi_arqos),

    .sb_axi_rvalid          (sb_axi_rvalid),
    .sb_axi_rready          (sb_axi_rready),
    .sb_axi_rid             (sb_axi_rid),
    .sb_axi_rdata           (sb_axi_rdata),
    .sb_axi_rresp           (sb_axi_rresp),
    .sb_axi_rlast           (sb_axi_rlast),

    //-------------------------- DMA AXI signals--------------------------
    // AXI Write Channels
    .dma_axi_awvalid        (dma_axi_awvalid),
    .dma_axi_awready        (dma_axi_awready),
    .dma_axi_awid           ('0),
    .dma_axi_awaddr         (lsu_axi_awaddr),
    .dma_axi_awsize         (lsu_axi_awsize),
    .dma_axi_awprot         (lsu_axi_awprot),
    .dma_axi_awlen          (lsu_axi_awlen),
    .dma_axi_awburst        (lsu_axi_awburst),


    .dma_axi_wvalid         (dma_axi_wvalid),
    .dma_axi_wready         (dma_axi_wready),
    .dma_axi_wdata          (lsu_axi_wdata),
    .dma_axi_wstrb          (lsu_axi_wstrb),
    .dma_axi_wlast          (lsu_axi_wlast),

    .dma_axi_bvalid         (dma_axi_bvalid),
    .dma_axi_bready         (dma_axi_bready),
    .dma_axi_bresp          (dma_axi_bresp),
    .dma_axi_bid            (),


    .dma_axi_arvalid        (dma_axi_arvalid),
    .dma_axi_arready        (dma_axi_arready),
    .dma_axi_arid           ('0),
    .dma_axi_araddr         (lsu_axi_araddr),
    .dma_axi_arsize         (lsu_axi_arsize),
    .dma_axi_arprot         (lsu_axi_arprot),
    .dma_axi_arlen          (lsu_axi_arlen),
    .dma_axi_arburst        (lsu_axi_arburst),

    .dma_axi_rvalid         (dma_axi_rvalid),
    .dma_axi_rready         (dma_axi_rready),
    .dma_axi_rid            (),
    .dma_axi_rdata          (dma_axi_rdata),
    .dma_axi_rresp          (dma_axi_rresp),
    .dma_axi_rlast          (dma_axi_rlast),

    .timer_int              ( '0  ),
    .extintsrc_req          ( '0  ),

    .lsu_bus_clk_en         ( 1'b1  ),// Clock ratio b/w cpu core clk & AHB master interface
    .ifu_bus_clk_en         ( 1'b1  ),// Clock ratio b/w cpu core clk & AHB master interface
    .dbg_bus_clk_en         ( 1'b1  ),// Clock ratio b/w cpu core clk & AHB Debug master interface
    .dma_bus_clk_en         ( 1'b1  ),// Clock ratio b/w cpu core clk & AHB slave interface

    .trace_rv_i_insn_ip     (trace_rv_i_insn_ip),
    .trace_rv_i_address_ip  (trace_rv_i_address_ip),
    .trace_rv_i_valid_ip    (trace_rv_i_valid_ip),
    .trace_rv_i_exception_ip(trace_rv_i_exception_ip),
    .trace_rv_i_ecause_ip   (trace_rv_i_ecause_ip),
    .trace_rv_i_interrupt_ip(trace_rv_i_interrupt_ip),
    .trace_rv_i_tval_ip     (trace_rv_i_tval_ip),

    .jtag_tck               ( 1'b0  ),
    .jtag_tms               ( 1'b0  ),
    .jtag_tdi               ( 1'b0  ),
    .jtag_trst_n            ( 1'b0  ),
    .jtag_tdo               ( jtag_tdo ),

    .mpc_debug_halt_ack     ( ),
    .mpc_debug_halt_req     ('0),
    .mpc_debug_run_ack      (),
    .mpc_debug_run_req      ('1),
    .mpc_reset_run_req      ('1),             // Start running after reset
     .debug_brkpt_status    (),

    .i_cpu_halt_req         ('0),    // Async halt req to CPU
    .o_cpu_halt_ack         (),        // core response to halt
    .o_cpu_halt_status      (),        // 1'b1 indicates core is halted
    .i_cpu_run_req          ('0),    // Async restart req to CPU
    .o_debug_mode_status    (),
    .o_cpu_run_ack          (),     // Core response to run req

    .dec_tlu_perfcnt0       (),
    .dec_tlu_perfcnt1       (),
    .dec_tlu_perfcnt2       (),
    .dec_tlu_perfcnt3       (),
    .dec_tlu_mhartstart     (),

    .soft_int               ('0),
    .core_id                ('0),
    .scan_mode              ( 1'b0 ),         // To enable scan mode
    .mbist_mode             ( 1'b0 )        // to enable mbist

);

axi_slv #(.TAGW(`RV_IFU_BUS_TAG)) imem(
    .aclk(core_clk),
    .rst_l(rst_l),
    .arvalid(ifu_axi_arvalid),
    .arready(ifu_axi_arready),
    .araddr(ifu_axi_araddr),
    .arid(ifu_axi_arid),
    .arlen(ifu_axi_arlen),
    .arburst(ifu_axi_arburst),
    .arsize(ifu_axi_arsize),

    .rvalid(ifu_axi_rvalid),
    .rready(ifu_axi_rready),
    .rdata(ifu_axi_rdata),
    .rresp(ifu_axi_rresp),
    .rid(ifu_axi_rid),
    .rlast(ifu_axi_rlast),

    .awvalid(1'b0),
    .awready(),
    .awaddr('0),
    .awid('0),
    .awlen('0),
    .awburst('0),
    .awsize('0),

    .wdata('0),
    .wstrb('0),
    .wvalid(1'b0),
    .wready(),

    .bvalid(),
    .bready(1'b0),
    .bresp(),
    .bid()
);


axi_slv #(.TAGW(`RV_LSU_BUS_TAG)) lmem(
    .aclk(core_clk),
    .rst_l(rst_l),
    .arvalid(lmem_axi_arvalid),
    .arready(lmem_axi_arready),
    .araddr(lsu_axi_araddr),
    .arid(lsu_axi_arid),
    .arlen(lsu_axi_arlen),
    .arburst(lsu_axi_arburst),
    .arsize(lsu_axi_arsize),

    .rvalid(lmem_axi_rvalid),
    .rready(lmem_axi_rready),
    .rdata(lmem_axi_rdata),
    .rresp(lmem_axi_rresp),
    .rid(lmem_axi_rid),
    .rlast(lmem_axi_rlast),

    .awvalid(lmem_axi_awvalid),
    .awready(lmem_axi_awready),
    .awaddr(lsu_axi_awaddr),
    .awid(lsu_axi_awid),
    .awlen(lsu_axi_awlen),
    .awburst(lsu_axi_awburst),
    .awsize(lsu_axi_awsize),

    .wdata(lsu_axi_wdata),
    .wstrb(lsu_axi_wstrb),
    .wvalid(lmem_axi_wvalid),
    .wready(lmem_axi_wready),

    .bvalid(lmem_axi_bvalid),
    .bready(lmem_axi_bready),
    .bresp(lmem_axi_bresp),
    .bid(lmem_axi_bid)
);


axi_lsu_dma_bridge # (`RV_LSU_BUS_TAG,`RV_LSU_BUS_TAG ) bridge(
    .clk(core_clk),
    .reset_l(rst_l),

    .m_arvalid(lsu_axi_arvalid),
    .m_arid(lsu_axi_arid),
    .m_araddr(lsu_axi_araddr),
    .m_arready(lsu_axi_arready),

    .m_rvalid(lsu_axi_rvalid),
    .m_rready(lsu_axi_rready),
    .m_rdata(lsu_axi_rdata),
    .m_rid(lsu_axi_rid),
    .m_rresp(lsu_axi_rresp),
    .m_rlast(lsu_axi_rlast),

    .m_awvalid(lsu_axi_awvalid),
    .m_awid(lsu_axi_awid),
    .m_awaddr(lsu_axi_awaddr),
    .m_awready(lsu_axi_awready),

    .m_wvalid(lsu_axi_wvalid),
    .m_wready(lsu_axi_wready),

    .m_bresp(lsu_axi_bresp),
    .m_bvalid(lsu_axi_bvalid),
    .m_bid(lsu_axi_bid),
    .m_bready(lsu_axi_bready),

    .s0_arvalid(lmem_axi_arvalid),
    .s0_arready(lmem_axi_arready),

    .s0_rvalid(lmem_axi_rvalid),
    .s0_rid(lmem_axi_rid),
    .s0_rresp(lmem_axi_rresp),
    .s0_rdata(lmem_axi_rdata),
    .s0_rlast(lmem_axi_rlast),
    .s0_rready(lmem_axi_rready),

    .s0_awvalid(lmem_axi_awvalid),
    .s0_awready(lmem_axi_awready),

    .s0_wvalid(lmem_axi_wvalid),
    .s0_wready(lmem_axi_wready),

    .s0_bresp(lmem_axi_bresp),
    .s0_bvalid(lmem_axi_bvalid),
    .s0_bid(lmem_axi_bid),
    .s0_bready(lmem_axi_bready),


    .s1_arvalid(dma_axi_arvalid),
    .s1_arready(dma_axi_arready),

    .s1_rvalid(dma_axi_rvalid),
    .s1_rresp(dma_axi_rresp),
    .s1_rdata(dma_axi_rdata),
    .s1_rlast(dma_axi_rlast),
    .s1_rready(dma_axi_rready),

    .s1_awvalid(dma_axi_awvalid),
    .s1_awready(dma_axi_awready),

    .s1_wvalid(dma_axi_wvalid),
    .s1_wready(dma_axi_wready),

    .s1_bresp(dma_axi_bresp),
    .s1_bvalid(dma_axi_bvalid),
    .s1_bready(dma_axi_bready)
);

task preload_iccm;
bit[31:0] data;
bit[31:0] addr, eaddr, saddr, faddr;
int adr;
/*
addresses:
 0xffec - ICCM start address to load
 0xfff0 - ICCM end address to load
 0xfff4 - imem start address
*/

addr = 'hffec;
saddr = {lmem.mem[addr+3],lmem.mem[addr+2],lmem.mem[addr+1],lmem.mem[addr]};
if ( (saddr < `RV_ICCM_SADR) || (saddr > `RV_ICCM_EADR)) return;
`ifndef RV_ICCM_ENABLE
    $display("********************************************************");
    $display("ICCM preload: there is no ICCM in SweRV, terminating !!!");
    $display("********************************************************");
    $finish;
`endif
init_iccm;
addr = 'hfff0;
eaddr = {lmem.mem[addr+3],lmem.mem[addr+2],lmem.mem[addr+1],lmem.mem[addr]};
addr = 'hfff4;
faddr = {lmem.mem[addr+3],lmem.mem[addr+2],lmem.mem[addr+1],lmem.mem[addr]};
$display("ICCM pre-load from %h to %h", saddr, eaddr);

for(addr= saddr; addr <= eaddr; addr+=4) begin
    adr = faddr & 'hffff;
    data = {imem.mem[adr+3],imem.mem[adr+2],imem.mem[adr+1],imem.mem[adr]};
    slam_iccm_ram(addr, data == 0 ? 0 : {riscv_ecc32(data),data});
    faddr+=4;
end

endtask

task preload_dccm;
bit[31:0] data;
bit[31:0] addr, eaddr;
int adr;
/*
addresses:
 0xfff8 - DCCM start address to load
 0xfffc - ICCM end address to load
 0x0    - lmem start addres to load from
*/

addr = 'hfff8;
eaddr = {lmem.mem[addr+3],lmem.mem[addr+2],lmem.mem[addr+1],lmem.mem[addr]};
if (eaddr != `RV_DCCM_SADR) return;
`ifndef RV_DCCM_ENABLE
    $display("********************************************************");
    $display("DCCM preload: there is no DCCM in SweRV, terminating !!!");
    $display("********************************************************");
    $finish;
`endif
addr = 'hfffc;
eaddr = {lmem.mem[addr+3],lmem.mem[addr+2],lmem.mem[addr+1],lmem.mem[addr]};
$display("DCCM pre-load from %h to %h", `RV_DCCM_SADR, eaddr);

for(addr=`RV_DCCM_SADR; addr <= eaddr; addr+=4) begin
    adr = addr & 'hffff;
    data = {lmem.mem[adr+3],lmem.mem[adr+2],lmem.mem[adr+1],lmem.mem[adr]};
    slam_dccm_ram(addr, data == 0 ? 0 : {riscv_ecc32(data),data});
end

endtask

`define ICCM_PATH `RV_TOP.mem.iccm.iccm
`ifdef VERILATOR
`define DRAM(bk) rvtop.mem.Gen_dccm_enable.dccm.mem_bank[bk].ram.ram_core
`define IRAM(bk) `ICCM_PATH.mem_bank[bk].iccm_bank.ram_core
`else
`define DRAM(bk) rvtop.mem.Gen_dccm_enable.dccm.mem_bank[bk].dccm.dccm_bank.ram_core
`define IRAM(bk) `ICCM_PATH.mem_bank[bk].iccm.iccm_bank.ram_core
`endif


task slam_dccm_ram(input [31:0] addr, input[38:0] data);
int bank, indx;
bank = get_dccm_bank(addr, indx);
`ifdef RV_DCCM_ENABLE
case(bank)
0: `DRAM(0)[indx] = data;
1: `DRAM(1)[indx] = data;
`ifdef RV_DCCM_NUM_BANKS_4
2: `DRAM(2)[indx] = data;
3: `DRAM(3)[indx] = data;
`endif
`ifdef RV_DCCM_NUM_BANKS_8
2: `DRAM(2)[indx] = data;
3: `DRAM(3)[indx] = data;
4: `DRAM(4)[indx] = data;
5: `DRAM(5)[indx] = data;
6: `DRAM(6)[indx] = data;
7: `DRAM(7)[indx] = data;
`endif
endcase
`endif
//$display("Writing bank %0d indx=%0d A=%h, D=%h",bank, indx, addr, data);
endtask


task slam_iccm_ram( input[31:0] addr, input[38:0] data);
int bank, idx;

bank = get_iccm_bank(addr, idx);
`ifdef RV_ICCM_ENABLE
case(bank) // {
  0: `IRAM(0)[idx] = data;
  1: `IRAM(1)[idx] = data;
  2: `IRAM(2)[idx] = data;
  3: `IRAM(3)[idx] = data;

 `ifdef RV_ICCM_NUM_BANKS_8
  4: `IRAM(4)[idx] = data;
  5: `IRAM(5)[idx] = data;
  6: `IRAM(6)[idx] = data;
  7: `IRAM(7)[idx] = data;
 `endif

 `ifdef RV_ICCM_NUM_BANKS_16
  4: `IRAM(4)[idx] = data;
  5: `IRAM(5)[idx] = data;
  6: `IRAM(6)[idx] = data;
  7: `IRAM(7)[idx] = data;
  8: `IRAM(8)[idx] = data;
  9: `IRAM(9)[idx] = data;
  10: `IRAM(10)[idx] = data;
  11: `IRAM(11)[idx] = data;
  12: `IRAM(12)[idx] = data;
  13: `IRAM(13)[idx] = data;
  14: `IRAM(14)[idx] = data;
  15: `IRAM(15)[idx] = data;
 `endif
endcase // }
`endif
endtask

task init_iccm;
`ifdef RV_ICCM_ENABLE
    `IRAM(0) = '{default:39'h0};
    `IRAM(1) = '{default:39'h0};
    `IRAM(2) = '{default:39'h0};
    `IRAM(3) = '{default:39'h0};

`ifdef RV_ICCM_NUM_BANKS_8
    `IRAM(4) = '{default:39'h0};
    `IRAM(5) = '{default:39'h0};
    `IRAM(6) = '{default:39'h0};
    `IRAM(7) = '{default:39'h0};
`endif

`ifdef RV_ICCM_NUM_BANKS_16
    `IRAM(4) = '{default:39'h0};
    `IRAM(5) = '{default:39'h0};
    `IRAM(6) = '{default:39'h0};
    `IRAM(7) = '{default:39'h0};
    `IRAM(8) = '{default:39'h0};
    `IRAM(9) = '{default:39'h0};
    `IRAM(10) = '{default:39'h0};
    `IRAM(11) = '{default:39'h0};
    `IRAM(12) = '{default:39'h0};
    `IRAM(13) = '{default:39'h0};
    `IRAM(14) = '{default:39'h0};
    `IRAM(15) = '{default:39'h0};
 `endif
`endif
endtask


function[6:0] riscv_ecc32(input[31:0] data);
reg[6:0] synd;
synd[0] = ^(data & 32'h56aa_ad5b);
synd[1] = ^(data & 32'h9b33_366d);
synd[2] = ^(data & 32'he3c3_c78e);
synd[3] = ^(data & 32'h03fc_07f0);
synd[4] = ^(data & 32'h03ff_f800);
synd[5] = ^(data & 32'hfc00_0000);
synd[6] = ^{data, synd[5:0]};
return synd;
endfunction

function int get_dccm_bank(input[31:0] addr,  output int bank_idx);
`ifdef RV_DCCM_NUM_BANKS_2
    bank_idx = int'(addr[`RV_DCCM_BITS-1:3]);
    return int'( addr[2]);
`elsif RV_DCCM_NUM_BANKS_4
    bank_idx = int'(addr[`RV_DCCM_BITS-1:4]);
    return int'(addr[3:2]);
`elsif RV_DCCM_NUM_BANKS_8
    bank_idx = int'(addr[`RV_DCCM_BITS-1:5]);
    return int'( addr[4:2]);
`endif
endfunction

function int get_iccm_bank(input[31:0] addr,  output int bank_idx);
`ifdef RV_ICCM_NUM_BANKS_4
    bank_idx = int'(addr[`RV_ICCM_BITS-1:4]);
    return int'(addr[3:2]);
`elsif RV_ICCM_NUM_BANKS_8
    bank_idx = int'(addr[`RV_ICCM_BITS-1:5]);
    return int'( addr[4:2]);
`elsif RV_ICCM_NUM_BANKS_16
    bank_idx = int'(addr[`RV_ICCM_BITS-1:6]);
    return int'( addr[5:2]);
`endif
endfunction

endmodule
