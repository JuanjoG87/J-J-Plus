fn jj_statement_rollback(context: *i64, original_cursor: *i64, original_count: i64, original_ast_count: i64, current_cursor: *i64, jir_end: *i64) -> i64 {
  var cursor_slot: *i64 = context[4] as *i64;
  var count_slot: *i64 = context[5] as *i64;
  var ast_count_slot: *i64 = context[8] as *i64;
  cursor_slot[0] = original_cursor as i64;
  count_slot[0] = original_count;
  ast_count_slot[0] = original_ast_count;
  if original_cursor < jir_end {
    var clear_end: *i64 = current_cursor + 32;
    if clear_end < current_cursor { clear_end = jir_end; }
    if clear_end > jir_end { clear_end = jir_end; }
    var clear: *i64 = original_cursor;
    while clear < clear_end { clear[0] = 0; clear = clear + 8; }
  }
  return 0;
}

fn jj_statement_lower_commit(context: *i64, ast: *i64, ast_end: *i64, jir: *i64, jir_end: *i64) -> i64 {
  if context == 0 { return 0; }
  if ast == 0 { return 0; }
  if ast_end == 0 { return 0; }
  if jir == 0 { return 0; }
  if jir_end == 0 { return 0; }
  if ast >= ast_end { return 0; }
  if jir > jir_end { return 0; }
  if (((ast as i64) | (ast_end as i64) | (jir as i64) | (jir_end as i64)) & 7) != 0 { return 0; }
  var ast_bytes: i64 = (ast_end as i64) - (ast as i64);
  if (ast_bytes & 31) != 0 { return 0; }
  var records: i64 = ast_bytes / 32;
  var jir_bytes: i64 = (jir_end as i64) - (jir as i64);
  if (jir_bytes & 31) != 0 { return 0; }
  if (jir_bytes / 32) < records { return 0; }
  if context[0] == 0 { return 0; }
  if context[1] == 0 { return 0; }
  if context[2] < 0 { return 0; }
  if context[2] > 5 { return 0; }
  if context[3] == 0 { return 0; }
  if context[4] == 0 { return 0; }
  if context[5] == 0 { return 0; }
  if context[6] <= 0 { return 0; }
  if records > context[6] { return 0; }
  var cursor_slot: *i64 = context[4] as *i64;
  var count_slot: *i64 = context[5] as *i64;
  var ast_count_slot: *i64 = context[8] as *i64;
  if cursor_slot[0] != (jir as i64) { return 0; }
  var original_count: i64 = count_slot[0];
  if original_count < 0 { return 0; }
  if original_count > context[6] { return 0; }
  if context[7] == 0 { return 0; }
  if (context[7] & 7) != 0 { return 0; }
  if context[7] > (jir as i64) { return 0; }
  if original_count > 0x07ffffffffffffff { return 0; }
  if context[7] + original_count * 32 != (jir as i64) { return 0; }
  if context[8] == 0 { return 0; }
  if ast_count_slot[0] != records { return 0; }
  var original_cursor: *i64 = jir;
  var original_ast_count: i64 = records;
  var ast_cursor: *i64 = ast;
  var current_cursor: *i64 = jir;
  var produced: i64 = 0;
  while ast_cursor < ast_end {
    var remaining: i64 = (ast_end as i64) - (ast_cursor as i64);
    if remaining < 64 { return jj_statement_rollback(context, original_cursor, original_count, original_ast_count, current_cursor, jir_end); }
    if ast_cursor[0] != 1 { return jj_statement_rollback(context, original_cursor, original_count, original_ast_count, current_cursor, jir_end); }
    var shape: i64 = 0;
    var next_kind: i64 = ast_cursor[4];
    if next_kind == 5 {
      if remaining < 96 { return jj_statement_rollback(context, original_cursor, original_count, original_ast_count, current_cursor, jir_end); }
      if ast_cursor[8] != 8 { return jj_statement_rollback(context, original_cursor, original_count, original_ast_count, current_cursor, jir_end); }
      if ast_cursor[5] != ast_cursor[9] { return jj_statement_rollback(context, original_cursor, original_count, original_ast_count, current_cursor, jir_end); }
      if ast_cursor[6] != ast_cursor[10] { return jj_statement_rollback(context, original_cursor, original_count, original_ast_count, current_cursor, jir_end); }
      shape = 3;
    } else { if next_kind == 6 {
      if remaining < 128 { return jj_statement_rollback(context, original_cursor, original_count, original_ast_count, current_cursor, jir_end); }
      if ast_cursor[8] != 7 { return jj_statement_rollback(context, original_cursor, original_count, original_ast_count, current_cursor, jir_end); }
      if ast_cursor[12] != 8 { return jj_statement_rollback(context, original_cursor, original_count, original_ast_count, current_cursor, jir_end); }
      if ast_cursor[5] != ast_cursor[9] { return jj_statement_rollback(context, original_cursor, original_count, original_ast_count, current_cursor, jir_end); }
      if ast_cursor[5] != ast_cursor[13] { return jj_statement_rollback(context, original_cursor, original_count, original_ast_count, current_cursor, jir_end); }
      if ast_cursor[6] != ast_cursor[10] { return jj_statement_rollback(context, original_cursor, original_count, original_ast_count, current_cursor, jir_end); }
      if ast_cursor[6] != ast_cursor[14] { return jj_statement_rollback(context, original_cursor, original_count, original_ast_count, current_cursor, jir_end); }
      shape = 4;
    } else {
      if next_kind == 2 { shape = 2; }
      else { if next_kind == 4 { shape = 2; }
      else { if next_kind >= 10 { if next_kind <= 22 { shape = 2; } } } }
      if shape == 0 { return jj_statement_rollback(context, original_cursor, original_count, original_ast_count, current_cursor, jir_end); }
    } }
    var step: i64 = 0;
    while step < shape {
      if current_cursor + 32 > jir_end { return jj_statement_rollback(context, original_cursor, original_count, original_ast_count, current_cursor, jir_end); }
      var frame: [5]i64;
      frame[0] = context[0];
      frame[1] = context[1];
      frame[2] = context[2];
      frame[3] = (ast_cursor + step * 32) as i64;
      frame[4] = current_cursor as i64;
      var lowered: i64 = jj_unsafe_abi_call5_frame(context[3], frame as *i64);
      if lowered != ((current_cursor + 32) as i64) { return jj_statement_rollback(context, original_cursor, original_count, original_ast_count, current_cursor, jir_end); }
      current_cursor = current_cursor + 32;
      produced = produced + 1;
      step = step + 1;
    }
    ast_cursor = ast_cursor + shape * 32;
  }
  if cursor_slot[0] != (original_cursor as i64) { return jj_statement_rollback(context, original_cursor, original_count, original_ast_count, current_cursor, jir_end); }
  if count_slot[0] != original_count { return jj_statement_rollback(context, original_cursor, original_count, original_ast_count, current_cursor, jir_end); }
  if ast_count_slot[0] != original_ast_count { return jj_statement_rollback(context, original_cursor, original_count, original_ast_count, current_cursor, jir_end); }
  if produced != records { return jj_statement_rollback(context, original_cursor, original_count, original_ast_count, current_cursor, jir_end); }
  if original_count > context[6] - produced { return jj_statement_rollback(context, original_cursor, original_count, original_ast_count, current_cursor, jir_end); }
  cursor_slot[0] = current_cursor as i64;
  count_slot[0] = original_count + produced;
  return current_cursor as i64;
}
