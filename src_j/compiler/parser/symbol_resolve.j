fn jj_parser_symbol_resolve(keys: *i64, widths: *i8, count: i64, needle: i64, required: i64) -> i64 {
  if keys == 0 { return 0xffffffffffffffff; }
  if count <= 0 { return 0xffffffffffffffff; }
  if count > 5 { return 0xffffffffffffffff; }
  if required < 0 { return 0xffffffffffffffff; }
  if required > 255 { return 0xffffffffffffffff; }
  if required != 0 { if widths == 0 { return 0xffffffffffffffff; } }
  var index: i64 = 0;
  while index < count {
    if keys[index] == needle {
      if required == 0 { return index; }
      if widths[index] == required { return index; }
    }
    index = index + 1;
  }
  return 0xffffffffffffffff;
}
