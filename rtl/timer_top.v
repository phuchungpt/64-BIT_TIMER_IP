module timer_top
(
  input  wire        sys_clk    ,
  input  wire        sys_rst_n  ,
  input  wire        tim_psel   , 
  input  wire        tim_pwrite , 
  input  wire        tim_penable, 
  input  wire [11:0] tim_paddr  , 
  input  wire [31:0] tim_pwdata , 
  input  wire        dbg_mode   ,  
  input  wire [3:0]  tim_pstrb  , 
  output wire        tim_pready , 
  output wire        tim_pslverr, 
  output wire        tim_int    , 
  output wire [31:0] tim_prdata
);

  // apb_block to register 
  wire wr_en_tmp; 
  wire rd_en_tmp; 
  
  // register to interrupt 
  wire int_st_tmp     ;
  wire int_en_tmp     ; 
  wire tisr_wr_set_tmp;
  wire [63:0] tcmp_tmp;

  // register to counter control 
  wire halt_ack_tmp     ; 
  wire div_en_tmp       ;
  wire [3:0] div_val_tmp; 
  wire timer_en_tmp     ; 
  wire halt_req_tmp     ;
	
  // register to counter 
  wire [63:0] cnt_tmp   ;
  wire tdr0_wr_sel_tmp  ;
  wire tdr1_wr_sel_tmp  ;
  wire cnt_clr_tmp      ; 
	
  // counter_control to counter 
  wire cnt_en_tmp       ;
	
// apb_slave 
  apb_slave u_apb_slave(
   // apb block to timer_ip 
	.clk(sys_clk)          , 
	.rst_n(sys_rst_n)      , 
	.psel(tim_psel)        , 	
    	.pwrite(tim_pwrite)    ,
	.penable(tim_penable)  ,
	.tim_pready(tim_pready),
   // apb_block to register 
	.wr_en(wr_en_tmp)      , 
    	.rd_en(rd_en_tmp)
  ); 
  
// register block
  register u_register(
  // register to timer_ip
	.clk(sys_clk)                ,
	.rst_n(sys_rst_n)            , 
	.addr(tim_paddr)             ,
	.wdata(tim_pwdata)           , 
	.pstrb(tim_pstrb)            ,
	.rdata(tim_prdata)           ,
	.tim_pslverr(tim_pslverr)    , 
  // register to apb_slave
	.wr_en(wr_en_tmp)            , 
	.rd_en(rd_en_tmp)            ,
	.tim_pready(tim_pready)      ,
  // register to interrupt 
	.int_st(int_st_tmp)          ,
	.int_en(int_en_tmp)          ,
	.tisr_wr_sel(tisr_wr_sel_tmp),
	.tcmp(tcmp_tmp)              ,
  // register to counter_control
	.halt_ack(halt_ack_tmp)      , 
	.div_en(div_en_tmp)          ,
	.div_val(div_val_tmp)        ,
	.timer_en(timer_en_tmp)      ,
	.halt_req(halt_req_tmp)      ,
  // register to counter 
    .tdr0_wr_sel(tdr0_wr_sel_tmp), 
	.tdr1_wr_sel(tdr1_wr_sel_tmp), 
	.cnt(cnt_tmp)                ,
	.cnt_clr(cnt_clr_tmp)
  );
  
// counter control block 
  counter_control u_counter_control(
  // Counter_control to timer_ip 
     	.clk(sys_clk)          ,
    	.rst_n(sys_rst_n)      ,
     	.dbg_mode(dbg_mode)    ,
  // counter control to register 
     	.timer_en(timer_en_tmp),
  	.div_en(div_en_tmp)    ,
      	.div_val(div_val_tmp)  ,
      	.halt_req(halt_req_tmp),
      	.halt_ack(halt_ack_tmp),
  // counter control to counter
      	.cnt_en(cnt_en_tmp)
  ); 

// counter block 
  counter u_counter(
  // counter to timer_ip
	.clk(sys_clk)                ,
	.rst_n(sys_rst_n)            ,
	.pstrb(tim_pstrb)            , 
	.wdata(tim_pwdata)           ,
  // counter to counter control 
    	.cnt_en(cnt_en_tmp)          ,
  // counter to register 
  	.tdr0_wr_sel(tdr0_wr_sel_tmp),
	.tdr1_wr_sel(tdr0_wr_sel_tmp),
	.cnt(cnt_tmp)                ,
	.cnt_clr(cnt_clr_tmp)
  );

endmodule 
  
  
  
  
  
  
  
  
  
  
  
  
  
  
