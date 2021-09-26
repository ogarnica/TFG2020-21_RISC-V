proc report_name stage {
    return [get_object_name [current_design]]_${stage}
}

proc reports stage {
    # Global variables
    upvar #0 rptDir rptDir
    upvar #0 netDir netDir

    # Local vars
    set filePref [report_name  $stage]
    set rptFile ${rptDir}/${filePref}
    set netFile ${netDir}/${filePref}

    report_timing                                 > ${rptFile}_timing.rpt
    report_timing -loop -max_paths 10             > ${rptFile}_comb_loops.rpt
    check_design                                  > ${rptFile}_check_design.rpt
    report_cell [all_registers] -nosplit > ${rptFile}_regs.rpt
    write_file [get_object_name [current_design]] -format ddc  -hierarchy -output ${netFile}.ddc
}
