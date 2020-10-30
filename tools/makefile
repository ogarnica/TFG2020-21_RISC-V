#------------------------------------------------------------------------------
# Makefile for detector project
#------------------------------------------------------------------------------
CC=vcom
CFLAGS=-c -Wall
SOURCES=(../../src/design/peak_detector/hdl/*.vhd ../../src/tb/tb_peak_detector/hdl/*.vhd)
#peak_detector.vhd reg.vhd signinverter.vhd subtractor.vhd


#------------------------------------------------------------------------------
# Rules
#------------------------------------------------------------------------------
help:
	@echo
	@echo "Options:"
	@echo "-------"
	@echo "  - compileXilinxLibs:    compile Xilinx simulation libs."
	@echo "  - cleanXilinxLibs:"
	@echo "  - createProjectLibs:"
	@echo "  - cleanProjectSimLibs:"
	@echo "  - clean:                clean all temporal files and dirs created during the design flow."
	@echo "  - syn_<design>:         synthesise design."
	@echo "  - vcom_<design>:        compile design"
	@echo "  - vsim_tb_<design>_001: run testbench 001 of design."
	@echo "  - hds:                  runs HDL designer."
	@echo

configureTools:
	@echo
	@echo "---------------------------------------------------------------------"
	@echo "Para configurar las variables de entorno de las herramientas:"
	@echo "  1. Muevete al directorio tools."
	@echo "  2. Ejecuta: source ./configureTools.sh"
	@echo "---------------------------------------------------------------------"
	@echo
	
compileXilinxLibs: configureTools
	./questa/compileXilinxLibs.sh

cleanXilinxLibs:
	cd ../work/compilation/;
	rm -r secureip simprim unimacro unisim;
	cd -

createProjectLibs: configureTools
	./questa/createProjectLibs.sh

cleanProjectSimLibs:
	@cd ../work/compilation/;\
	@mv simprim ..; mv unimacro ..; mv unisim ..;\
	@rm -r *; \
	@mv ../secureip .; mv ../simprim .; mv ../unimacro .; mv ../unisim .;\
	@cd -

clean:
	@find .. -iname ".cache.dat" -delete
	@find .. -iname "*.bak"      -delete
	@find .. -iname "*.log"      -delete	
	@find .. -iname "*~"         -delete
	@find .. -iname ".*version"  -delete

syn_peak_detector: configureTools
	./ise/peak_detector/syn_peak_detector.sh
	
syn_avg_peak_detector: configureTools
	./ise/peak_detector/syn_avg_peak_detector.sh

hds: configureTools
	./hds/detectors.sh	

vcom_peak_detector:
	./questa/vcom_peak_detector.sh

vcom_avg_peak_detector:
	./questa/vcom_avg_peak_detector.sh

vcom_tb_peak_detector: vcom_peak_detector
	vcom -64 -2008 -O4 -modelsimini ./questa/modelsim.ini -work tb_peak_detector     ../src/tb_design/tb_peak_detector/hdl/tb_peak_detector.vhd
	
vcom_tb_avg_peak_detector: vcom_avg_peak_detector
	vcom -64 -2008 -O4 -modelsimini ./questa/modelsim.ini -work tb_avg_peak_detector ../src/tb_design/tb_avg_peak_detector/hdl/tb_avg_peak_detector.vhd
	
vsim_tb_peak_detector: vcom_tb_peak_detector
	cd ./questa; \
	vsim -gui tb_peak_detector.tb_peak_detector -do wave.do

coregen: configureTools
	./coregen/coregen.sh
 