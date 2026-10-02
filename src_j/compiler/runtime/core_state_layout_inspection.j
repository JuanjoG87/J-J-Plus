// on-demand inspection companion; excluded from resident selfhost closures.

fn jj_core_sink_output(core: *i64) -> i64 {
  if core == 0 { return 0; }
  return core[7];
}
fn jj_core_sink_capacity(core: *i64) -> i64 {
  if core == 0 { return 0; }
  return core[8];
}
fn jj_core_sink_cursor(core: *i64) -> i64 {
  if core == 0 { return 0; }
  return (core as i64) + 72;
}
fn jj_core_sink_position(core: *i64) -> i64 {
  if core == 0 { return 0; }
  return core[9];
}
fn jj_core_sink_set_position(core: *i64, position: i64) -> i64 {
  if core == 0 { return 0; }
  if position < 0 { return 0; }
  if position > core[8] { return 0; }
  core[9] = position;
  return 1;
}
fn jj_core_source_base(core: *i64) -> i64 {
  if core == 0 { return 0; }
  return core[0];
}
fn jj_core_source_length(core: *i64) -> i64 {
  if core == 0 { return 0; }
  return core[1];
}
