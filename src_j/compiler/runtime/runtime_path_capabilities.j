// Rooted path validation and no-follow open capability phase.
// Integration-hub partition R764: concrete work lives in focused phases.
// canonical interface_EXTERN_PROTOTYPES_BEGIN
extern fn jj_raw_stat_storage() -> i64;
extern fn jj_raw_fstatat_nofollow(p0: i64, p1: *i8, p2: *i8) -> i64;
extern fn jj_raw_openat_dir(p0: i64, p1: *i8) -> i64;
extern fn jj_sys_is_error(p0: i64) -> i64;
extern fn jj_raw_fstat(p0: i64, p1: *i8) -> i64;
extern fn jj_raw_close(p0: i64) -> i64;
extern fn jj_raw_openat_ro(p0: i64, p1: *i8) -> i64;
extern fn jj_raw_open_root() -> i64;
// canonical interface_EXTERN_PROTOTYPES_END
fn jj_cap_rd32(p: *i8) -> i64 {
  return (p[0] & 255) | ((p[1] & 255) << 8) | ((p[2] & 255) << 16) | ((p[3] & 255) << 24);
}

fn jj_cap_rd64(p: *i8) -> i64 {
  var value: i64 = 0;
  var i: i64 = 0;
  while i < 8 { value = value | ((p[i] & 255) << (i * 8)); i = i + 1; }
  return value;
}

fn jj_path_component_char(c: i64) -> i64 {
  if c >= 48 { if c <= 57 { return 1; } }
  if c >= 65 { if c <= 90 { return 1; } }
  if c >= 97 { if c <= 122 { return 1; } }
  if c == 95 { return 1; }
  if c == 45 { return 1; }
  if c == 46 { return 1; }
  return 0;
}

fn jj_path_component_valid(component: *i8, length: i64) -> i64 {
  if component == 0 { return 0; }
  if length <= 0 { return 0; }
  if length > 255 { return 0; }
  if length == 1 { if component[0] == 46 { return 0; } }
  if length == 2 { if component[0] == 46 { if component[1] == 46 { return 0; } } }
  var i: i64 = 0;
  while i < length {
    if jj_path_component_char(component[i]) == 0 { return 0; }
    i = i + 1;
  }
  return 1;
}

fn jj_checked_open_dir(parent: i64, component: *i8) -> i64 {
  var st: *i8 = jj_raw_stat_storage() as *i8;
  if st == 0 { return 0xffffffffffffffff; }
  if jj_raw_fstatat_nofollow(parent, component, st) != 0 { return 0xffffffffffffffff; }
  if (jj_cap_rd32(st + 24) & 61440) != 16384 { return 0xffffffffffffffff; }
  var dev: i64 = jj_cap_rd64(st + 0);
  var ino: i64 = jj_cap_rd64(st + 8);
  var next: i64 = jj_raw_openat_dir(parent, component);
  if jj_sys_is_error(next) != 0 { return next; }
  if jj_raw_fstat(next, st) != 0 { jj_raw_close(next); return 0xffffffffffffffff; }
  if (jj_cap_rd32(st + 24) & 61440) != 16384 { jj_raw_close(next); return 0xffffffffffffffff; }
  if jj_cap_rd64(st + 0) != dev { jj_raw_close(next); return 0xffffffffffffffff; }
  if jj_cap_rd64(st + 8) != ino { jj_raw_close(next); return 0xffffffffffffffff; }
  return next;
}

fn jj_checked_open_regular(parent: i64, component: *i8) -> i64 {
  var st: *i8 = jj_raw_stat_storage() as *i8;
  if st == 0 { return 0xffffffffffffffff; }
  if jj_raw_fstatat_nofollow(parent, component, st) != 0 { return 0xffffffffffffffff; }
  if (jj_cap_rd32(st + 24) & 61440) != 32768 { return 0xffffffffffffffff; }
  var dev: i64 = jj_cap_rd64(st + 0);
  var ino: i64 = jj_cap_rd64(st + 8);
  var result: i64 = jj_raw_openat_ro(parent, component);
  if jj_sys_is_error(result) != 0 { return result; }
  if jj_raw_fstat(result, st) != 0 { jj_raw_close(result); return 0xffffffffffffffff; }
  if (jj_cap_rd32(st + 24) & 61440) != 32768 { jj_raw_close(result); return 0xffffffffffffffff; }
  if jj_cap_rd64(st + 0) != dev { jj_raw_close(result); return 0xffffffffffffffff; }
  if jj_cap_rd64(st + 8) != ino { jj_raw_close(result); return 0xffffffffffffffff; }
  return result;
}

fn jj_rooted_open_read(path: *i8, scratch: *i8) -> i64 {
  if path == 0 { return 0xffffffffffffffff; }
  if scratch == 0 { return 0xffffffffffffffff; }
  if path[0] == 0 { return 0xffffffffffffffff; }
  if path[0] == 47 { return 0xffffffffffffffff; }
  var current: i64 = jj_raw_open_root();
  if jj_sys_is_error(current) != 0 { return current; }
  var position: i64 = 0;
  var total: i64 = 0;
  while path[total] != 0 { total = total + 1; if total > 4096 { jj_raw_close(current); return 0xffffffffffffffff; } }
  if total == 0 { jj_raw_close(current); return 0xffffffffffffffff; }
  if path[total - 1] == 47 { jj_raw_close(current); return 0xffffffffffffffff; }
  while position < total {
    var start: i64 = position;
    while position < total { if path[position] == 47 { break; } position = position + 1; }
    var length: i64 = position - start;
    if length > 255 { jj_raw_close(current); return 0xffffffffffffffff; }
    var i: i64 = 0;
    while i < length { scratch[i] = path[start + i]; i = i + 1; }
    scratch[length] = 0;
    if jj_path_component_valid(scratch, length) == 0 { jj_raw_close(current); return 0xffffffffffffffff; }
    if position == total {
      var result: i64 = jj_checked_open_regular(current, scratch);
      jj_raw_close(current);
      return result;
    }
    var next: i64 = jj_checked_open_dir(current, scratch);
    jj_raw_close(current);
    if jj_sys_is_error(next) != 0 { return next; }
    current = next;
    position = position + 1;
  }
  jj_raw_close(current);
  return 0xffffffffffffffff;
}

fn jj_rooted_open_dir(path: *i8, scratch: *i8) -> i64 {
  if path == 0 { return 0xffffffffffffffff; }
  if scratch == 0 { return 0xffffffffffffffff; }
  if path[0] == 0 { return 0xffffffffffffffff; }
  if path[0] == 47 { return 0xffffffffffffffff; }
  var current: i64 = jj_raw_open_root();
  if jj_sys_is_error(current) != 0 { return current; }
  var total: i64 = 0;
  while path[total] != 0 { total = total + 1; if total > 4096 { jj_raw_close(current); return 0xffffffffffffffff; } }
  if total == 0 { jj_raw_close(current); return 0xffffffffffffffff; }
  if path[total - 1] == 47 { jj_raw_close(current); return 0xffffffffffffffff; }
  var position: i64 = 0;
  while position < total {
    var start: i64 = position;
    while position < total { if path[position] == 47 { break; } position = position + 1; }
    var length: i64 = position - start;
    if length > 255 { jj_raw_close(current); return 0xffffffffffffffff; }
    var i: i64 = 0;
    while i < length { scratch[i] = path[start + i]; i = i + 1; }
    scratch[length] = 0;
    if jj_path_component_valid(scratch, length) == 0 { jj_raw_close(current); return 0xffffffffffffffff; }
    var next: i64 = jj_checked_open_dir(current, scratch);
    jj_raw_close(current);
    if jj_sys_is_error(next) != 0 { return next; }
    current = next;
    if position < total { position = position + 1; }
  }
  return current;
}

fn jj_rooted_open_parent(path: *i8, scratch: *i8, basename: *i8) -> i64 {
  if path == 0 { return 0xffffffffffffffff; }
  if scratch == 0 { return 0xffffffffffffffff; }
  if basename == 0 { return 0xffffffffffffffff; }
  if path[0] == 0 { return 0xffffffffffffffff; }
  if path[0] == 47 { return 0xffffffffffffffff; }
  var current: i64 = jj_raw_open_root();
  if jj_sys_is_error(current) != 0 { return current; }
  var total: i64 = 0;
  while path[total] != 0 { total = total + 1; if total > 4096 { jj_raw_close(current); return 0xffffffffffffffff; } }
  if total == 0 { jj_raw_close(current); return 0xffffffffffffffff; }
  if path[total - 1] == 47 { jj_raw_close(current); return 0xffffffffffffffff; }
  var position: i64 = 0;
  while position < total {
    var start: i64 = position;
    while position < total { if path[position] == 47 { break; } position = position + 1; }
    var length: i64 = position - start;
    if length > 255 { jj_raw_close(current); return 0xffffffffffffffff; }
    var i: i64 = 0;
    while i < length { scratch[i] = path[start + i]; i = i + 1; }
    scratch[length] = 0;
    if jj_path_component_valid(scratch, length) == 0 { jj_raw_close(current); return 0xffffffffffffffff; }
    if position == total {
      i = 0;
      while i <= length { basename[i] = scratch[i]; i = i + 1; }
      return current;
    }
    var next: i64 = jj_checked_open_dir(current, scratch);
    jj_raw_close(current);
    if jj_sys_is_error(next) != 0 { return next; }
    current = next;
    position = position + 1;
  }
  jj_raw_close(current);
  return 0xffffffffffffffff;
}

fn jj_temp_name_build(destination: *i8, pid: i64) -> i64 {
  if destination == 0 { return 0; }
  if pid <= 0 { return 0; }
  var prefix: [7]i64;
  prefix[0]=46;prefix[1]=111;prefix[2]=109;prefix[3]=101;prefix[4]=103;prefix[5]=97;prefix[6]=46;
  var p: i64 = 0;
  while p < 7 { destination[p] = prefix[p]; p = p + 1; }
  var digits: i64 = p;
  while pid > 0 {
    if p > 128 { return 0; }
    destination[p] = 48 + (pid % 10);
    pid = pid / 10;
    p = p + 1;
  }
  var left: i64 = digits;
  var right: i64 = p - 1;
  while left < right {
    var swap: i64 = destination[left]; destination[left] = destination[right]; destination[right] = swap;
    left = left + 1; right = right - 1;
  }
  destination[p]=46;destination[p+1]=116;destination[p+2]=109;destination[p+3]=112;destination[p+4]=46;destination[p+5]=48;destination[p+6]=48;destination[p+7]=0;
  return p + 7;
}
