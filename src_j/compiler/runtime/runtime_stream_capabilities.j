// Bounded streaming file capability phase.
// Integration-hub partition R764: concrete work lives in focused phases.
// canonical interface_EXTERN_PROTOTYPES_BEGIN
extern fn jj_raw_fs_cap_storage() -> i64;
extern fn jj_raw_stat_storage() -> i64;
extern fn jj_raw_dir_path_storage() -> i64;
extern fn jj_rooted_open_read(path: *i8, scratch: *i8) -> i64;
extern fn jj_sys_is_error(p0: i64) -> i64;
extern fn jj_raw_fstat(p0: i64, p1: *i8) -> i64;
extern fn jj_raw_close(p0: i64) -> i64;
extern fn jj_cap_rd32(p: *i8) -> i64;
extern fn jj_cap_rd64(p: *i8) -> i64;
extern fn jj_raw_read(p0: i64, p1: *i8, p2: i64) -> i64;
// canonical interface_EXTERN_PROTOTYPES_END
fn jj_stream_seal(state: *i64) -> i64 {
  if state == 0 { return 0; }
  return 0x4a4a5354524d5345 ^ (state as i64) ^ state[2] ^ state[3] ^ state[4] ^ state[5] ^ state[6] ^ state[7] ^ state[8] ^ state[9] ^ state[10] ^ state[11] ^ state[12] ^ state[13] ^ state[14] ^ state[15] ^ state[16] ^ state[17] ^ state[19] ^ state[20] ^ state[21];
}

fn jj_stream_valid(state: *i64) -> i64 {
  if state == 0 { return 0; }
  if state[0] != 0x4a4a5354524d3031 { return 0; }
  if state[1] != (state as i64) { return 0; }
  if state[2] < 0 { return 0; }
  if state[3] <= 0 { return 0; }
  if state[3] > 1048576 { return 0; }
  if state[4] < 0 { return 0; }
  if state[4] > state[3] { return 0; }
  if state[5] == 0 { return 0; }
  if state[6] < 64 { return 0; }
  if state[6] > 4096 { return 0; }
  if state[7] < 0 { return 0; }
  if state[8] < 0 { return 0; }
  if state[7] > state[8] { return 0; }
  if state[8] > state[6] { return 0; }
  if state[16] < 0 { return 0; }
  if state[16] > 1 { return 0; }
  if state[17] != 0 { return 0; }
  if state[19] < 0 { return 0; }
  if state[19] > state[4] { return 0; }
  if state[20] < 0 { return 0; }
  if state[20] > 1 { return 0; }
  if state[18] != jj_stream_seal(state) { return 0; }
  return 1;
}

fn jj_fs_stream_open(fs: *i64, path: *i8, state: *i64, chunk: *i8, chunk_capacity: i64) -> i64 {
  if fs == 0 { return 0; }
  if path == 0 { return 0; }
  if state == 0 { return 0; }
  if chunk == 0 { return 0; }
  if fs != (jj_raw_fs_cap_storage() as *i64) { return 0; }
  if fs[0] != 0x4a4a465343415033 { return 0; }
  if (fs[1] & 1) != 1 { return 0; }
  if chunk_capacity < 64 { return 0; }
  if chunk_capacity > 4096 { return 0; }
  var state_start: i64 = state as i64;
  if state_start > 0x7fffffffffffff3f { return 0; }
  var state_end: i64 = state_start + 192;
  var chunk_start: i64 = chunk as i64;
  if chunk_start > 0x7fffffffffffffff - chunk_capacity { return 0; }
  var chunk_end: i64 = chunk_start + chunk_capacity;
  if state_start < chunk_end { if chunk_start < state_end { return 0; } }
  var clear: i64 = 0;
  while clear < 24 { state[clear] = 0; clear = clear + 1; }
  var stat_buffer: *i8 = jj_raw_stat_storage() as *i8;
  var scratch: *i8 = jj_raw_dir_path_storage() as *i8;
  if stat_buffer == 0 { return 0; }
  if scratch == 0 { return 0; }
  clear = 0;
  while clear < 256 { stat_buffer[clear] = 0; clear = clear + 1; }
  var fd: i64 = jj_rooted_open_read(path, scratch);
  if jj_sys_is_error(fd) != 0 { return 0; }
  if jj_raw_fstat(fd, stat_buffer) != 0 { jj_raw_close(fd); return 0; }
  var mode: i64 = jj_cap_rd32(stat_buffer + 24);
  if (mode & 61440) != 32768 { jj_raw_close(fd); return 0; }
  var expected: i64 = jj_cap_rd64(stat_buffer + 48);
  if expected <= 0 { jj_raw_close(fd); return 0; }
  if expected > 1048576 { jj_raw_close(fd); return 0; }
  state[0] = 0x4a4a5354524d3031;
  state[1] = state as i64;
  state[2] = fd;
  state[3] = expected;
  state[4] = 0;
  state[5] = chunk as i64;
  state[6] = chunk_capacity;
  state[7] = 0;
  state[8] = 0;
  state[9] = jj_cap_rd64(stat_buffer + 0);
  state[10] = jj_cap_rd64(stat_buffer + 8);
  state[11] = mode;
  state[12] = jj_cap_rd64(stat_buffer + 88);
  state[13] = jj_cap_rd64(stat_buffer + 96);
  state[14] = jj_cap_rd64(stat_buffer + 104);
  state[15] = jj_cap_rd64(stat_buffer + 112);
  state[16] = 0;
  state[17] = 0;
  state[19] = 0;
  state[20] = 0;
  state[21] = 0;
  state[18] = jj_stream_seal(state);
  return 1;
}

fn jj_stream_fill(state: *i64) -> i64 {
  if jj_stream_valid(state) == 0 { return -1; }
  if state[7] < state[8] { return 1; }
  state[7] = 0;
  state[8] = 0;
  if state[4] == state[3] {
    var chunk: *i8 = state[5] as *i8;
    var extra: i64 = jj_raw_read(state[2], chunk, 1);
    while extra == -4 { extra = jj_raw_read(state[2], chunk, 1); }
    if jj_sys_is_error(extra) != 0 { return -1; }
    if extra != 0 { return -1; }
    state[16] = 1;
    state[18] = jj_stream_seal(state);
    return 0;
  }
  var remaining: i64 = state[3] - state[4];
  var request: i64 = state[6];
  if request > remaining { request = remaining; }
  var buffer: *i8 = state[5] as *i8;
  var amount: i64 = jj_raw_read(state[2], buffer, request);
  while amount == -4 { amount = jj_raw_read(state[2], buffer, request); }
  if jj_sys_is_error(amount) != 0 { return -1; }
  if amount <= 0 { return -1; }
  if amount > request { return -1; }
  state[4] = state[4] + amount;
  state[7] = 0;
  state[8] = amount;
  state[18] = jj_stream_seal(state);
  return 1;
}

fn jj_fs_stream_next_line(fs: *i64, state: *i64, line: *i8, line_capacity: i64) -> i64 {
  if fs == 0 { return -1; }
  if fs != (jj_raw_fs_cap_storage() as *i64) { return -1; }
  if fs[0] != 0x4a4a465343415033 { return -1; }
  if (fs[1] & 1) != 1 { return -1; }
  if jj_stream_valid(state) == 0 { return -1; }
  if line == 0 { return -1; }
  if line_capacity < 2 { return -1; }
  if line_capacity > 8192 { return -1; }
  var length: i64 = 0;
  while 1 {
    if state[20] != 0 {
      if state[7] >= state[8] {
        state[18] = jj_stream_seal(state);
        var pending_fill: i64 = jj_stream_fill(state);
        if pending_fill < 0 { return -1; }
        if pending_fill == 0 { state[20] = 0; state[18] = jj_stream_seal(state); }
      }
      if state[7] < state[8] {
        var pending_buffer: *i8 = state[5] as *i8;
        if pending_buffer[state[7]] == 10 {
          state[7] = state[7] + 1;
          state[19] = state[19] + 1;
        }
        state[20] = 0;
        state[18] = jj_stream_seal(state);
      }
    }
    if state[7] >= state[8] {
      state[18] = jj_stream_seal(state);
      var fill: i64 = jj_stream_fill(state);
      if fill < 0 { return -1; }
      if fill == 0 {
        if length == 0 { return 0; }
        line[length] = 0;
        state[21] = state[21] + 1;
        state[18] = jj_stream_seal(state);
        return length + 1;
      }
    }
    var buffer: *i8 = state[5] as *i8;
    var c: i64 = buffer[state[7]];
    state[7] = state[7] + 1;
    state[19] = state[19] + 1;
    if c == 0 { return -1; }
    if c == 10 {
      line[length] = 0;
      state[21] = state[21] + 1;
      state[18] = jj_stream_seal(state);
      return length + 1;
    }
    if c == 13 {
      line[length] = 0;
      state[20] = 1;
      state[21] = state[21] + 1;
      state[18] = jj_stream_seal(state);
      return length + 1;
    }
    if length >= line_capacity - 1 { return -1; }
    line[length] = c;
    length = length + 1;
    state[18] = jj_stream_seal(state);
  }
  return -1;
}

fn jj_fs_stream_abort(fs: *i64, state: *i64) -> i64 {
  if fs == 0 { return 0; }
  if state == 0 { return 0; }
  if fs != (jj_raw_fs_cap_storage() as *i64) { return 0; }
  if state[0] != 0x4a4a5354524d3031 { return 0; }
  if state[1] != (state as i64) { return 0; }
  var fd: i64 = state[2];
  var status: i64 = 0;
  if fd >= 0 { status = jj_raw_close(fd); }
  var i: i64 = 0;
  while i < 24 { state[i] = 0; i = i + 1; }
  if status != 0 { return 0; }
  return 1;
}

fn jj_fs_stream_finish(fs: *i64, state: *i64) -> i64 {
  if fs == 0 { return 0; }
  if fs != (jj_raw_fs_cap_storage() as *i64) { return 0; }
  if jj_stream_valid(state) == 0 { return 0; }
  var valid: i64 = 1;
  if state[4] != state[3] { valid = 0; }
  if state[19] != state[3] { valid = 0; }
  if state[7] != state[8] { valid = 0; }
  if state[16] != 1 { valid = 0; }
  var stat_buffer: *i8 = jj_raw_stat_storage() as *i8;
  if stat_buffer == 0 { valid = 0; }
  if valid != 0 {
    var clear: i64 = 0;
    while clear < 192 { stat_buffer[clear] = 0; clear = clear + 1; }
    if jj_raw_fstat(state[2], stat_buffer) != 0 { valid = 0; }
    if valid != 0 {
      if jj_cap_rd64(stat_buffer + 0) != state[9] { valid = 0; }
      if jj_cap_rd64(stat_buffer + 8) != state[10] { valid = 0; }
      if jj_cap_rd32(stat_buffer + 24) != state[11] { valid = 0; }
      if jj_cap_rd64(stat_buffer + 48) != state[3] { valid = 0; }
      if jj_cap_rd64(stat_buffer + 88) != state[12] { valid = 0; }
      if jj_cap_rd64(stat_buffer + 96) != state[13] { valid = 0; }
      if jj_cap_rd64(stat_buffer + 104) != state[14] { valid = 0; }
      if jj_cap_rd64(stat_buffer + 112) != state[15] { valid = 0; }
    }
  }
  var close_status: i64 = jj_raw_close(state[2]);
  var i: i64 = 0;
  while i < 24 { state[i] = 0; i = i + 1; }
  if close_status != 0 { return 0; }
  return valid;
}
