project_open ../../Etapa7.3/sisa.qpf
foreach_in_collection asgn_id [get_all_assignments -name VHDL_FILE -type global] { puts  ../../Etapa7.3/[get_assignment_info -value $asgn_id] }
