# Los archivos de inicializacion se cargan desde la GUI
# source swerv_wrapper.globals
# set_global _enable_mmmc_by_default_flow      $CTE::mmmc_default


# He cargado archivo SDC usando la GUI pero no veo el comando ...

setDesignMode -process 28
#setDesignMode -flowEffort express
setAnalysisMode -analysisType onChipVariation
set_global timing_cppr_transition_sense same_transition_expanded
set_global timing_use_latch_early_launch_edge false
set_global timing_enable_early_late_data_slews_for_setuphold_mode_checks false
set_global timing_allow_input_delay_on_clock_source true
set_global timing_enable_pessimistic_cppr_for_reconvergent_clock_paths true
set_global timing_enable_power_ground_constants true
setDelayCalMode -SIAware true

#setExtractRCMode -engine postRoute -effortLevel low

########### Nanoroute
# Recomendation in Foundation Cadence TechnoKit
# Automatic via generation
# setNanoRouteMode -routeExpUseAutoVia true  --> comando sustituido por routeUseAutoVia
# Metal encosure in correct direction
setViaGenMode -optimize_cross_via 1

# The following lines force Innovus in autoViaGen mode, ensure multi-cut vias usage, and allows diodes antenna fixing:
setNanoRouteMode -routeUseAutoVia true
setNanoRouteMode -drouteUseMultiCutViaEffort high
# setNanoRouteMode -droutePostRouteSwapVia true
# setNanoRouteMode -droutePostRouteSwapVia multicut  # Las otras posibles opciones son false o true
setNanoRouteMode -routeInsertAntennaDiode true
setNanoRouteMode -routeAntennaCellName C12T28SOI_LR_ANTPROT3

#The following lines enable lithography driven routing, and define top routing layer:
setNanoRouteMode -routeWithLithoDriven true
setNanoRouteMode -routeTopRoutingLayer 9

################################################################################
# Define IO placement grid. myCMP email recommendation
################################################################################
setPreference ConstraintUserXGrid 0.1
setPreference ConstraintUserXOffset 0
setPreference ConstraintUserYGrid 0.1
setPreference ConstraintUserYOffset 0
setPreference BlockSnapRule 1
setPreference SnapAllCorners 1

fpiSetSnapRule -for IOP -grid UG -force
## Innovus command "fpiGetSnapRule" to have a summary of the different grids defined in the tool.

#################################################################################
# Add Corners and Power/Ground IOs and then place them. Should be 1428 PADS inclu
# ding the new ones.
#################################################################################
loadECO ./PAD_TOP_FIR.eco
placePIO
#################################################################################
# Make pads ordering in the IOring            
#################################################################################
# loadIoFile ./PAD_TOP_FIR.io


# Pre-placement optimizations
# Eliminar buffer trees generados durante sinthesis
deleteBufferTree

# Floorplanning
floorPlan -coreMarginsBy die -site CORE12T -r 0.990622949432 0.699729 115.0 115.0 115.0 115.0

#IO Fillers
addIoFiller -cell FILLCELL_1GRID_EXT_CSF_FC_LIN -prefix FILLER -side n
addIoFiller -cell FILLCELL_1GRID_EXT_CSF_FC_LIN -prefix FILLER -side e
addIoFiller -cell FILLCELL_1GRID_EXT_CSF_FC_LIN -prefix FILLER -side w
addIoFiller -cell FILLCELL_1GRID_EXT_CSF_FC_LIN -prefix FILLER -side s

# vdd & gnd
globalNetConnect vdd -type pgpin -pin vdd -override -verbose -netlistOverride
globalNetConnect gnd -type pgpin -pin gnd -override -verbose -netlistOverride
globalNetConnect vdde -type pgpin -pin vdde -override -verbose -netlistOverride
globalNetConnect gnde -type pgpin -pin gnde -override -verbose -netlistOverride
# añadido vdds y gnds
globalNetConnect vdds -type pgpin -pin vdds -override -verbose -netlistOverride
globalNetConnect gnds -type pgpin -pin gnds -override -verbose -netlistOverride
# Lineas comentadas devido al siguiente error:
# **ERROR: The global net 'vddm' specified in the global net connection rule doesn exist in the design

#globalNetConnect vddm -type pgpin -pin vddm -override -verbose -netlistOverride
#globalNetConnect gndm -type pgpin -pin gndm -override -verbose -netlistOverride

# clearGlobalNets
# globalNetConnect vdd -type pgpin -pin vdd -instanceBasename *
# globalNetConnect gnd -type pgpin -pin gnd -instanceBasename *
#IO pins. Esto hay que definirlo mejor con un archivo 
set sprCreateIeRingOffset 1.0
set sprCreateIeRingThreshold 1.0
set sprCreateIeRingJogDistance 1.0
set sprCreateIeRingLayers {}
set sprCreateIeStripeWidth 10.0
set sprCreateIeStripeThreshold 1.0

# Creacion de los anillos
setAddRingMode -ring_target default -extend_over_row 0 -ignore_rows 0 -avoid_short 0 -skip_crossing_trunks none -stacked_via_top_layer LB -stacked_via_bottom_layer M1 -via_using_exact_crossover_size 1 -orthogonal_only true -skip_via_on_pin {  standardcell } -skip_via_on_wire_shape {  noshape }
#añadido vdds y gnds
addRing -nets {vdd gnd vdde gnde vdds gnds} -type core_rings -follow core -layer {top M1 bottom M1 left M2 right M2} -width {top 1.8 bottom 1.8 left 1.8 right 1.8} -spacing {top 1.8 bottom 1.8 left 1.8 right 1.8} -offset {top 1.8 bottom 1.8 left 1.8 right 1.8} -center 0 -threshold 0 -jog_distance 0 -snap_wire_center_to_grid None

# Creacion de los stripes
setAddStripeMode -ignore_block_check false -break_at none -route_over_rows_only false -rows_without_stripes_only false -extend_to_closest_target none -stop_at_last_wire_for_area false -partial_set_thru_domain false -ignore_nondefault_domains false -trim_antenna_back_to_shape none -spacing_type edge_to_edge -spacing_from_block 0 -stripe_min_length stripe_width -stacked_via_top_layer LB -stacked_via_bottom_layer M1 -via_using_exact_crossover_size false -split_vias false -orthogonal_only true -allow_jog { padcore_ring  block_ring } -skip_via_on_pin {  standardcell } -skip_via_on_wire_shape {  noshape   }
# añadido vdds gnds y cambiado settosetdistance 50x16=800 
addStripe -nets {vdd gnd vdde gnde vdds gnds} -layer M2 -direction vertical -width 1.8 -spacing 1.8 -set_to_set_distance 800 -start_from left -start_offset 20 -switch_layer_over_obs false -max_same_layer_jog_length 2 -padcore_ring_top_layer_limit LB -padcore_ring_bottom_layer_limit M1 -block_ring_top_layer_limit LB -block_ring_bottom_layer_limit M1 -use_wire_group 0 -snap_wire_center_to_grid Grid

# Rutado de la alimentacion y tierra. Incluye IO pads
setSrouteMode -viaConnectToShape { noshape }

sroute -connect { blockPin padPin padRing corePin floatingStripe } -layerChangeRange { M1(1) LB(9) } -blockPinTarget { nearestTarget } -padPinPortConnect { allPort oneGeom } -padPinTarget { nearestTarget } -corePinTarget { firstAfterRowEnd } -floatingStripeTarget { blockring padring ring stripe ringpin blockpin followpin } -allowJogging 1 -crossoverViaLayerRange { M1(1) LB(9) } -nets { gnd gnde gnds vdd vdde vdds } -allowLayerChange 1 -blockPin useLef -targetViaLayerRange { M1(1) LB(9) }

# Ubicacion de los pines. Innecesario porque lo delego en que lo haga Innovus automaticamente
# editPin -fixOverlap 1 -side Top -layer 1 -assign 0.0 0.0 -pin debug_brkpt_status
# getPinAssignMode -pinEditInBatch -quiet
# setPinAssignMode -pinEditInBatch true
# editPin -pinWidth 0.05 -pinDepth 0.2 -fixOverlap 1 -side Top -layer 1 -assign 0.476 414.4 -pin debug_brkpt_status
# editPin -fixOverlap 1 -side Top -layer 1 -assign 0.34 414.4 -pin {dbg_rst_l debug_brkpt_status}
# pinAlignment -pinNames {dec_tlu_perfcnt0[0] dec_tlu_perfcnt0[1]} -ptnInst swerv_wrapper -refObj {}
#
#setPinAssignMode -pinEditInBatch false
#pinAlignment -pinNames clk -ptnInst swerv_wrapper -refObj {}

#addRing -skip_via_on_wire_shape Noshape

#Prototyping mode. No produce un placement legal. Solo para ver la pinta que tiene
#setPlaceMode -place_design_floorplan_mode true
place_opt_design


# Clock Tree Synthesis
#clockDesign -specFile clock.spec -outDir clock_report -fixedInstBeforeCTS
#comprobar que la ruta a los constraints es correcta
update_constraint_mode -name nominal_constraints -sdc_files netlistFiles/constraints.sdc
set_analysis_view -setup nominal_analysis_view -hold nominal_analysis_view

# There are problems during CTS. See them below:
# ----------------------------------------------------------------------
# Clock tree    Problem
# ----------------------------------------------------------------------
# clk           Contains instances of library cells which cannot be used
# clk           Could not determine drivers to use
# ----------------------------------------------------------------------
# jtag_tck      Contains instances of library cells which cannot be used
# jtag_tck      Could not determine drivers to use
# ----------------------------------------------------------------------
# I think they are related with clock gating cells and buffers and inverters for clock balaning. 
# A more detailed explanation from the log:
# **ERROR: (IMPCCOPT-1135):	CTS found neither inverters nor buffers while balancing clock_tree jtag_tck. CTS cannot continue.
# Clock tree balancer configuration for clock_trees clk jtag_tck:
# Non-default CCOpt properties:
#   route_type (leaf): default_route_type_leaf (default: default)
#   route_type (trunk): default_route_type_nonleaf (default: default)
#   route_type (top): default_route_type_nonleaf (default: default)



set_ccopt_property clock_gating_cells {C12T28SOI_LRPHP_CNHLSX29_P0}
set_ccopt_property buffer_cells {C12T28SOI_LR_CNBF*}
set_ccopt_property inverter_cells {C12T28SOI_LR_CNIV*}

# Maximumn transition target
set_ccopt_property target_max_trans 100ps

# Maximumn skew target
set_ccopt_property target_skew 50ps

# Creae clock tree specification
create_ccopt_clock_tree_spec -file ccopt.spec

# Run Clock tree synthesis
ccopt_design -cts -outDir clock_report

# Post CTS optimization
optDesign -postCTS

# Report Timing
timeDesign -postCTS -expandedViews -outDir report_timingpostCTS.rpt 
report_ccopt_clock_trees -file clock_trees.rpt
report_ccopt_skew_groups -file skew_groups.rpt

#The filler cells are recommended to be inserted before routeDesign , with proper setFillerMode settings
#Se añanden despues, si no ->< killed 
#addFiller -cell {C12T28SOI_LR_FILLERCELL1 C12T28SOI_LR_FILLERPFOP2  C12T28SOI_LR_FILLERPFOP4 C12T28SOI_LR_FILLERPFOP8 C12T28SOI_LR_FILLERPFOP16 C12T28SOI_LR_FILLERPFOP32} -prefix FILLER -doDRC


setDesignMode -expressRoute true
routeDesign
# PostRoute Optimization
optDesign -postRoute

#addFiller command is running on a postRoute database. It is recommended to be followed by ecoRoute -target command to make the DRC clean.
addFiller -cell {C12T28SOI_LR_FILLERCELL1 C12T28SOI_LR_FILLERPFOP2  C12T28SOI_LR_FILLERPFOP4 C12T28SOI_LR_FILLERPFOP8 C12T28SOI_LR_FILLERPFOP16 C12T28SOI_LR_FILLERPFOP32} -prefix FILLER -doDRC
ecoRoute -target

# RC Extraction
setExtractRCMode -engine postRoute
setExtractRCMode -effortLevel signoff

# SignOff
timeDesign -signoff -outDir signOffTimingReports
timeDesign -signoff -setup -reportOnly -outDir signOffTimingReports 
#Error -setup no existe
timeDesign -signoff -hold  -reportOnly -outDir signOffTimingReports
