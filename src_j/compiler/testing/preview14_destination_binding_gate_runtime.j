// canonical interface_EXTERN_PROTOTYPES_BEGIN
extern fn jj_b_manifest(p0: *i8, p1: i64) -> i64;
extern fn jj_compile_failure_emit(p0:*i8,p1:i64,p2:*i8)->i64;
extern fn jj_m_magic(p0: *i8, p1: i64) -> i64;
extern fn jj_r_manifest(p0: *i8, p1: i64) -> i64;
extern fn jj_raw_bundle_buffer() -> i64;
extern fn jj_raw_final_output_buffer() -> i64;
extern fn jj_raw_memory_cap_storage() -> i64;
extern fn jj_raw_object_buffer() -> i64;
extern fn jj_raw_source_buffer() -> i64;
extern fn jj_repository_materialize_model(p0: *i64, p1: *i64) -> i64;
extern fn jj_repository_verify_manifest(p0: *i64, p1: *i64) -> i64;
extern fn jj_resident_compile(p0:*i8,p1:*i8,p2:*i8,p3:*i8,p4:*i8,p5:*i8)->i64;
extern fn jj_resident_link(p0: *i8, p1: *i8, p2: *i8, p3: *i8) -> i64;
extern fn jj_runtime_fs_cap() -> i64;
extern fn jj_selfhost_build_manifest(p0: *i64, p1: *i64) -> i64;
extern fn jj_target_emit_object(p0: *i8, p1: i64, p2: *i8, p3: i64) -> i64;
extern fn jj_target_manifest_kind(p0: *i8, p1: i64) -> i64;
extern fn jj_core_index_bind(p0:*i64,p1:*i64,p2:i64)->i64;
extern fn jj_core_index_append(p0:*i64,p1:i64,p2:*i64,p3:i64)->i64;
extern fn jj_core_index_record(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_lang_authority_state_append(p0:*i64,p1:i64,p2:i64,p3:i64,p4:i64)->i64;
extern fn jj_lang_authority_state_is_active(p0:*i64,p1:i64,p2:i64,p3:i64)->i64;
extern fn jj_lang_authority_state_generation_at(p0:*i64,p1:i64,p2:i64,p3:i64)->i64;
extern fn jj_lang_authority_state_transition_internal(p0:*i64,p1:i64,p2:i64,p3:i64,p4:i64,p5:i64)->i64;
extern fn jj_lang_authority_state_require_active(p0:*i64,p1:i64,p2:i64,p3:i64,p4:i64)->i64;
extern fn jj_lang_authority_identity_for_local(p0:*i64,p1:i64,p2:i64,p3:i64)->i64;
extern fn jj_lang_authority_active_count_for_provenance(p0:*i64,p1:i64,p2:i64,p3:i64)->i64;
extern fn jj_lang_authority_binding_latest(p0:*i64,p1:i64,p2:i64,p3:i64)->i64;
// canonical interface_EXTERN_PROTOTYPES_END

fn jj_preview14_add_alias(core:*i64,local:i64,source:i64,at:i64)->i64{
  var fields:[7]i64;fields[0]=local;fields[1]=source;fields[2]=1;fields[3]=at;fields[4]=4;fields[5]=at+8;fields[6]=1;return jj_core_index_append(core,12,fields as *i64,7);
}

fn jj_preview14_destination_binding_gate()->i64{
  var core:[560]i64;var records:[256]i64;var i:i64=0;while i<560{core[i]=0;i=i+1;}i=0;while i<256{records[i]=0;i=i+1;}
  if jj_core_index_bind(core as *i64,records as *i64,256)==0{return 0;}
  core[12]=6;i=0;while i<6{var base:i64=500+i*5;core[base]=105+i*30;core[base+1]=4;core[base+2]=2;core[base+3]=i;core[base+4]=2;i=i+1;}
  core[500+1*5]=120;core[500+2*5]=150;core[500+3*5]=160;core[500+4*5]=180;core[500+5*5]=200;
  if jj_lang_authority_state_append(core as *i64,7,0,100,200)==0{return 0;}
  if jj_preview14_add_alias(core as *i64,1,0,120)==0{return 0;}
  if jj_preview14_add_alias(core as *i64,2,1,150)==0{return 0;}
  if jj_preview14_add_alias(core as *i64,3,0,160)==0{return 0;}
  if jj_preview14_add_alias(core as *i64,4,5,180)==0{return 0;}
  if jj_preview14_add_alias(core as *i64,5,2,200)==0{return 0;}
  if jj_lang_authority_active_count_for_provenance(core as *i64,7,0,130)!=1{return 0;}
  if jj_lang_authority_state_transition_internal(core as *i64,7,0,1,140,1)==0{return 0;}
  if jj_lang_authority_state_is_active(core as *i64,7,0,139)==0{return 0;}if jj_lang_authority_state_is_active(core as *i64,7,0,140)!=0{return 0;}if jj_lang_authority_state_generation_at(core as *i64,7,0,140)!=1{return 0;}
  if jj_lang_authority_state_is_active(core as *i64,7,1,140)==0{return 0;}if jj_lang_authority_state_generation_at(core as *i64,7,1,140)!=1{return 0;}if jj_lang_authority_identity_for_local(core as *i64,7,1,140)!=1{return 0;}
  if jj_lang_authority_identity_for_local(core as *i64,7,2,160)!=1{return 0;}if jj_lang_authority_active_count_for_provenance(core as *i64,7,0,160)!=1{return 0;}
  core[193]=0;if jj_lang_authority_state_require_active(core as *i64,7,0,145,1)!=0{return 0;}if core[193]!=1514{return 0;}
  if jj_lang_authority_state_transition_internal(core as *i64,7,1,2,170,1)==0{return 0;}
  if jj_lang_authority_state_is_active(core as *i64,7,1,170)!=0{return 0;}if jj_lang_authority_state_is_active(core as *i64,7,2,170)==0{return 0;}if jj_lang_authority_state_generation_at(core as *i64,7,2,170)!=2{return 0;}if jj_lang_authority_identity_for_local(core as *i64,7,2,170)!=2{return 0;}
  if jj_lang_authority_active_count_for_provenance(core as *i64,7,0,170)!=1{return 0;}
  if jj_lang_authority_state_transition_internal(core as *i64,7,2,3,175,1)!=0{return 0;}
  if jj_lang_authority_state_transition_internal(core as *i64,7,2,1,176,1)!=0{return 0;}
  if jj_lang_authority_state_transition_internal(core as *i64,7,2,4,220,1)!=0{return 0;}
  if jj_lang_authority_state_transition_internal(core as *i64,7,2,5,190,1)!=0{return 0;}
  var b0:*i64=jj_lang_authority_binding_latest(core as *i64,7,1,250) as *i64;var b1:*i64=jj_lang_authority_binding_latest(core as *i64,7,2,250) as *i64;if b0==0{return 0;}if b1==0{return 0;}if jj_core_index_record(core as *i64,17,2)!=0{return 0;}
  if b0[2]!=1{return 0;}if b0[3]!=0{return 0;}if b0[4]!=1{return 0;}if (b0[5]&0xffffffff)!=120{return 0;}if ((b0[5]>>>32)&0xffffffff)!=4{return 0;}if (b0[6]&0xffffffff)!=140{return 0;}if ((b0[6]>>>32)&0xffffffff)!=1{return 0;}if b0[7]!=1{return 0;}
  if b1[2]!=2{return 0;}if b1[3]!=0{return 0;}if b1[4]!=2{return 0;}if (b1[5]&0xffffffff)!=150{return 0;}if (b1[6]&0xffffffff)!=170{return 0;}
  return 1;
}

fn jj_runtime_parse_cap(memory: *i64) -> i64 {
  if jj_preview14_destination_binding_gate()==0{return 113;}
  if memory == 0 { return 114; }
  if memory != (jj_raw_memory_cap_storage() as *i64) { return 114; }
  if memory[0] != 0x4a4a4d454d434134 { return 114; }
  if (memory[1] & 2) != 2 { return 114; }
  if memory[2] != (jj_raw_source_buffer() as i64) { return 114; }
  if memory[3] != 1048576 { return 114; }
  if memory[5] != (jj_raw_object_buffer() as i64) { return 114; }
  if memory[6] != 2097152 { return 114; }
  if memory[16] != (jj_raw_bundle_buffer() as i64) { return 114; }
  if memory[17] != 8388608 { return 114; }
  if memory[4] <= 0 { return 113; }
  if memory[4] > memory[3] { return 113; }
  if memory[10] != 2 { return 113; }
  if memory[11] != 0 { return 113; }
  if memory[12] != 0 { return 113; }
  memory[11] = 1;
  var source: *i8 = memory[2] as *i8;
  var object: *i8 = memory[5] as *i8;
  var result: i64 = 0;
  if jj_m_magic(source, memory[4]) != 0 {
    var fs_materialize: *i64 = jj_runtime_fs_cap() as *i64;
    result = jj_repository_materialize_model(fs_materialize, memory);
  } else {
    if jj_r_manifest(source, memory[4]) != 0 {
      var fs_repo: *i64 = jj_runtime_fs_cap() as *i64;
      result = jj_repository_verify_manifest(fs_repo, memory);
    } else {
      if jj_b_manifest(source, memory[4]) != 0 {
        var fs: *i64 = jj_runtime_fs_cap() as *i64;
        result = jj_selfhost_build_manifest(fs, memory);
      } else {
        if jj_target_manifest_kind(source, memory[4]) != 0 {
          result = jj_target_emit_object(source, memory[4], object, memory[6]);
        } else {
          result = jj_resident_link(source, source + memory[4], object, object + memory[6]);
          if result == 2 {
            result = jj_resident_compile(source,source+memory[4],source+memory[4],source+memory[3],object,object+memory[6]);
          }
        }
      }
    }
  }
  if result == 2 {
    jj_compile_failure_emit(memory[8] as *i8,113,object);
    memory[11] = 0;
    return 113;
  }
  if result <= 0 {
    memory[11] = 0;
    return 113;
  }
  if result > memory[6] {
    memory[11] = 0;
    return 113;
  }
  memory[7] = result;
  memory[11] = 2;
  return 0;
}

fn jj_runtime_finalize_cap(memory: *i64) -> i64 {
  if memory == 0 { return 114; }
  if memory != (jj_raw_memory_cap_storage() as *i64) { return 114; }
  if memory[0] != 0x4a4a4d454d434134 { return 114; }
  if (memory[1] & 4) != 4 { return 114; }
  var approved_pair: i64 = 0;
  if memory[5] == (jj_raw_object_buffer() as i64) { if memory[6] == 2097152 { approved_pair = 1; } }
  if memory[5] == (jj_raw_final_output_buffer() as i64) { if memory[6] == 5242880 { approved_pair = 1; } }
  if approved_pair == 0 { return 114; }
  if memory[10] != 3 { return 113; }
  if memory[11] != 2 { return 113; }
  if memory[12] != 0 { return 113; }
  if memory[7] <= 0 { return 113; }
  if memory[7] > memory[6] { return 113; }
  memory[12] = 2;
  return 0;
}
