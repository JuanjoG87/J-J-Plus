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
// canonical interface_EXTERN_PROTOTYPES_END
fn jj_runtime_parse_cap(memory: *i64) -> i64 {
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
    var diagnostic:*i64=(object+memory[6]-64) as *i64;var expected:i64=(diagnostic as i64)^diagnostic[0]^diagnostic[1]^diagnostic[2]^diagnostic[3]^diagnostic[4]^diagnostic[5]^diagnostic[6]^0x4a4a444941475332;var failure_rc:i64=113;
    if diagnostic[0]==0x4a4a444941473032{if diagnostic[7]==expected{if diagnostic[1]>=1000{if diagnostic[1]<1100{failure_rc=diagnostic[1]-880;}}}}jj_compile_failure_emit(memory[8] as *i8,failure_rc,object);memory[11]=0;return failure_rc;
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
