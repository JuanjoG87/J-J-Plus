// canonical interface_EXTERN_PROTOTYPES_BEGIN
extern fn jj_fs_read_cap(p0: *i64, p1: *i64, p2: *i8, p3: *i8, p4: i64) -> i64;
extern fn jj_fs_stream_abort(p0: *i64, p1: *i64) -> i64;
extern fn jj_fs_stream_finish(p0: *i64, p1: *i64) -> i64;
extern fn jj_fs_stream_next_line(p0: *i64, p1: *i64, p2: *i8, p3: i64) -> i64;
extern fn jj_fs_stream_open(p0: *i64, p1: *i8, p2: *i64, p3: *i8, p4: i64) -> i64;
extern fn jj_raw_bundle_buffer() -> i64;
extern fn jj_raw_final_output_buffer() -> i64;
extern fn jj_raw_fs_cap_storage() -> i64;
extern fn jj_raw_memory_cap_storage() -> i64;
extern fn jj_raw_object_buffer() -> i64;
extern fn jj_raw_source_buffer() -> i64;
extern fn jj_resident_compile(p0:*i8,p1:*i8,p2:*i8,p3:*i8,p4:*i8,p5:*i8)->i64;
extern fn jj_compile_failure_emit(p0:*i8,p1:i64,p2:*i8)->i64;
extern fn jj_resident_link(p0: *i8, p1: *i8, p2: *i8, p3: *i8) -> i64;
extern fn jj_sha256_digest(p0: *i8, p1: i64, p2: *i8) -> i64;
extern fn jj_sha256_match(p0: *i8, p1: i64, p2: *i8) -> i64;
// canonical interface_EXTERN_PROTOTYPES_END
fn jj_pb_wr64(p: *i8, value: i64) -> i64 {
  var i: i64 = 0;
  while i < 8 { p[i] = value >>> (i * 8); i = i + 1; }
  return 1;
}

fn jj_pb_align8(value: i64) -> i64 {
  if value < 0 { return 0; }
  if value > 0x7ffffffffffffff8 { return 0; }
  return (value + 7) & 0xfffffffffffffff8;
}

fn jj_pb_copy(destination: *i8, source: *i8, count: i64) -> i64 {
  if destination == 0 { return 0; }
  if source == 0 { return 0; }
  if count < 0 { return 0; }
  var i: i64 = 0;
  while i < count { destination[i] = source[i]; i = i + 1; }
  return 1;
}

fn jj_pb_manifest_version(source: *i8, length: i64) -> i64 {
  if source == 0 { return 0; }
  if length < 9 { return 0; }
  if source[0] != 74 { return 0; }
  if source[1] != 74 { return 0; }
  if source[2] != 66 { return 0; }
  if source[3] != 85 { return 0; }
  if source[4] != 73 { return 0; }
  if source[5] != 76 { return 0; }
  if source[6] != 68 { return 0; }
  if source[8] != 10 { return 0; }
  if source[7] == 50 { return 2; }
  if source[7] == 51 { return 3; }
  return 0;
}

fn jj_b_manifest(source: *i8, length: i64) -> i64 {
  if jj_pb_manifest_version(source, length) == 0 { return 0; }
  return 1;
}

fn jj_pb_manifest_line_version(source: *i8, length: i64) -> i64 {
  if source == 0 { return 0; }
  if length != 8 { return 0; }
  if source[0] != 74 { return 0; }
  if source[1] != 74 { return 0; }
  if source[2] != 66 { return 0; }
  if source[3] != 85 { return 0; }
  if source[4] != 73 { return 0; }
  if source[5] != 76 { return 0; }
  if source[6] != 68 { return 0; }
  if source[7] == 50 { return 2; }
  if source[7] == 51 { return 3; }
  return 0;
}

fn jj_pb_hex64(source: *i8) -> i64 {
  if source == 0 { return 0; }
  var i: i64 = 0;
  while i < 64 {
    var c: i64 = source[i];
    var valid: i64 = 0;
    if c >= 48 { if c <= 57 { valid = 1; } }
    if c >= 97 { if c <= 102 { valid = 1; } }
    if valid == 0 { return 0; }
    i = i + 1;
  }
  return 1;
}

fn jj_pb_path_char(c: i64) -> i64 {
  if c >= 48 { if c <= 57 { return 1; } }
  if c >= 65 { if c <= 90 { return 1; } }
  if c >= 97 { if c <= 122 { return 1; } }
  if c == 95 { return 1; }
  if c == 45 { return 1; }
  if c == 46 { return 1; }
  if c == 47 { return 1; }
  return 0;
}

fn jj_pb_path_valid(path: *i8, length: i64) -> i64 {
  if path == 0 { return 0; }
  if length < 3 { return 0; }
  if length > 4096 { return 0; }
  if path[0] == 47 { return 0; }
  if path[length - 1] == 47 { return 0; }
  if path[length - 2] != 46 { return 0; }
  if path[length - 1] != 106 { return 0; }
  var segment: i64 = 0;
  var i: i64 = 0;
  while i < length {
    var c: i64 = path[i];
    if c == 0 { return 0; }
    if jj_pb_path_char(c) == 0 { return 0; }
    if c == 47 {
      var n: i64 = i - segment;
      if n <= 0 { return 0; }
      if n == 1 { if path[segment] == 46 { return 0; } }
      if n == 2 { if path[segment] == 46 { if path[segment + 1] == 46 { return 0; } } }
      segment = i + 1;
    }
    i = i + 1;
  }
  var tail: i64 = length - segment;
  if tail <= 0 { return 0; }
  if tail == 1 { if path[segment] == 46 { return 0; } }
  if tail == 2 { if path[segment] == 46 { if path[segment + 1] == 46 { return 0; } } }
  return 1;
}

fn jj_pb_prefix_valid(path: *i8, length: i64) -> i64 {
  if path == 0 { return 0; }
  if length < 2 { return 0; }
  if length > 512 { return 0; }
  if path[0] == 47 { return 0; }
  if path[length - 1] != 47 { return 0; }
  var segment: i64 = 0;
  var i: i64 = 0;
  while i < length {
    var c: i64 = path[i];
    if c == 0 { return 0; }
    if jj_pb_path_char(c) == 0 { return 0; }
    if c == 47 {
      var n: i64 = i - segment;
      if n <= 0 { return 0; }
      if n == 1 { if path[segment] == 46 { return 0; } }
      if n == 2 { if path[segment] == 46 { if path[segment + 1] == 46 { return 0; } } }
      segment = i + 1;
    }
    i = i + 1;
  }
  if segment != length { return 0; }
  return 1;
}

fn jj_pb_digest_seen(table: *i8, count: i64, digest: *i8) -> i64 {
  if table == 0 { return 1; }
  if digest == 0 { return 1; }
  if count < 0 { return 1; }
  var entry: i64 = 0;
  while entry < count {
    var equal: i64 = 1;
    var i: i64 = 0;
    while i < 32 {
      if table[entry * 32 + i] != digest[i] { equal = 0; }
      i = i + 1;
    }
    if equal != 0 { return 1; }
    entry = entry + 1;
  }
  return 0;
}

fn jj_pb_stream_fail(fs: *i64, stream: *i64) -> i64 {
  jj_fs_stream_abort(fs, stream);
  return 0;
}

// R757 manifest diagnostics are computed while the manifest line is resident.
// detail: offset[19:0], token_length[31:20], line[47:32], column[63:48].
fn jj_pb_manifest_detail(offset:i64,token_length:i64,line_column:i64)->i64{if offset<0{offset=0;}if offset>0xfffff{offset=0xfffff;}if token_length<0{token_length=0;}if token_length>4095{token_length=4095;}var line:i64=line_column&65535;var column:i64=(line_column>>>16)&65535;if line<1{line=1;}if column<1{column=1;}return (offset&0xfffff)|((token_length&4095)<<20)|((line&65535)<<32)|((column&65535)<<48);}
fn jj_pb_manifest_fail(object:*i8,reason:i64,detail:i64)->i64{if object==0{return 0;}var report:*i64=(object+2097152-64) as *i64;report[0]=0x4a4a444941473032;report[1]=reason-5000;report[2]=reason;report[3]=(detail>>>32)&65535;report[4]=(detail>>>48)&65535;report[5]=(detail>>>20)&4095;report[6]=detail&0xfffff;report[7]=(report as i64)^report[0]^report[1]^report[2]^report[3]^report[4]^report[5]^report[6]^0x4a4a444941475332;return 2;}
fn jj_pb_manifest_abort(fs:*i64,stream:*i64)->i64{jj_fs_stream_abort(fs,stream);return 1;}
fn jj_pb_hex64_bad(source:*i8)->i64{if source==0{return 0;}var i:i64=0;while i<64{var c:i64=source[i];var valid:i64=0;if c>=48{if c<=57{valid=1;}}if c>=97{if c<=102{valid=1;}}if valid==0{return i+1;}i=i+1;}return 0;}

fn jj_selfhost_build_manifest(fs: *i64, memory: *i64) -> i64 {
  if fs == 0 { return 0; }
  if memory == 0 { return 0; }
  if fs != (jj_raw_fs_cap_storage() as *i64) { return 0; }
  if memory != (jj_raw_memory_cap_storage() as *i64) { return 0; }
  if memory[0] != 0x4a4a4d454d434134 { return 0; }
  if memory[2] != (jj_raw_source_buffer() as i64) { return 0; }
  if memory[3] != 1048576 { return 0; }
  if memory[5] != (jj_raw_object_buffer() as i64) { return 0; }
  if memory[6] != 2097152 { return 0; }
  if memory[16] != (jj_raw_bundle_buffer() as i64) { return 0; }
  if memory[17] != 8388608 { return 0; }
  var manifest_length: i64 = memory[4];
  if manifest_length < 9 { return 0; }
  if manifest_length > memory[3] { return 0; }
  var source: *i8 = memory[2] as *i8;
  var object: *i8 = memory[5] as *i8;
  var final_output: *i8 = jj_raw_final_output_buffer() as *i8;
  if final_output == 0 { return 0; }
  var arena: *i8 = memory[16] as *i8;
  var initial_version: i64 = jj_pb_manifest_version(source, manifest_length);
  if initial_version == 0 { return 0; }
  var max_entries: i64 = (manifest_length / 69) + 2;
  if max_entries <= 0 { return 0; }
  if max_entries > (memory[17] - 16) / 32 { return 0; }
  var table_bytes: i64 = jj_pb_align8(max_entries * 32);
  if table_bytes <= 0 { return 0; }
  if table_bytes > memory[17] - 16 { return 0; }
  var path_hashes: *i8 = arena;
  var bundle: *i8 = arena + table_bytes;
  var bundle_capacity: i64 = memory[17] - table_bytes;
  bundle[0]=74;bundle[1]=74;bundle[2]=66;bundle[3]=49;bundle[4]=79;bundle[5]=66;bundle[6]=74;bundle[7]=10;
  jj_pb_wr64(bundle + 8, 0);
  var stream: [24]i64;
  var chunk: [512]i64;
  var line_words: [528]i64;
  var path_words: [513]i64;
  var prefix_words: [65]i64;
  var digest_words: [4]i64;
  var line: *i8 = line_words as *i8;
  var path: *i8 = path_words as *i8;
  var prefix: *i8 = prefix_words as *i8;
  var digest: *i8 = digest_words as *i8;
  if jj_fs_stream_open(fs, memory[8] as *i8, stream as *i64, chunk as *i8, 4096) == 0 { return jj_pb_manifest_fail(object,6311,jj_pb_manifest_detail(0,1,1|(1<<16))); }
  var manifest_offset:i64=0;var manifest_line:i64=1;
  var first_result: i64 = jj_fs_stream_next_line(fs, stream as *i64, line, 4224);
  if first_result <= 0 { jj_pb_manifest_abort(fs,stream as *i64);return jj_pb_manifest_fail(object,6301,jj_pb_manifest_detail(0,8,1|(1<<16))); }
  var manifest_version: i64 = jj_pb_manifest_line_version(line, first_result - 1);
  if manifest_version == 0 { jj_pb_manifest_abort(fs,stream as *i64);return jj_pb_manifest_fail(object,6301,jj_pb_manifest_detail(0,first_result-1,1|(1<<16))); }
  if manifest_version != initial_version { jj_pb_manifest_abort(fs,stream as *i64);return jj_pb_manifest_fail(object,6301,jj_pb_manifest_detail(7,1,1|(8<<16))); }
  manifest_offset=manifest_offset+first_result;manifest_line=2;
  var prefix_length: i64 = 0;
  if manifest_version == 3 {
    var prefix_start:i64=manifest_offset;var prefix_result: i64 = jj_fs_stream_next_line(fs, stream as *i64, line, 4224);
    if prefix_result <= 0 { jj_pb_manifest_abort(fs,stream as *i64);return jj_pb_manifest_fail(object,6302,jj_pb_manifest_detail(prefix_start,1,manifest_line|(1<<16))); }
    var prefix_line_length: i64 = prefix_result - 1;
    if prefix_line_length < 3 { jj_pb_manifest_abort(fs,stream as *i64);return jj_pb_manifest_fail(object,6302,jj_pb_manifest_detail(prefix_start,prefix_line_length,manifest_line|(1<<16))); }
    if line[0] != 80 { jj_pb_manifest_abort(fs,stream as *i64);return jj_pb_manifest_fail(object,6302,jj_pb_manifest_detail(prefix_start,1,manifest_line|(1<<16))); }
    if line[1] != 32 { jj_pb_manifest_abort(fs,stream as *i64);return jj_pb_manifest_fail(object,6302,jj_pb_manifest_detail(prefix_start+1,1,manifest_line|(2<<16))); }
    prefix_length = prefix_line_length - 2;
    if jj_pb_prefix_valid(line + 2, prefix_length) == 0 { jj_pb_manifest_abort(fs,stream as *i64);return jj_pb_manifest_fail(object,6302,jj_pb_manifest_detail(prefix_start+2,prefix_length,manifest_line|(3<<16))); }
    if jj_pb_copy(prefix, line + 2, prefix_length) == 0 { jj_pb_manifest_abort(fs,stream as *i64);return jj_pb_manifest_fail(object,6311,jj_pb_manifest_detail(prefix_start+2,prefix_length,manifest_line|(3<<16))); }
    manifest_offset=manifest_offset+prefix_result;manifest_line=manifest_line+1;
  }
  var position: i64 = 16;
  var count: i64 = 0;
  while 1 {
    var line_start:i64=manifest_offset;var line_number:i64=manifest_line;var line_result: i64 = jj_fs_stream_next_line(fs, stream as *i64, line, 4224);
    if line_result < 0 { jj_pb_manifest_abort(fs,stream as *i64);return jj_pb_manifest_fail(object,6311,jj_pb_manifest_detail(line_start,1,line_number|(1<<16))); }
    if line_result == 0 { break; }
    manifest_offset=manifest_offset+line_result;manifest_line=manifest_line+1;
    var line_length: i64 = line_result - 1;
    if line_length == 0 { }
    else {
      if line_length < 69 { jj_pb_manifest_abort(fs,stream as *i64);return jj_pb_manifest_fail(object,6303,jj_pb_manifest_detail(line_start,line_length,line_number|(1<<16))); }
      if count >= max_entries { jj_pb_manifest_abort(fs,stream as *i64);return jj_pb_manifest_fail(object,6310,jj_pb_manifest_detail(line_start,line_length,line_number|(1<<16))); }
      var bad_hex:i64=jj_pb_hex64_bad(line);if bad_hex!=0 { jj_pb_manifest_abort(fs,stream as *i64);return jj_pb_manifest_fail(object,6304,jj_pb_manifest_detail(line_start+bad_hex-1,1,line_number|(bad_hex<<16))); }
      if line[64] != 32 { jj_pb_manifest_abort(fs,stream as *i64);return jj_pb_manifest_fail(object,6305,jj_pb_manifest_detail(line_start+64,1,line_number|(65<<16))); }
      if line[65] != 32 { jj_pb_manifest_abort(fs,stream as *i64);return jj_pb_manifest_fail(object,6305,jj_pb_manifest_detail(line_start+65,1,line_number|(66<<16))); }
      var path_length: i64 = line_length - 66;
      if jj_pb_path_valid(line + 66, path_length) == 0 { jj_pb_manifest_abort(fs,stream as *i64);return jj_pb_manifest_fail(object,6306,jj_pb_manifest_detail(line_start+66,path_length,line_number|(67<<16))); }
      if prefix_length > 4096 - path_length { jj_pb_manifest_abort(fs,stream as *i64);return jj_pb_manifest_fail(object,6306,jj_pb_manifest_detail(line_start+66,path_length,line_number|(67<<16))); }
      if jj_sha256_digest(line + 66, path_length, digest) == 0 { jj_pb_manifest_abort(fs,stream as *i64);return jj_pb_manifest_fail(object,6306,jj_pb_manifest_detail(line_start+66,path_length,line_number|(67<<16))); }
      if jj_pb_digest_seen(path_hashes, count, digest) != 0 { jj_pb_manifest_abort(fs,stream as *i64);return jj_pb_manifest_fail(object,6307,jj_pb_manifest_detail(line_start+66,path_length,line_number|(67<<16))); }
      if jj_pb_copy(path_hashes + count * 32, digest, 32) == 0 { jj_pb_manifest_abort(fs,stream as *i64);return jj_pb_manifest_fail(object,6311,jj_pb_manifest_detail(line_start+66,path_length,line_number|(67<<16))); }
      var pi: i64 = 0;
      while pi < prefix_length { path[pi] = prefix[pi]; pi = pi + 1; }
      var pj: i64 = 0;
      while pj < path_length { path[prefix_length + pj] = line[66 + pj]; pj = pj + 1; }
      path[prefix_length + path_length] = 0;
      memory[4] = 0;
      var read_status: i64 = jj_fs_read_cap(fs, memory, path, source, memory[3]);
      if read_status != 0 { jj_pb_manifest_abort(fs,stream as *i64);return jj_pb_manifest_fail(object,6308,jj_pb_manifest_detail(line_start+66,path_length,line_number|(67<<16))); }
      if jj_sha256_match(source, memory[4], line) == 0 { jj_pb_manifest_abort(fs,stream as *i64);return jj_pb_manifest_fail(object,6309,jj_pb_manifest_detail(line_start,64,line_number|(1<<16))); }
      var object_length: i64 = jj_resident_compile(source,source+memory[4],source+memory[4],source+memory[3],object,object+memory[6]);
      if object_length <= 0 { jj_pb_manifest_abort(fs,stream as *i64);return jj_pb_manifest_fail(object,6311,jj_pb_manifest_detail(line_start+66,path_length,line_number|(67<<16))); }
      if object_length == 2 { jj_compile_failure_emit(path,113,object); return jj_pb_stream_fail(fs, stream as *i64); }
      if position > bundle_capacity - 8 { jj_pb_manifest_abort(fs,stream as *i64);return jj_pb_manifest_fail(object,6310,jj_pb_manifest_detail(line_start,line_length,line_number|(1<<16))); }
      jj_pb_wr64(bundle + position, object_length);
      position = position + 8;
      if object_length > bundle_capacity - position { jj_pb_manifest_abort(fs,stream as *i64);return jj_pb_manifest_fail(object,6310,jj_pb_manifest_detail(line_start,line_length,line_number|(1<<16))); }
      if jj_pb_copy(bundle + position, object, object_length) == 0 { jj_pb_manifest_abort(fs,stream as *i64);return jj_pb_manifest_fail(object,6311,jj_pb_manifest_detail(line_start,line_length,line_number|(1<<16))); }
      position = position + object_length;
      var aligned: i64 = jj_pb_align8(position);
      if aligned == 0 { jj_pb_manifest_abort(fs,stream as *i64);return jj_pb_manifest_fail(object,6310,jj_pb_manifest_detail(line_start,line_length,line_number|(1<<16))); }
      if aligned > bundle_capacity { jj_pb_manifest_abort(fs,stream as *i64);return jj_pb_manifest_fail(object,6310,jj_pb_manifest_detail(line_start,line_length,line_number|(1<<16))); }
      while position < aligned { bundle[position] = 0; position = position + 1; }
      count = count + 1;
    }
  }
  if count == 0 { jj_pb_manifest_abort(fs,stream as *i64);return jj_pb_manifest_fail(object,6312,jj_pb_manifest_detail(manifest_offset,0,manifest_line|(1<<16))); }
  if jj_fs_stream_finish(fs, stream as *i64) == 0 { return jj_pb_manifest_fail(object,6311,jj_pb_manifest_detail(manifest_offset,0,manifest_line|(1<<16))); }
  jj_pb_wr64(bundle + 8, count);
  var result: i64 = jj_resident_link(bundle, bundle + position, final_output, final_output + 5242880);
  if result <= 0 { return 0; }
  if result == 2 { return 0; }
  memory[4] = manifest_length;
  memory[5] = final_output as i64;
  memory[6] = 5242880;
  memory[7] = result;
  memory[18] = count;
  memory[19] = position;
  memory[21] = table_bytes;
  return result;
}
