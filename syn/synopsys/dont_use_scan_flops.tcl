# don't use scan flops, because no scan logic is inserted at this level
set LIBRARY_NAME "tcbn65lplt"
set_dont_use     "[list $LIBRARY_NAME]/SDF*"
set_dont_use     "[list $LIBRARY_NAME]/SEDF*"
