// Runtime capability integration hub; publishes roots and delegates mutations.
// Integration-hub partition R764: concrete work lives in focused phases.
// canonical interface_EXTERN_PROTOTYPES_BEGIN
extern fn jj_runtime_arena_init() -> i64;
extern fn jj_raw_fs_cap_storage() -> i64;
extern fn jj_raw_memory_cap_storage() -> i64;
extern fn jj_raw_source_buffer() -> i64;
extern fn jj_raw_object_buffer() -> i64;
extern fn jj_raw_bundle_buffer() -> i64;
extern fn jj_raw_final_output_buffer() -> i64;
extern fn jj_raw_temp_path_storage() -> i64;
extern fn jj_raw_dir_path_storage() -> i64;
extern fn jj_rooted_open_parent(path: *i8, scratch: *i8, basename: *i8) -> i64;
extern fn jj_sys_is_error(p0: i64) -> i64;
extern fn jj_raw_unlinkat(p0: i64, p1: *i8) -> i64;
extern fn jj_raw_fsync(p0: i64) -> i64;
extern fn jj_raw_close(p0: i64) -> i64;
extern fn jj_raw_mkdirat(p0: i64, p1: *i8, p2: i64) -> i64;
extern fn jj_checked_open_dir(parent: i64, component: *i8) -> i64;
extern fn jj_raw_unlinkat_flags(p0: i64, p1: *i8, p2: i64) -> i64;
extern fn jj_raw_fchmod(p0: i64, p1: i64) -> i64;
// canonical interface_EXTERN_PROTOTYPES_END
fn jj_runtime_fs_cap() -> i64 {
  if jj_runtime_arena_init() != 1 { return 0; }
  var fs: *i64 = jj_raw_fs_cap_storage() as *i64;
  if fs == 0 { return 0; }
  fs[0] = 0x4a4a465343415033;
  fs[1] = 7;
  return fs as i64;
}

fn jj_runtime_memory_cap() -> i64 {
  if jj_runtime_arena_init() != 1 { return 0; }
  var memory: *i64 = jj_raw_memory_cap_storage() as *i64;
  var source: *i8 = jj_raw_source_buffer() as *i8;
  var object: *i8 = jj_raw_object_buffer() as *i8;
  var bundle: *i8 = jj_raw_bundle_buffer() as *i8;
  var final_output: *i8 = jj_raw_final_output_buffer() as *i8;
  var temp_path: *i8 = jj_raw_temp_path_storage() as *i8;
  var dir_path: *i8 = jj_raw_dir_path_storage() as *i8;
  if memory == 0 { return 0; }
  if source == 0 { return 0; }
  if object == 0 { return 0; }
  if bundle == 0 { return 0; }
  if final_output == 0 { return 0; }
  if temp_path == 0 { return 0; }
  if dir_path == 0 { return 0; }
  memory[0] = 0x4a4a4d454d434134;
  memory[1] = 7;
  memory[2] = source as i64;
  memory[3] = 1048576;
  memory[4] = 0;
  memory[5] = object as i64;
  memory[6] = 2097152;
  memory[7] = 0;
  memory[8] = 0;
  memory[9] = 0;
  memory[10] = 0;
  memory[11] = 0;
  memory[12] = 0;
  memory[13] = temp_path as i64;
  memory[14] = dir_path as i64;
  memory[15] = 0;
  memory[16] = bundle as i64;
  memory[17] = 8388608;
  memory[18] = 0;
  memory[19] = 0;
  memory[20] = 0;
  memory[21] = 0;
  return memory as i64;
}

fn jj_fs_unlink_cap(fs: *i64, path: *i8) -> i64 {
  if fs == 0 { return 114; }
  if path == 0 { return 114; }
  if fs != (jj_raw_fs_cap_storage() as *i64) { return 114; }
  if fs[0] != 0x4a4a465343415033 { return 114; }
  if (fs[1] & 4) != 4 { return 114; }
  var scratch: *i8 = jj_raw_dir_path_storage() as *i8;
  var basename: *i8 = jj_raw_temp_path_storage() as *i8;
  var parent: i64 = jj_rooted_open_parent(path, scratch, basename);
  if jj_sys_is_error(parent) != 0 { return 111; }
  var status: i64 = jj_raw_unlinkat(parent, basename);
  if status == 0 {
    if jj_raw_fsync(parent) != 0 { jj_raw_close(parent); return 115; }
    if jj_raw_close(parent) != 0 { return 115; }
    return 0;
  }
  if jj_raw_close(parent) != 0 { return 115; }
  if status == -2 { return 0; }
  return 111;
}

fn jj_fs_mkdir_cap(fs: *i64, path: *i8, mode: i64) -> i64 {
  if fs == 0 { return 114; }
  if path == 0 { return 114; }
  if fs != (jj_raw_fs_cap_storage() as *i64) { return 114; }
  if fs[0] != 0x4a4a465343415033 { return 114; }
  if (fs[1] & 2) != 2 { return 114; }
  if mode != 448 { if mode != 493 { return 114; } }
  var scratch: *i8 = jj_raw_dir_path_storage() as *i8;
  var basename: *i8 = jj_raw_temp_path_storage() as *i8;
  var parent: i64 = jj_rooted_open_parent(path, scratch, basename);
  if jj_sys_is_error(parent) != 0 { return 111; }
  var status: i64 = jj_raw_mkdirat(parent, basename, mode);
  if status != 0 { jj_raw_close(parent); if status == -17 { return 116; } return 111; }
  var child: i64 = jj_checked_open_dir(parent, basename);
  if jj_sys_is_error(child) != 0 { jj_raw_unlinkat_flags(parent,basename,512); jj_raw_close(parent); return 112; }
  if jj_raw_fchmod(child,mode) != 0 { jj_raw_close(child); jj_raw_unlinkat_flags(parent,basename,512); jj_raw_close(parent); return 112; }
  if jj_raw_fsync(child) != 0 { jj_raw_close(child); jj_raw_unlinkat_flags(parent,basename,512); jj_raw_close(parent); return 112; }
  if jj_raw_close(child) != 0 { jj_raw_unlinkat_flags(parent,basename,512); jj_raw_close(parent); return 112; }
  if jj_raw_fsync(parent) != 0 { jj_raw_close(parent); return 115; }
  if jj_raw_close(parent) != 0 { return 115; }
  return 0;
}
