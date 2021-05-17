project_open ../../Etapa7.2/sisa.qpf
foreach_in_collection asgn_id [get_all_assignments -name VHDL_FILE -type global] { puts  ../../Etapa7.2/[get_assignment_info -value $asgn_id] }
