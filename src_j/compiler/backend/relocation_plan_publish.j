fn jj_relocation_plan_publish(state: *i64, node: *i64, rela: *i8, rela_end: *i8) -> i64 {
  if state == 0 { return 0; }
  if node == 0 { return 0; }
  if rela == 0 { return 0; }
  if rela_end == 0 { return 0; }
  if ((state as i64) & 7) != 0 { return 0; }
  if ((node as i64) & 7) != 0 { return 0; }
  if ((rela as i64) & 7) != 0 { return 0; }
  if ((rela_end as i64) & 7) != 0 { return 0; }
  if rela_end < rela { return 0; }
  if state[9] != 0 { return 0; }
  if node[0] < 58 { return 0; }
  if node[0] > 98 { return 0; }
  if state[0] <= 0 { return 0; }
  if node[2] != state[0] { return 0; }
  var semantic: i64 = state[1];
  if semantic < 1 { return 0; }
  if semantic > 2 { return 0; }
  var symbol: i64 = state[5];
  if symbol < 1 { return 0; }
  if symbol > 10 { return 0; }
  var count: i64 = state[6];
  if count < 0 { return 0; }
  if count >= 120 { return 0; }
  if state[2] < 0 { return 0; }
  if state[3] < 0 { return 0; }
  if state[4] < 0 { return 0; }
  if state[2] > 20480 { return 0; }
  if state[3] > 20480 - state[2] { return 0; }
  var offset: i64 = state[2] + state[3];
  if state[4] > 20480 - offset { return 0; }
  offset = offset + state[4];
  var record8: *i8 = rela + count * 24;
  if record8 < rela { return 0; }
  var next: *i8 = record8 + 24;
  if next < record8 { return 0; }
  if next > rela_end { return 0; }
  var relocation_type: i64 = 2;
  if semantic == 1 { relocation_type = 4; }
  var record: *i64 = record8 as *i64;
  record[0] = offset;
  record[1] = (symbol << 32) | relocation_type;
  record[2] = 0xfffffffffffffffc;
  state[7] = relocation_type;
  state[8] = offset;
  state[9] = 1;
  state[6] = count + 1;
  return 1;
}
