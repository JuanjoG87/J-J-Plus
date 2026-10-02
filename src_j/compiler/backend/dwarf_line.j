// AST/object model minimal DWARF v4 producer for source-to-machine mapping.
extern fn jj_sink_emit8(p0: *i8, p1: i64, p2: *i64, p3: i64) -> i64;
extern fn jj_sink_emit16(p0: *i8, p1: i64, p2: *i64, p3: i64) -> i64;
extern fn jj_sink_emit32(p0: *i8, p1: i64, p2: *i64, p3: i64) -> i64;
extern fn jj_sink_emit64(p0: *i8, p1: i64, p2: *i64, p3: i64) -> i64;
extern fn jj_sink_write32_at(p0: *i8, p1: i64, p2: i64, p3: i64) -> i64;
extern fn jj_ast16_span_start(p0: *i64, p1: i64) -> i64;
extern fn jj_ast16_map_word(p0: *i64, p1: i64, p2: i64) -> i64;

fn jj_debug_copy_default_name(out: *i8, capacity: i64) -> i64 {
  if capacity < 9 { return 0; }
  out[0]=109;out[1]=111;out[2]=100;out[3]=117;out[4]=108;out[5]=101;out[6]=46;out[7]=106;out[8]=0;
  return 8;
}

fn jj_debug_source_name(source: *i8, length: i64, out: *i8, capacity: i64) -> i64 {
  if source == 0 { return 0; }
  if out == 0 { return 0; }
  if capacity <= 1 { return 0; }
  var prefix: [12]i64;
  prefix[0]=47;prefix[1]=47;prefix[2]=32;prefix[3]=106;prefix[4]=106;prefix[5]=95;prefix[6]=102;prefix[7]=105;prefix[8]=108;prefix[9]=101;prefix[10]=58;prefix[11]=32;
  if length < 13 { return jj_debug_copy_default_name(out,capacity); }
  var i: i64 = 0;
  while i < 12 { if source[i] != prefix[i] { return jj_debug_copy_default_name(out,capacity); } i = i + 1; }
  var p: i64 = 12;
  var n: i64 = 0;
  while p < length {
    var c: i64 = source[p];
    if c == 10 { break; }
    if c == 13 { break; }
    if c < 32 { return 0; }
    if c >= 127 { return 0; }
    if n + 1 >= capacity { return 0; }
    out[n] = c;
    n = n + 1;
    p = p + 1;
  }
  if n == 0 { return 0; }
  out[n] = 0;
  return n;
}

fn jj_debug_line_at(source: *i8, length: i64, offset: i64) -> i64 {
  if source == 0 { return 0; }
  if offset < 0 { return 0; }
  if offset > length { return 0; }
  var line: i64 = 1;
  var i: i64 = 0;
  while i < offset { if source[i] == 10 { line = line + 1; } i = i + 1; }
  return line;
}

fn jj_dwarf_emit_uleb(out: *i8, capacity: i64, cursor: *i64, value: i64) -> i64 {
  if value < 0 { return 0; }
  var v: i64 = value;
  while 1 {
    var byte: i64 = v & 0x7f;
    v = v >>> 7;
    if v != 0 { byte = byte | 0x80; }
    if jj_sink_emit8(out,capacity,cursor,byte)==0{return 0;}
    if v == 0 { return 1; }
  }
  return 0;
}

fn jj_dwarf_emit_sleb(out: *i8, capacity: i64, cursor: *i64, value: i64) -> i64 {
  var v: i64 = value;
  while 1 {
    var byte: i64 = v & 0x7f;
    var sign: i64 = byte & 0x40;
    v = v >> 7;
    var done: i64 = 0;
    if v == 0 { if sign == 0 { done = 1; } }
    if v == -1 { if sign != 0 { done = 1; } }
    if done == 0 { byte = byte | 0x80; }
    if jj_sink_emit8(out,capacity,cursor,byte)==0{return 0;}
    if done != 0 { return 1; }
  }
  return 0;
}

fn jj_dwarf_emit_abbrev(out: *i8, capacity: i64) -> i64 {
  var cursor: [1]i64; cursor[0]=0;
  // abbrev 1: compile_unit, no children.
  if jj_dwarf_emit_uleb(out,capacity,cursor,1)==0{return 0;}
  if jj_dwarf_emit_uleb(out,capacity,cursor,0x11)==0{return 0;}
  if jj_sink_emit8(out,capacity,cursor,0)==0{return 0;}
  // stmt_list/sec_offset, low_pc/addr, high_pc/data8, name/string,
  // comp_dir/string, language/data2.
  var attrs: [12]i64;
  attrs[0]=0x10;attrs[1]=0x17;attrs[2]=0x11;attrs[3]=1;attrs[4]=0x12;attrs[5]=7;
  attrs[6]=3;attrs[7]=8;attrs[8]=0x1b;attrs[9]=8;attrs[10]=0x13;attrs[11]=5;
  var i:i64=0;while i<12{if jj_dwarf_emit_uleb(out,capacity,cursor,attrs[i])==0{return 0;}i=i+1;}
  if jj_sink_emit8(out,capacity,cursor,0)==0{return 0;}
  if jj_sink_emit8(out,capacity,cursor,0)==0{return 0;}
  if jj_sink_emit8(out,capacity,cursor,0)==0{return 0;}
  return cursor[0];
}

fn jj_dwarf_emit_info(source: *i8, length: i64, text_size: i64, out: *i8, capacity: i64) -> i64 {
  if text_size < 0 { return 0; }
  var name: [32]i64;
  var name_length:i64=jj_debug_source_name(source,length,name as *i8,240);if name_length<=0{return 0;}
  var cursor:[1]i64;cursor[0]=0;
  if jj_sink_emit32(out,capacity,cursor,0)==0{return 0;}
  if jj_sink_emit16(out,capacity,cursor,4)==0{return 0;}
  if jj_sink_emit32(out,capacity,cursor,0)==0{return 0;}
  if jj_sink_emit8(out,capacity,cursor,8)==0{return 0;}
  if jj_dwarf_emit_uleb(out,capacity,cursor,1)==0{return 0;}
  if jj_sink_emit32(out,capacity,cursor,0)==0{return 0;}
  if jj_sink_emit64(out,capacity,cursor,0)==0{return 0;}
  if jj_sink_emit64(out,capacity,cursor,text_size)==0{return 0;}
  var i:i64=0;while i<name_length{if jj_sink_emit8(out,capacity,cursor,(name as *i8)[i])==0{return 0;}i=i+1;}
  if jj_sink_emit8(out,capacity,cursor,0)==0{return 0;}
  if jj_sink_emit8(out,capacity,cursor,46)==0{return 0;}
  if jj_sink_emit8(out,capacity,cursor,0)==0{return 0;}
  // DW_LANG_lo_user: J/J+ private language code.
  if jj_sink_emit16(out,capacity,cursor,0x8000)==0{return 0;}
  if jj_sink_write32_at(out,capacity,0,cursor[0]-4)==0{return 0;}
  return cursor[0];
}

fn jj_dwarf_emit_line(source:*i8,length:i64,context:*i64,out:*i8,capacity:i64)->i64{
  if source==0{return 0;}if context==0{return 0;}if out==0{return 0;}
  var offsets:*i64=context[0] as *i64;var spans:*i64=context[1] as *i64;var map_workspace:*i64=context[2] as *i64;
  var map_count:i64=context[3];var text_size:i64=context[4];
  if offsets==0{return 0;}if spans==0{return 0;}if map_workspace==0{return 0;}
  if map_count<=0{return 0;}if map_count>map_workspace[29]{return 0;}if context[5]<=0{return 0;}if context[5]>map_workspace[28]{return 0;}if text_size<0{return 0;}
  var name:[32]i64;var name_length:i64=jj_debug_source_name(source,length,name as *i8,240);if name_length<=0{return 0;}
  var cursor:[1]i64;cursor[0]=0;
  if jj_sink_emit32(out,capacity,cursor,0)==0{return 0;}
  if jj_sink_emit16(out,capacity,cursor,4)==0{return 0;}
  var header_length_at:i64=cursor[0];if jj_sink_emit32(out,capacity,cursor,0)==0{return 0;}
  var header_start:i64=cursor[0];
  if jj_sink_emit8(out,capacity,cursor,1)==0{return 0;}
  if jj_sink_emit8(out,capacity,cursor,1)==0{return 0;}
  if jj_sink_emit8(out,capacity,cursor,1)==0{return 0;}
  if jj_sink_emit8(out,capacity,cursor,251)==0{return 0;}
  if jj_sink_emit8(out,capacity,cursor,14)==0{return 0;}
  if jj_sink_emit8(out,capacity,cursor,13)==0{return 0;}
  var lengths:[12]i64;lengths[0]=0;lengths[1]=1;lengths[2]=1;lengths[3]=1;lengths[4]=1;lengths[5]=0;lengths[6]=0;lengths[7]=0;lengths[8]=1;lengths[9]=0;lengths[10]=0;lengths[11]=1;
  var i:i64=0;while i<12{if jj_sink_emit8(out,capacity,cursor,lengths[i])==0{return 0;}i=i+1;}
  if jj_sink_emit8(out,capacity,cursor,0)==0{return 0;}
  i=0;while i<name_length{if jj_sink_emit8(out,capacity,cursor,(name as *i8)[i])==0{return 0;}i=i+1;}
  if jj_sink_emit8(out,capacity,cursor,0)==0{return 0;}
  if jj_dwarf_emit_uleb(out,capacity,cursor,0)==0{return 0;}
  if jj_dwarf_emit_uleb(out,capacity,cursor,0)==0{return 0;}
  if jj_dwarf_emit_uleb(out,capacity,cursor,0)==0{return 0;}
  if jj_sink_emit8(out,capacity,cursor,0)==0{return 0;}
  var program_start:i64=cursor[0];
  if jj_sink_emit8(out,capacity,cursor,0)==0{return 0;}
  if jj_dwarf_emit_uleb(out,capacity,cursor,9)==0{return 0;}
  if jj_sink_emit8(out,capacity,cursor,2)==0{return 0;}
  if jj_sink_emit64(out,capacity,cursor,0)==0{return 0;}
  var previous_address:i64=0;var previous_line:i64=1;i=0;
  while i<map_count{
    var map1:i64=jj_ast16_map_word(map_workspace,i,1);var node_id:i64=map1&0xffffffff;var address:i64=(map1>>>32)&0xffffffff;
    if node_id>=context[5]{return 0;}if address<previous_address{return 0;}
    var span_word:i64=spans[node_id];var source_offset:i64=span_word&0xffffffff;
    var line:i64=jj_debug_line_at(source,length,source_offset);if line<=0{return 0;}
    if address>previous_address{if jj_sink_emit8(out,capacity,cursor,2)==0{return 0;}if jj_dwarf_emit_uleb(out,capacity,cursor,address-previous_address)==0{return 0;}}
    if line!=previous_line{if jj_sink_emit8(out,capacity,cursor,3)==0{return 0;}if jj_dwarf_emit_sleb(out,capacity,cursor,line-previous_line)==0{return 0;}}
    if jj_sink_emit8(out,capacity,cursor,1)==0{return 0;}
    previous_address=address;previous_line=line;i=i+1;
  }
  if text_size<previous_address{return 0;}
  if text_size>previous_address{if jj_sink_emit8(out,capacity,cursor,2)==0{return 0;}if jj_dwarf_emit_uleb(out,capacity,cursor,text_size-previous_address)==0{return 0;}}
  if jj_sink_emit8(out,capacity,cursor,0)==0{return 0;}
  if jj_dwarf_emit_uleb(out,capacity,cursor,1)==0{return 0;}
  if jj_sink_emit8(out,capacity,cursor,1)==0{return 0;}
  if jj_sink_write32_at(out,capacity,header_length_at,program_start-header_start)==0{return 0;}
  if jj_sink_write32_at(out,capacity,0,cursor[0]-4)==0{return 0;}
  return cursor[0];
}
