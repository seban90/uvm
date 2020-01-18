export PRJ_HOME=$(CURDIR)

FILELIST = 

ifeq ($(UVM_AXI), on)
FILELIST += -f $(CURDIR)/FILELIST/uvm_axi.f
endif
ifeq ($(UVM_APB), on)
FILELIST += -f $(CURDIR)/FILELIST/uvm_axi.f
endif

FILELIST += -f $(CURDIR)/FILELIST/test.f

##############################################################
# DONT TOUCH
##############################################################
VELAB  := vcs
SIMV   := simv
##############################################################
VELAB_OPT += -full64
VELAB_OPT += -sverilog
VELAB_OPT += -work work
VELAB_OPT += -ntb_opts uvm
VELAB_OPT += -debug_access+all
VELAB_OPT += -timescale=1ns/10ps
VELAB_OPT += +systemverilogext+.sv
VELAB_OPT += +verilog2001ext+.v
VELAB_OPT += +notimingcheck
VELAB_OPT += -top testbench
ifeq ($(coverage), on)
VELAB_OPT += -cm line+tgl+branch
endif
VELAB_OPT += -l $(CURDIR)/SIM/velab.log
VELAB_OPT += $(FILELIST)



##############################################################
all: elab sim
vcc: elab
.PHONY: elab sim
elab:
	cd $(CURDIR)/SIM; $(VELAB) $(VELAB_OPT)

sim:
	cd $(CURDIR)/SIM; $(SIMV) $(SIMV_OPT)
clean:
	cd $(CURDIR)/SIM; rm -rf ./*
##############################################################
