# use scan flops, because scan logic is inserted
set LIBRARY_NAME "tcbn65lplt"
remove_attribute     "[list $LIBRARY_NAME]/SDF*"    dont_use
remove_attribute     "[list $LIBRARY_NAME]/SEDF*"   dont_use
