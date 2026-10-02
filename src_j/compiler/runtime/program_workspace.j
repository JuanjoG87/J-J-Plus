// Address-bound compile workspace. Source, program/AST workspace and object
// output are pairwise disjoint. All subregions are represented by logical
// offsets from the workspace capability base; no interior pointer is retained.
fn jj_program_workspace_disjoint(a:*i8,a_end:*i8,b:*i8,b_end:*i8)->i64{
  if a==0{return 0;}if a_end==0{return 0;}if b==0{return 0;}if b_end==0{return 0;}if a_end<=a{return 0;}if b_end<=b{return 0;}if a_end<=b{return 1;}if b_end<=a{return 1;}return 0;
}
fn jj_program_workspace_valid(state:*i64)->i64{
  if state==0{return 0;}if state[0]==0{return 0;}if state[1]<=0{return 0;}if state[2]==0{return 0;}if state[3]<=0{return 0;}if state[4]==0{return 0;}if state[5]<=0{return 0;}if state[6]<65536{return 0;}if state[7]!=state[6]{return 0;}if state[8]<=0{return 0;}if state[9]<=0{return 0;}
  if state[8]!=state[9]*48{return 0;}if state[7]>state[3]-state[8]{return 0;}if state[7]+state[8]!=state[3]{return 0;}
  var seal:i64=(state as i64)^state[0]^state[1]^state[2]^state[3]^state[4]^state[5]^state[6]^state[7]^state[8]^state[9]^0x4a4a5057524b5332;if state[10]!=seal{return 0;}if state[11]!=0{return 0;}return 1;
}
fn jj_program_workspace_bind_profile(state:*i64,source:*i8,source_end:*i8,workspace:*i8,workspace_end:*i8,object_region:*i64)->i64{
  if object_region==0{return 0;}var object:*i8=object_region[0] as *i8;var object_capacity:i64=object_region[1];var ast_eighths:i64=object_region[2];var object_end:*i8=(object as i64+object_capacity) as *i8;
  if state==0{return 0;}if source==0{return 0;}if source_end==0{return 0;}if workspace==0{return 0;}if workspace_end==0{return 0;}if object==0{return 0;}if object_end==0{return 0;}if source_end<=source{return 0;}if workspace_end<=workspace{return 0;}if object_end<=object{return 0;}if ast_eighths<1{return 0;}if ast_eighths>7{return 0;}
  if jj_program_workspace_disjoint(source,source_end,workspace,workspace_end)==0{return 0;}if jj_program_workspace_disjoint(source,source_end,object,object_end)==0{return 0;}if jj_program_workspace_disjoint(workspace,workspace_end,object,object_end)==0{return 0;}
  var source_length:i64=source_end-source;var total:i64=workspace_end-workspace;if source_length>0xffffffff{return 0;}if total<131072{return 0;}if object_capacity<65536{return 0;}
  // One AST record consumes 16 bytes node + 8 bytes span + 16 bytes map + 8 bytes typed relation.
  // ast_eighths is an explicit bounded profile; unused rounding bytes remain in the program capability.
  var requested_ast:i64=(total*ast_eighths)/8;if requested_ast<=0{return 0;}var records:i64=requested_ast/48;if records<=4096{return 0;}var ast_bytes:i64=records*48;var program_capacity:i64=total-ast_bytes;if program_capacity<65536{return 0;}if program_capacity+ast_bytes!=total{return 0;}
  var z:i64=0;while z<12{state[z]=0;z=z+1;}state[0]=source as i64;state[1]=source_length;state[2]=workspace as i64;state[3]=total;state[4]=object as i64;state[5]=object_capacity;state[6]=program_capacity;state[7]=program_capacity;state[8]=ast_bytes;state[9]=records;state[10]=(state as i64)^state[0]^state[1]^state[2]^state[3]^state[4]^state[5]^state[6]^state[7]^state[8]^state[9]^0x4a4a5057524b5332;state[11]=0;return jj_program_workspace_valid(state);
}
fn jj_program_workspace_bind(state:*i64,source:*i8,source_end:*i8,workspace:*i8,workspace_end:*i8,object_region:*i64)->i64{
  if object_region==0{return 0;}var profile:[3]i64;profile[0]=object_region[0];profile[1]=object_region[1];profile[2]=4;return jj_program_workspace_bind_profile(state,source,source_end,workspace,workspace_end,profile as *i64);
}
fn jj_program_workspace_view(state:*i64,out:*i64)->i64{
  if jj_program_workspace_valid(state)==0{return 0;}if out==0{return 0;}out[0]=state[1];out[1]=state[2];out[2]=state[6];out[3]=state[3];out[4]=state[7];out[5]=state[8];out[6]=state[9];out[7]=state[5];return 1;
}







