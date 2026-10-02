// canonical interface_EXTERN_PROTOTYPES_BEGIN
extern fn jj_parser_symbol_resolve(p0: *i64, p1: *i8, p2: i64, p3: i64, p4: i64) -> i64;
// canonical interface_EXTERN_PROTOTYPES_END
fn jj_expression_resolve_lower(keys: *i64, widths: *i8, count: i64, expression: *i64, out: *i64) -> i64 {
  if keys == 0 { return 0; }
  if expression == 0 { return 0; }
  if out == 0 { return 0; }
  var kind: i64 = expression[0];
  var opcode: i64 = 0;
  var mode: i64 = 0;
  if kind == 1 { opcode = 48; }
  else { if kind == 2 { opcode = 32; }
  else { if kind == 4 { opcode = 33; }
  else { if kind == 5 { opcode = 40; }
  else { if kind == 6 { opcode = 40; }
  else { if kind == 7 { opcode = 41; }
  else { if kind == 8 { opcode = 42; }
  else { if kind == 10 { opcode = 50; }
  else { if kind >= 13 { if kind <= 21 { opcode = kind + 40; } else { mode = 4; } }
  else { mode = 4; } } } } } } } } }
  if mode == 4 {
    mode = 1;
    if kind == 22 { opcode = 63; }
    else { if kind == 23 { opcode = 83; }
    else { if kind == 24 { opcode = 67; }
    else { if kind == 25 { opcode = 0; mode = 2; }
    else { if kind == 26 { opcode = 64; }
    else { if kind == 27 { opcode = 72; }
    else { if kind == 28 { opcode = 75; }
    else { if kind == 29 { opcode = 76; mode = 3; }
    else { return 0; } } } } } } } }
  }
  if mode == 0 {
    out[0] = opcode; out[1] = expression[1]; out[2] = expression[2]; out[3] = expression[3];
    return (out + 32) as i64;
  }
  if count <= 0 { return 0; }
  if count > 5 { return 0; }
  var required: i64 = expression[3];
  if required < 0 { return 0; }
  if required > 255 { return 0; }
  if mode == 2 { if widths == 0 { return 0; } }
  else { if required != 0 { if widths == 0 { return 0; } } }
  var index: i64 = jj_parser_symbol_resolve(keys, widths, count, expression[1], required);
  if index == 0xffffffffffffffff { return 0; }
  var payload: i64 = 0;
  if mode == 2 {
    var width: i64 = widths[index];
    if width == 1 {
      payload = expression[2];
      if payload < 0 { return 0; }
      if payload > 127 { return 0; }
      opcode = 72;
    } else {
      if width != 8 { return 0; }
      if expression[2] < 0 { return 0; }
      if expression[2] > 15 { return 0; }
      payload = expression[2] * 8;
      opcode = 64;
    }
  } else {
    if mode == 3 { payload = expression[2]; }
  }
  out[0] = opcode;
  out[1] = index;
  out[2] = payload;
  out[3] = 0;
  return (out + 32) as i64;
}
