fn divide_guard(value:i64, divisor:i64)->i64 {
  require divisor != 0 else return 0;
  return value / divisor;
}

fn j_main(argc:i64, argv:*i64)->i64 {
  if divide_guard(12, 3) != 4 { return 1; }
  if divide_guard(12, 0) != 0 { return 2; }
  return 0;
}
