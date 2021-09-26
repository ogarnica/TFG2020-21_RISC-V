
set designs [get_designs *]

foreach_in_collection design $designs {
    current_design $design
    set tie_cells [get_cells mm_*]

    foreach_in_collection cell $tie_cells {
        set net [get_nets -of_objects [get_pins -of_objects $cell]]
        if ([sizeof_collection $net]==0) {
            remove_cell $cell
        }
    }
}