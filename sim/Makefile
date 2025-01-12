#################################################################
#This file create by Phuc Hung 
#Updated data: 7/20/2024
#Example run string: make TESTNAME={name_of_testcase} {optional}}
#                    make TESTNAME=counter_test all 
#################################################################
#Define variables
TESNAME  ?= tc_01 
TB_NAME  ?= test_bench 
RADIX    ?= decimal 

#==============================
all: build run

all_wave: build run wave

all_cov: build_cov run_cov

all_all: all_cov gen_cov

build:
    #mkdir log
    mkdir -p log
    #copy then rename testcase
    cp -rf ../testcase/$ (TESTNAME).v run_test.v
    vlib work
    vmap work work
    vlog -f compile.f | tee compile.log
    
build_cov:
    #mkdir log
    mkdir -p log
    #copy then rename testcase
    cp -rf ../testcase/$(TESTNAME).v_run_test.v
    vlib work
    vmap work work
    vlog +cover-bcesft -f compile.f
    
run:
    vsim -debugDB -1 $(TESTNAME).log -voptargs=+acc -assertdebug -c $(TB_NAME) 
    #copy log
    cp $(TESTNAME).log ./log/
    mv $(TESTNAME).log sim.log
    

run_cov:
    vsim -coverage -l $(TESTNAME).log -c $(TB_NAME) -voptargs="+cover-bcesft" assertdebug -do "coverage save -onexit $(TESTNAME).ucdb; log -r /*; run -all" 
    #copy Log
    cp $(TESTNAME).log ./log/
    mv $ (TESTNAME).log sim.log
    
wave:
    vsim -i -view vsim.wlf -do "add wave vsim:/$(TB_NAME)/*; radix -$ (RADIX)" &

gen_cov: 
    mkdir -p coverage
    vcover merge IP.ucdb *.ucdb
    vcover report IP.ucdb -output coverage/summary_report.txt
    vcover report -zeros -details -code bcesft -annotate -All -codeAll IP.ucdb -output coverage/detail_report.txt
    
gen_html:
    mkdir -p coverage
    vcover merge IP.ucdb *.ucdb
    vcover report -zeros -details -code bcesft -annotate -testhitdataAll -html IP.ucdb
    
clean:
    rm -rf work
    rm -rf vsim.dbg
    rm -rf *.ini
    rm -rf *.log
    rm -rf *.wlf rm -rf *.ucdb rm -rf transcript
    
    
