fn jj_symbol_pool_intern(pool: *i8, cursor: *i64, end: *i8, bytes: *i8, length: i64) -> i64 {
  if pool == 0 { return 0; }
  if cursor == 0 { return 0; }
  if end == 0 { return 0; }
  if bytes == 0 { return 0; }
  if length < 0 { return 0; }
  if length > 255 { return 0; }
  var current: *i8 = cursor[0] as *i8;
  if current < pool { return 0; }
  if current > end { return 0; }
  var scan: *i8 = pool;
  while scan < current {
    var stored: i64 = scan[0];
    var next: *i8 = scan + stored + 2;
    if next <= scan { return 0; }
    if next > current { return 0; }
    if stored == length {
      var equal: i64 = 1;
      var i: i64 = 0;
      while i < length {
        if scan[1 + i] != bytes[i] { equal = 0; }
        i = i + 1;
      }
      if equal != 0 { return (scan + 1) as i64; }
    }
    scan = next;
  }
  if scan != current { return 0; }
  var publish_end: *i8 = current + length + 2;
  if publish_end <= current { return 0; }
  if publish_end > end { return 0; }
  current[0] = length;
  var copy: i64 = 0;
  while copy < length { current[1 + copy] = bytes[copy]; copy = copy + 1; }
  current[1 + length] = 0;
  cursor[0] = publish_end as i64;
  return (current + 1) as i64;
}
