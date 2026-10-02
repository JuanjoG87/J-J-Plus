// Whole-file read/write capability phase.
// Integration-hub partition R764: concrete work lives in focused phases.
// canonical interface_EXTERN_PROTOTYPES_BEGIN
extern fn jj_raw_fs_cap_storage() -> i64;
extern fn jj_raw_memory_cap_storage() -> i64;
extern fn jj_raw_source_buffer() -> i64;
extern fn jj_raw_stat_storage() -> i64;
extern fn jj_raw_dir_path_storage() -> i64;
extern fn jj_rooted_open_read(path: *i8, scratch: *i8) -> i64;
extern fn jj_sys_is_error(p0: i64) -> i64;
extern fn jj_raw_fstat(p0: i64, p1: *i8) -> i64;
extern fn jj_raw_close(p0: i64) -> i64;
extern fn jj_cap_rd32(p: *i8) -> i64;
extern fn jj_cap_rd64(p: *i8) -> i64;
extern fn jj_raw_read(p0: i64, p1: *i8, p2: i64) -> i64;
extern fn jj_raw_object_buffer() -> i64;
extern fn jj_raw_final_output_buffer() -> i64;
extern fn jj_raw_temp_path_storage() -> i64;
extern fn jj_rooted_open_parent(path: *i8, scratch: *i8, basename: *i8) -> i64;
extern fn jj_temp_name_build(destination: *i8, pid: i64) -> i64;
extern fn jj_raw_getpid() -> i64;
extern fn jj_raw_openat_wo(p0: i64, p1: *i8, p2: i64) -> i64;
extern fn jj_raw_fchmod(p0: i64, p1: i64) -> i64;
extern fn jj_raw_unlinkat(p0: i64, p1: *i8) -> i64;
extern fn jj_raw_write(p0: i64, p1: *i8, p2: i64) -> i64;
extern fn jj_raw_fsync(p0: i64) -> i64;
extern fn jj_raw_renameat(p0: i64, p1: *i8, p2: i64, p3: *i8) -> i64;
// canonical interface_EXTERN_PROTOTYPES_END
fn jj_fs_read_cap(fs: *i64, memory: *i64, path: *i8, buffer: *i8, capacity: i64) -> i64 {
  if fs == 0 { return 114; }
  if memory == 0 { return 114; }
  if path == 0 { return 114; }
  if buffer == 0 { return 114; }
  if fs != (jj_raw_fs_cap_storage() as *i64) { return 114; }
  if memory != (jj_raw_memory_cap_storage() as *i64) { return 114; }
  if fs[0] != 0x4a4a465343415033 { return 114; }
  if memory[0] != 0x4a4a4d454d434134 { return 114; }
  if (fs[1] & 1) != 1 { return 114; }
  if (memory[1] & 1) != 1 { return 114; }
  if buffer != (jj_raw_source_buffer() as *i8) { return 114; }
  if capacity != memory[3] { return 114; }
  if capacity != 1048576 { return 114; }
  var stat_buffer: *i8 = jj_raw_stat_storage() as *i8;
  var scratch: *i8 = jj_raw_dir_path_storage() as *i8;
  if stat_buffer == 0 { return 113; }
  if scratch == 0 { return 113; }
  var clear: i64 = 0;
  while clear < 256 { stat_buffer[clear] = 0; clear = clear + 1; }
  var fd: i64 = jj_rooted_open_read(path, scratch);
  if jj_sys_is_error(fd) != 0 { return 113; }
  if jj_raw_fstat(fd, stat_buffer) != 0 { jj_raw_close(fd); return 113; }
  var mode: i64 = jj_cap_rd32(stat_buffer + 24);
  if (mode & 61440) != 32768 { jj_raw_close(fd); return 113; }
  var initial_dev: i64 = jj_cap_rd64(stat_buffer + 0);
  var initial_ino: i64 = jj_cap_rd64(stat_buffer + 8);
  var initial_mode: i64 = mode;
  var expected: i64 = jj_cap_rd64(stat_buffer + 48);
  var initial_mtime_sec: i64 = jj_cap_rd64(stat_buffer + 88);
  var initial_mtime_nsec: i64 = jj_cap_rd64(stat_buffer + 96);
  var initial_ctime_sec: i64 = jj_cap_rd64(stat_buffer + 104);
  var initial_ctime_nsec: i64 = jj_cap_rd64(stat_buffer + 112);
  if expected <= 0 { jj_raw_close(fd); return 113; }
  if expected > capacity { jj_raw_close(fd); return 113; }
  var total: i64 = 0;
  while total < expected {
    var amount: i64 = jj_raw_read(fd, buffer + total, expected - total);
    if amount == -4 { }
    else {
      if jj_sys_is_error(amount) != 0 { jj_raw_close(fd); return 113; }
      if amount == 0 { jj_raw_close(fd); return 113; }
      total = total + amount;
    }
  }
  var probe: *i8 = stat_buffer + 192;
  var extra: i64 = jj_raw_read(fd, probe, 1);
  while extra == -4 { extra = jj_raw_read(fd, probe, 1); }
  if jj_sys_is_error(extra) != 0 { jj_raw_close(fd); return 113; }
  if extra != 0 { jj_raw_close(fd); return 113; }
  clear = 0;
  while clear < 192 { stat_buffer[clear] = 0; clear = clear + 1; }
  if jj_raw_fstat(fd, stat_buffer) != 0 { jj_raw_close(fd); return 113; }
  if jj_cap_rd64(stat_buffer + 0) != initial_dev { jj_raw_close(fd); return 113; }
  if jj_cap_rd64(stat_buffer + 8) != initial_ino { jj_raw_close(fd); return 113; }
  if jj_cap_rd32(stat_buffer + 24) != initial_mode { jj_raw_close(fd); return 113; }
  if jj_cap_rd64(stat_buffer + 48) != expected { jj_raw_close(fd); return 113; }
  if jj_cap_rd64(stat_buffer + 88) != initial_mtime_sec { jj_raw_close(fd); return 113; }
  if jj_cap_rd64(stat_buffer + 96) != initial_mtime_nsec { jj_raw_close(fd); return 113; }
  if jj_cap_rd64(stat_buffer + 104) != initial_ctime_sec { jj_raw_close(fd); return 113; }
  if jj_cap_rd64(stat_buffer + 112) != initial_ctime_nsec { jj_raw_close(fd); return 113; }
  if jj_raw_close(fd) != 0 { return 113; }
  memory[4] = total;
  return 0;
}

fn jj_fs_write_cap(fs: *i64, memory: *i64, path: *i8, buffer: *i8, length: i64) -> i64 {
  if fs == 0 { return 114; }
  if memory == 0 { return 114; }
  if path == 0 { return 114; }
  if buffer == 0 { return 114; }
  if fs != (jj_raw_fs_cap_storage() as *i64) { return 114; }
  if memory != (jj_raw_memory_cap_storage() as *i64) { return 114; }
  if fs[0] != 0x4a4a465343415033 { return 114; }
  if memory[0] != 0x4a4a4d454d434134 { return 114; }
  if (fs[1] & 6) != 6 { return 114; }
  if (memory[1] & 4) != 4 { return 114; }
  var approved_pair: i64 = 0;
  if buffer == (jj_raw_object_buffer() as *i8) { if memory[5] == (jj_raw_object_buffer() as i64) { if memory[6] == 2097152 { approved_pair = 1; } } }
  if buffer == (jj_raw_final_output_buffer() as *i8) { if memory[5] == (jj_raw_final_output_buffer() as i64) { if memory[6] == 5242880 { approved_pair = 1; } } }
  if approved_pair == 0 { return 114; }
  if length != memory[7] { return 114; }
  if length <= 0 { return 114; }
  if length > memory[6] { return 114; }
  if memory[15] != 1 { return 114; }
  var path_storage: *i8 = jj_raw_temp_path_storage() as *i8;
  var scratch: *i8 = jj_raw_dir_path_storage() as *i8;
  if path_storage == 0 { return 114; }
  if scratch == 0 { return 114; }
  var basename: *i8 = path_storage;
  var temp_name: *i8 = path_storage + 4096;
  var parent: i64 = jj_rooted_open_parent(path, scratch, basename);
  if jj_sys_is_error(parent) != 0 { return 111; }
  var mode: i64 = memory[20];
  if mode == 0 {
    mode = 384;
    if length >= 18 {
      if buffer[0] == 0x7f { if buffer[1] == 69 { if buffer[2] == 76 { if buffer[3] == 70 {
        if buffer[16] == 3 { if buffer[17] == 0 { mode = 457; } }
      } } } }
    }
  } else {
    if mode != 384 { if mode != 420 { if mode != 457 { return 114; } } }
  }
  var temp_length: i64 = jj_temp_name_build(temp_name, jj_raw_getpid());
  if temp_length == 0 { jj_raw_close(parent); return 111; }
  var fd: i64 = 0xffffffffffffffff;
  var attempt: i64 = 0;
  while attempt < 64 {
    var high: i64 = attempt / 16;
    var low: i64 = attempt % 16;
    if high < 10 { temp_name[temp_length - 2] = 48 + high; } else { temp_name[temp_length - 2] = 87 + high; }
    if low < 10 { temp_name[temp_length - 1] = 48 + low; } else { temp_name[temp_length - 1] = 87 + low; }
    fd = jj_raw_openat_wo(parent, temp_name, mode);
    if fd == -17 { attempt = attempt + 1; }
    else { if jj_sys_is_error(fd) != 0 { jj_raw_close(parent); return 111; } break; }
  }
  if jj_sys_is_error(fd) != 0 { jj_raw_close(parent); return 111; }
  if jj_raw_fchmod(fd, mode) != 0 { jj_raw_close(fd); jj_raw_unlinkat(parent, temp_name); jj_raw_close(parent); return 112; }
  var total: i64 = 0;
  while total < length {
    var amount: i64 = jj_raw_write(fd, buffer + total, length - total);
    if amount == -4 { }
    else {
      if jj_sys_is_error(amount) != 0 { jj_raw_close(fd); jj_raw_unlinkat(parent, temp_name); jj_raw_close(parent); return 112; }
      if amount == 0 { jj_raw_close(fd); jj_raw_unlinkat(parent, temp_name); jj_raw_close(parent); return 112; }
      total = total + amount;
    }
  }
  if jj_raw_fsync(fd) != 0 { jj_raw_close(fd); jj_raw_unlinkat(parent, temp_name); jj_raw_close(parent); return 112; }
  if jj_raw_close(fd) != 0 { jj_raw_unlinkat(parent, temp_name); jj_raw_close(parent); return 112; }
  if jj_raw_renameat(parent, temp_name, parent, basename) != 0 { jj_raw_unlinkat(parent, temp_name); jj_raw_close(parent); return 112; }
  memory[15] = 2;
  if jj_raw_fsync(parent) != 0 { jj_raw_close(parent); return 115; }
  if jj_raw_close(parent) != 0 { return 115; }
  memory[15] = 3;
  return 0;
}
