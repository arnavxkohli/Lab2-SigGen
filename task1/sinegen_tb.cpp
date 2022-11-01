#include "Vsinegen.h"
#include "verilated.h"
#include "verilated_vcd_c.h" 
#include "vbuddy.cpp" 

int main(int argc,char **argv, char **env){
    int i;
    int clk;
    int count;

    Verilated::commandArgs(argc, argv);
    //init top verilog instance 
    Vsinegen* top = new Vsinegen;
    // init trace dump
    Verilated::traceEverOn(true);
    VerilatedVcdC* tfp= new VerilatedVcdC;
    top->trace (tfp,99);
    tfp->open ("sinegen.vcd");


    // init Vbuddy
    if (vbdOpen()!=1) return(-1);
    vbdHeader("L2T1: SigGen");

    // initialize simulation inputs
    top->clk = 1 ;
    top->rst = 1 ;
    top->en = 1;
    top->incr = vbdValue(); // controls the frequency.

    
    //run simulation for many clock cycles
    for (i=0; i<1000000; i++){ // clock cycles
            //dump variables into VCD file and toggle clock
            for (clk=0; clk<2; clk++) {
                tfp->dump (2*i+clk);
                top->clk = !top->clk;
                top->eval();
            }

            vbdPlot((int(top->dout)), 0, 255);
            vbdCycle(i);

            // ++++ Send count value to Vbuddy
            // vbdHex(4, (int(top->count) >> 16) & 0XF);
            // vbdHex(3, (int(top->bcd) >> 8) & 0XF);
            // vbdHex(2, (int(top->bcd) >> 4) & 0XF);
            // vbdHex(1, int(top->bcd) & 0XF);
            //  vbdCycle(i+1);
            //---- end of Vbuddy output section

            // change input stimuli
            top->rst = false;   
            //(step1) top->vbdVal = vbdValue();
            if ((Verilated::gotFinish()) || (vbdGetkey()=='q')) 
            exit(0);
    }

    vbdClose(); //++++
    tfp->close();
    exit(0);

}
