// memory reaction extracted native ABI emit helpers.
extern fn jj_n_e8(p0:*i64,p1:i64)->i64;
extern fn jj_n_e32(p0:*i64,p1:i64)->i64;
extern fn jj_n_disp(p0:i64)->i64;
fn jj_n_emit_store_arg_slot(state: *i64, index: i64, slot: i64) -> i64 {
  if slot<0{return 0;}
  if index == 0 { if jj_n_e8(state,0x48)==0{return 0;}if jj_n_e8(state,0x89)==0{return 0;}if jj_n_e8(state,0xbd)==0{return 0;} }
  else { if index == 1 { if jj_n_e8(state,0x48)==0{return 0;}if jj_n_e8(state,0x89)==0{return 0;}if jj_n_e8(state,0xb5)==0{return 0;} }
  else { if index == 2 { if jj_n_e8(state,0x48)==0{return 0;}if jj_n_e8(state,0x89)==0{return 0;}if jj_n_e8(state,0x95)==0{return 0;} }
  else { if index == 3 { if jj_n_e8(state,0x48)==0{return 0;}if jj_n_e8(state,0x89)==0{return 0;}if jj_n_e8(state,0x8d)==0{return 0;} }
  else { if index == 4 { if jj_n_e8(state,0x4c)==0{return 0;}if jj_n_e8(state,0x89)==0{return 0;}if jj_n_e8(state,0x85)==0{return 0;} }
  else { if index == 5 { if jj_n_e8(state,0x4c)==0{return 0;}if jj_n_e8(state,0x89)==0{return 0;}if jj_n_e8(state,0x8d)==0{return 0;} } else { return 0; } } } } } }
  return jj_n_e32(state,jj_n_disp(slot));
}
fn jj_n_emit_store_arg(state: *i64, index: i64) -> i64 { return jj_n_emit_store_arg_slot(state,index,index); }
fn jj_n_emit_pop_arg(state: *i64, index: i64) -> i64 {
  if index == 0 { return jj_n_e8(state,0x5f); }
  if index == 1 { return jj_n_e8(state,0x5e); }
  if index == 2 { return jj_n_e8(state,0x5a); }
  if index == 3 { return jj_n_e8(state,0x59); }
  if index == 4 { if jj_n_e8(state,0x41)==0{return 0;} return jj_n_e8(state,0x58); }
  if index == 5 { if jj_n_e8(state,0x41)==0{return 0;} return jj_n_e8(state,0x59); }
  return 0;
}
