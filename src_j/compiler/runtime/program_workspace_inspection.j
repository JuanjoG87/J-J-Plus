// on-demand inspection companion; excluded from resident selfhost closures.
extern fn jj_program_workspace_valid(p0:*i64)->i64;

fn jj_program_workspace_source_length(state:*i64)->i64{if jj_program_workspace_valid(state)==0{return 0;}return state[1];}
fn jj_program_workspace_base(state:*i64)->i64{if jj_program_workspace_valid(state)==0{return 0;}return state[2];}
fn jj_program_workspace_capacity(state:*i64)->i64{if jj_program_workspace_valid(state)==0{return 0;}return state[6];}
fn jj_program_workspace_ast_offset(state:*i64)->i64{if jj_program_workspace_valid(state)==0{return 0;}return state[7];}
fn jj_program_workspace_ast_bytes(state:*i64)->i64{if jj_program_workspace_valid(state)==0{return 0;}return state[8];}
fn jj_program_workspace_ast_records(state:*i64)->i64{if jj_program_workspace_valid(state)==0{return 0;}return state[9];}
fn jj_program_workspace_object_capacity(state:*i64)->i64{if jj_program_workspace_valid(state)==0{return 0;}return state[5];}
