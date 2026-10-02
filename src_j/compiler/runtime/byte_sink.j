fn jj_sink_emit8(out: *i8, capacity: i64, cursor: *i64, value: i64) -> i64 {
  if out == 0 { return 0; }
  if cursor == 0 { return 0; }
  if capacity < 0 { return 0; }
  var position: i64 = cursor[0];
  if position < 0 { return 0; }
  if position >= capacity { return 0; }
  out[position] = value;
  cursor[0] = position + 1;
  return 1;
}

fn jj_sink_emit16(out: *i8, capacity: i64, cursor: *i64, value: i64) -> i64 {
  if jj_sink_emit8(out, capacity, cursor, value) == 0 { return 0; }
  return jj_sink_emit8(out, capacity, cursor, value >>> 8);
}

fn jj_sink_emit32(out: *i8, capacity: i64, cursor: *i64, value: i64) -> i64 {
  var i: i64 = 0;
  while i < 4 {
    if jj_sink_emit8(out, capacity, cursor, value >>> (i * 8)) == 0 { return 0; }
    i = i + 1;
  }
  return 1;
}

fn jj_sink_emit64(out: *i8, capacity: i64, cursor: *i64, value: i64) -> i64 {
  var i: i64 = 0;
  while i < 8 {
    if jj_sink_emit8(out, capacity, cursor, value >>> (i * 8)) == 0 { return 0; }
    i = i + 1;
  }
  return 1;
}

fn jj_sink_write8_at(out: *i8, capacity: i64, position: i64, value: i64) -> i64 {
  if out == 0 { return 0; }
  if position < 0 { return 0; }
  if position >= capacity { return 0; }
  out[position] = value;
  return 1;
}

fn jj_sink_write16_at(out: *i8, capacity: i64, position: i64, value: i64) -> i64 {
  if position < 0 { return 0; }
  if capacity < 2 { return 0; }
  if position > capacity - 2 { return 0; }
  out[position] = value;
  out[position + 1] = value >>> 8;
  return 1;
}

fn jj_sink_write32_at(out: *i8, capacity: i64, position: i64, value: i64) -> i64 {
  if position < 0 { return 0; }
  if capacity < 4 { return 0; }
  if position > capacity - 4 { return 0; }
  var i: i64 = 0;
  while i < 4 { out[position + i] = value >>> (i * 8); i = i + 1; }
  return 1;
}

fn jj_sink_write64_at(out: *i8, capacity: i64, position: i64, value: i64) -> i64 {
  if position < 0 { return 0; }
  if capacity < 8 { return 0; }
  if position > capacity - 8 { return 0; }
  var i: i64 = 0;
  while i < 8 { out[position + i] = value >>> (i * 8); i = i + 1; }
  return 1;
}

fn jj_sink_patch32(out: *i8, capacity: i64, emitted: i64, position: i64, value: i64) -> i64 {
  if emitted < 0 { return 0; }
  if emitted > capacity { return 0; }
  if position < 0 { return 0; }
  if emitted < 4 { return 0; }
  if position > emitted - 4 { return 0; }
  return jj_sink_write32_at(out, capacity, position, value);
}
