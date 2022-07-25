//--------------------------------------------------------------------------------------------
// Module:Top module
//--------------------------------------------------------------------------------------------

module top;

  //-------------------------------------------------------
  // Package : Importing Uvm Pakckage and Test Package
  //-------------------------------------------------------
  import axi4_test_pkg::*;
  import uvm_pkg::*;


//--------------------------------
//   Clock 
//------------------------------- 
   bit clock,rst;
              always 
            #10 clock=~clock;
   initial
     begin
           rst=0;
           #10;
           rst=1;
      end
//-------------------   
// FIFO interface
//-------------------
    fifo_if fi0(clock,rst);

//---------------------
// FIFO DUT to INTERFACE
//---------------------
    fifo_dut(.full(fi0.full),.empty(fi0.empty),.D_in(fi0.D_in),.wr_rd(fi0.wr_rd),.D_out(fi0.D_out),.clock(fi0.clock),.rst(fi0.rst));

//-------------------
// AXI interface
//-------------------  


//-----------------------
// AXI to DUT
//-----------------------

//-------------------------------------------------------
// run_test for simulation
//-------------------------------------------------------
  initial begin : START_TEST 

    //setting the virtual interface in config db

    uvm_config_db #(virtual fifo_if)::set(null,"*","vif",fi0);

    // The test to start is given at the command line
    // The command-line UVM_TESTNAME takes the precedance

     run_test("axi4_base_test");

  end

endmodule :top
