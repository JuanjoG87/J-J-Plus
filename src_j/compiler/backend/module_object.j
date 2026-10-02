// AST/object model x86-64 ET_REL finalizer with packed AST and minimal DWARF v4.
extern fn jj_c_align(p0: i64, p1: i64) -> i64;
extern fn jj_c_copy(p0: *i8, p1: *i8, p2: i64) -> i64;
extern fn jj_c_wr16(p0: *i8, p1: i64) -> i64;
extern fn jj_c_wr32(p0: *i8, p1: i64) -> i64;
extern fn jj_c_wr64(p0: *i8, p1: i64) -> i64;
extern fn jj_ast16_node_count(p0: *i64) -> i64;
extern fn jj_ast16_span_count(p0: *i64) -> i64;
extern fn jj_ast16_map_count(p0: *i64) -> i64;
extern fn jj_ast16_nodes(p0: *i64) -> i64;
extern fn jj_ast16_spans(p0: *i64) -> i64;
extern fn jj_ast16_maps(p0: *i64) -> i64;
extern fn jj_ast16_node_word(p0: *i64, p1: i64, p2: i64) -> i64;
extern fn jj_ast16_map_word(p0: *i64, p1: i64, p2: i64) -> i64;
extern fn jj_dwarf_emit_line(p0: *i8, p1: i64, p2: *i64, p3: *i8, p4: i64) -> i64;
extern fn jj_dwarf_emit_abbrev(p0: *i8, p1: i64) -> i64;
extern fn jj_dwarf_emit_info(p0: *i8, p1: i64, p2: i64, p3: *i8, p4: i64) -> i64;
extern fn jj_sink_write16_at(p0: *i8, p1: i64, p2: i64, p3: i64) -> i64;
extern fn jj_sink_write32_at(p0: *i8, p1: i64, p2: i64, p3: i64) -> i64;
extern fn jj_sink_write64_at(p0: *i8, p1: i64, p2: i64, p3: i64) -> i64;
extern fn jj_objseg_init(p0:*i64,p1:*i8,p2:i64,p3:i64)->i64;
extern fn jj_objseg_valid(p0:*i64)->i64;
extern fn jj_objseg_write8(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_objseg_write16(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_objseg_write32(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_objseg_write64(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_objseg_zero(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_objseg_copy(p0:*i64,p1:i64,p2:*i8,p3:i64)->i64;
extern fn jj_objseg_commit(p0:*i64,p1:i64)->i64;
extern fn jj_core_function_field(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_core_function_signature(p0:*i64,p1:i64)->i64;
extern fn jj_core_external_field(p0:*i64,p1:i64,p2:i64)->i64;


fn jj_obj_sh64(sink:*i64,at:i64,desc:*i64)->i64{
  if sink==0{return 0;}if desc==0{return 0;}
  if jj_objseg_write32(sink,at,desc[0])==0{return 0;}if jj_objseg_write32(sink,at+4,desc[1])==0{return 0;}if jj_objseg_write64(sink,at+8,desc[2])==0{return 0;}if jj_objseg_write64(sink,at+16,desc[3])==0{return 0;}
  if jj_objseg_write64(sink,at+24,desc[4])==0{return 0;}if jj_objseg_write64(sink,at+32,desc[5])==0{return 0;}if jj_objseg_write32(sink,at+40,desc[6])==0{return 0;}if jj_objseg_write32(sink,at+44,desc[7])==0{return 0;}
  if jj_objseg_write64(sink,at+48,desc[8])==0{return 0;}if jj_objseg_write64(sink,at+56,desc[9])==0{return 0;}return 1;
}

fn jj_obj_ast_header(sink:*i64,at:i64,kind:i64,count:i64)->i64{
  if sink==0{return 0;}if at<0{return 0;}
  if jj_objseg_write8(sink,at,74)==0{return 0;}if jj_objseg_write8(sink,at+1,74)==0{return 0;}
  if kind==1{if jj_objseg_write8(sink,at+2,65)==0{return 0;}if jj_objseg_write8(sink,at+3,83)==0{return 0;}if jj_objseg_write8(sink,at+4,84)==0{return 0;}if jj_objseg_write8(sink,at+5,49)==0{return 0;}if jj_objseg_write8(sink,at+6,54)==0{return 0;}if jj_objseg_write8(sink,at+7,10)==0{return 0;}}
  else{if kind==2{if jj_objseg_write8(sink,at+2,83)==0{return 0;}if jj_objseg_write8(sink,at+3,80)==0{return 0;}if jj_objseg_write8(sink,at+4,65)==0{return 0;}if jj_objseg_write8(sink,at+5,78)==0{return 0;}if jj_objseg_write8(sink,at+6,49)==0{return 0;}if jj_objseg_write8(sink,at+7,10)==0{return 0;}}
  else{if kind==3{if jj_objseg_write8(sink,at+2,77)==0{return 0;}if jj_objseg_write8(sink,at+3,65)==0{return 0;}if jj_objseg_write8(sink,at+4,80)==0{return 0;}if jj_objseg_write8(sink,at+5,49)==0{return 0;}if jj_objseg_write8(sink,at+6,54)==0{return 0;}if jj_objseg_write8(sink,at+7,10)==0{return 0;}}else{return 0;}}}
  if kind==3{if jj_objseg_write32(sink,at+8,2)==0{return 0;}}else{if jj_objseg_write32(sink,at+8,1)==0{return 0;}}
  if kind==1{if jj_objseg_write32(sink,at+12,16)==0{return 0;}}else{if kind==2{if jj_objseg_write32(sink,at+12,8)==0{return 0;}}else{if jj_objseg_write32(sink,at+12,16)==0{return 0;}}}
  if jj_objseg_write32(sink,at+16,count)==0{return 0;}if jj_objseg_write32(sink,at+20,0)==0{return 0;}if jj_objseg_write64(sink,at+24,0)==0{return 0;}return 1;
}

fn jj_obj_write_shstr(sink:*i64,at:i64)->i64{
  var bytes:[117]i64;bytes[0]=0;
  bytes[1]=46;bytes[2]=116;bytes[3]=101;bytes[4]=120;bytes[5]=116;bytes[6]=0;
  bytes[7]=46;bytes[8]=115;bytes[9]=121;bytes[10]=109;bytes[11]=116;bytes[12]=97;bytes[13]=98;bytes[14]=0;
  bytes[15]=46;bytes[16]=115;bytes[17]=116;bytes[18]=114;bytes[19]=116;bytes[20]=97;bytes[21]=98;bytes[22]=0;
  bytes[23]=46;bytes[24]=114;bytes[25]=101;bytes[26]=108;bytes[27]=97;bytes[28]=46;bytes[29]=116;bytes[30]=101;bytes[31]=120;bytes[32]=116;bytes[33]=0;
  bytes[34]=46;bytes[35]=100;bytes[36]=101;bytes[37]=98;bytes[38]=117;bytes[39]=103;bytes[40]=95;bytes[41]=108;bytes[42]=105;bytes[43]=110;bytes[44]=101;bytes[45]=0;
  bytes[46]=46;bytes[47]=100;bytes[48]=101;bytes[49]=98;bytes[50]=117;bytes[51]=103;bytes[52]=95;bytes[53]=97;bytes[54]=98;bytes[55]=98;bytes[56]=114;bytes[57]=101;bytes[58]=118;bytes[59]=0;
  bytes[60]=46;bytes[61]=100;bytes[62]=101;bytes[63]=98;bytes[64]=117;bytes[65]=103;bytes[66]=95;bytes[67]=105;bytes[68]=110;bytes[69]=102;bytes[70]=111;bytes[71]=0;
  bytes[72]=46;bytes[73]=106;bytes[74]=106;bytes[75]=46;bytes[76]=97;bytes[77]=115;bytes[78]=116;bytes[79]=49;bytes[80]=54;bytes[81]=0;
  bytes[82]=46;bytes[83]=106;bytes[84]=106;bytes[85]=46;bytes[86]=115;bytes[87]=112;bytes[88]=97;bytes[89]=110;bytes[90]=0;
  bytes[91]=46;bytes[92]=106;bytes[93]=106;bytes[94]=46;bytes[95]=109;bytes[96]=97;bytes[97]=112;bytes[98]=0;
  bytes[99]=46;bytes[100]=106;bytes[101]=106;bytes[102]=46;bytes[103]=102;bytes[104]=103;bytes[105]=114;bytes[106]=0;
  bytes[107]=46;bytes[108]=115;bytes[109]=104;bytes[110]=115;bytes[111]=116;bytes[112]=114;bytes[113]=116;bytes[114]=97;bytes[115]=98;bytes[116]=0;
  var i:i64=0;while i<117{if jj_objseg_write8(sink,at+i,bytes[i])==0{return 0;}i=i+1;}return 117;
}


fn jj_obj_write_signature_name(source:*i8,start:i64,count:i64,signature:i64,sink:*i64,at:i64)->i64{
  if source==0{return 0;}if sink==0{return 0;}if start<0{return 0;}if count<=0{return 0;}if signature==0{return 0;}var i:i64=0;while i<count{if jj_objseg_write8(sink,at+i,source[start+i])==0{return 0;}i=i+1;}if jj_objseg_write8(sink,at+count,36)==0{return 0;}i=0;while i<16{var digit:i64=(signature>>>((15-i)*4))&15;var byte:i64=48+digit;if digit>=10{byte=87+digit;}if jj_objseg_write8(sink,at+count+1+i,byte)==0{return 0;}i=i+1;}return jj_objseg_write8(sink,at+count+17,0);
}

fn jj_obj_write_function_name(source:*i8,core:*i64,function_id:i64,sink:*i64,at:i64)->i64{
  var start:i64=jj_core_function_field(core,function_id,0);var count:i64=jj_core_function_field(core,function_id,1);var signature:i64=jj_core_function_signature(core,function_id);return jj_obj_write_signature_name(source,start,count,signature,sink,at);
}

fn jj_obj_write_external_name(source:*i8,core:*i64,external_id:i64,sink:*i64,at:i64)->i64{
  var start:i64=jj_core_external_field(core,external_id,0);var count:i64=jj_core_external_field(core,external_id,1);var signature:i64=jj_core_external_field(core,external_id,2);return jj_obj_write_signature_name(source,start,count,signature,sink,at);
}

fn jj_object_finalize(source:*i8,source_length:i64,core:*i64,object:*i8,capacity:i64,context:*i64)->i64{
  if source==0{return 0;}if core==0{return 0;}if object==0{return 0;}if context==0{return 0;}
  var code:*i8=context[0] as *i8;var text_size:i64=context[1];var offsets:*i64=context[2] as *i64;var relocation_offsets:*i64=context[3] as *i64;var relocation_ids:*i64=context[4] as *i64;var relocation_count:i64=context[5];var fgr_receipts:*i64=context[6] as *i64;var fgr_count:i64=context[7];var reo_receipts:*i64=context[8] as *i64;var code_hashes:*i64=context[9] as *i64;var reom_receipts:*i64=context[10] as *i64;var line_tmp:*i8=context[11]as *i8;var line_capacity:i64=context[12];var abbrev_tmp:*i8=context[13]as *i8;var abbrev_capacity:i64=context[14];var info_tmp:*i8=context[15]as *i8;var info_capacity:i64=context[16];var name_offsets:*i64=context[17] as *i64;
  if code==0{return 0;}if offsets==0{return 0;}if relocation_offsets==0{return 0;}if relocation_ids==0{return 0;}if fgr_receipts==0{return 0;}if reo_receipts==0{return 0;}if code_hashes==0{return 0;}if reom_receipts==0{return 0;}if line_tmp==0{return 0;}if abbrev_tmp==0{return 0;}if info_tmp==0{return 0;}if name_offsets==0{return 0;}if line_capacity<=0{return 0;}if abbrev_capacity<=0{return 0;}if info_capacity<=0{return 0;}
  var count:i64=core[10];var external_count:i64=core[20];if count<=0{return 0;}if external_count<0{return 0;}if fgr_count!=count{return 0;}
  var map_count:i64=jj_ast16_map_count(core);var node_count:i64=jj_ast16_node_count(core);var span_count:i64=jj_ast16_span_count(core);
  if map_count<count{return 0;}if map_count>core[29]{return 0;}if node_count<=0{return 0;}if node_count>core[28]{return 0;}if span_count!=node_count{return 0;}
  var spans:*i64=jj_ast16_spans(core) as *i64;if spans==0{return 0;}
  var debug_context:[6]i64;debug_context[0]=offsets as i64;debug_context[1]=spans as i64;debug_context[2]=core as i64;debug_context[3]=map_count;debug_context[4]=text_size;debug_context[5]=node_count;
  var line_size:i64=jj_dwarf_emit_line(source,source_length,debug_context,line_tmp,line_capacity);if line_size<=0{return 0;}
  var abbrev_size:i64=jj_dwarf_emit_abbrev(abbrev_tmp,abbrev_capacity);if abbrev_size<=0{return 0;}
  var info_size:i64=jj_dwarf_emit_info(source,source_length,text_size,info_tmp,info_capacity);if info_size<=0{return 0;}
  var i:i64=0;var string_size:i64=1;
  while i<count{var name_count:i64=jj_core_function_field(core,i,1);if name_count<=0{return 0;}name_offsets[i]=string_size;string_size=string_size+name_count+18;i=i+1;}
  i=0;while i<external_count{var external_name_count:i64=jj_core_external_field(core,i,1);if external_name_count<=0{return 0;}name_offsets[count+i]=string_size;string_size=string_size+external_name_count+18;i=i+1;}
  var text_offset:i64=64;var symtab_offset:i64=jj_c_align(text_offset+text_size,8);var symbol_count:i64=1+count+external_count;var symtab_size:i64=symbol_count*24;
  var strtab_offset:i64=symtab_offset+symtab_size;var rela_offset:i64=jj_c_align(strtab_offset+string_size,8);var rela_size:i64=relocation_count*24;
  var line_offset:i64=jj_c_align(rela_offset+rela_size,8);var abbrev_offset:i64=jj_c_align(line_offset+line_size,8);var info_offset:i64=jj_c_align(abbrev_offset+abbrev_size,8);
  var ast_offset:i64=jj_c_align(info_offset+info_size,8);var ast_size:i64=32+node_count*16;var span_offset:i64=jj_c_align(ast_offset+ast_size,8);var span_size:i64=32+span_count*8;
  var map_offset:i64=jj_c_align(span_offset+span_size,8);var map_size:i64=32+map_count*16;var fgr_offset:i64=jj_c_align(map_offset+map_size,8);var fgr_size:i64=32+fgr_count*32;var shstr_offset:i64=jj_c_align(fgr_offset+fgr_size,8);var shstr_size:i64=117;
  var section_offset:i64=jj_c_align(shstr_offset+shstr_size,8);var total:i64=section_offset+832;if total>capacity{return 0;}
  var sink:[40]i64;if jj_objseg_init(sink as *i64,object,capacity,131072)==0{return 0;}if jj_objseg_zero(sink as *i64,0,total)==0{return 0;}
  if jj_objseg_copy(sink as *i64,text_offset,code,text_size)==0{return 0;}
  i=0;while i<count{var se:i64=symtab_offset+(1+i)*24;if jj_objseg_write32(sink as *i64,se,name_offsets[i])==0{return 0;}if jj_objseg_write8(sink as *i64,se+4,18)==0{return 0;}if jj_objseg_write16(sink as *i64,se+6,1)==0{return 0;}if jj_objseg_write64(sink as *i64,se+8,offsets[i])==0{return 0;}var next_offset:i64=text_size;if i+1<count{next_offset=offsets[i+1];}if jj_objseg_write64(sink as *i64,se+16,next_offset-offsets[i])==0{return 0;}i=i+1;}
  i=0;while i<external_count{var xe:i64=symtab_offset+(1+count+i)*24;if jj_objseg_write32(sink as *i64,xe,name_offsets[count+i])==0{return 0;}if jj_objseg_write8(sink as *i64,xe+4,16)==0{return 0;}if jj_objseg_write16(sink as *i64,xe+6,0)==0{return 0;}i=i+1;}
  if jj_objseg_write8(sink as *i64,strtab_offset,0)==0{return 0;}i=0;while i<count{if jj_obj_write_function_name(source,core,i,sink as *i64,strtab_offset+name_offsets[i])==0{return 0;}i=i+1;}
  i=0;while i<external_count{if jj_obj_write_external_name(source,core,i,sink as *i64,strtab_offset+name_offsets[count+i])==0{return 0;}i=i+1;}
  i=0;while i<relocation_count{if relocation_ids[i]>=external_count{return 0;}var re:i64=rela_offset+i*24;if jj_objseg_write64(sink as *i64,re,relocation_offsets[i])==0{return 0;}if jj_objseg_write64(sink as *i64,re+8,((1+count+relocation_ids[i])<<32)|4)==0{return 0;}if jj_objseg_write64(sink as *i64,re+16,0-4)==0{return 0;}i=i+1;}
  if jj_objseg_copy(sink as *i64,line_offset,line_tmp,line_size)==0{return 0;}if jj_objseg_copy(sink as *i64,abbrev_offset,abbrev_tmp,abbrev_size)==0{return 0;}if jj_objseg_copy(sink as *i64,info_offset,info_tmp,info_size)==0{return 0;}
  if jj_obj_ast_header(sink as *i64,ast_offset,1,node_count)==0{return 0;}if jj_objseg_write32(sink as *i64,ast_offset+20,core[11])==0{return 0;}
  i=0;while i<node_count{if jj_objseg_write64(sink as *i64,ast_offset+32+i*16,jj_ast16_node_word(core,i,0))==0{return 0;}if jj_objseg_write64(sink as *i64,ast_offset+40+i*16,jj_ast16_node_word(core,i,1))==0{return 0;}i=i+1;}
  if jj_obj_ast_header(sink as *i64,span_offset,2,span_count)==0{return 0;}if jj_objseg_copy(sink as *i64,span_offset+32,spans as *i8,span_count*8)==0{return 0;}
  if jj_obj_ast_header(sink as *i64,map_offset,3,map_count)==0{return 0;}i=0;while i<map_count{if jj_objseg_write64(sink as *i64,map_offset+32+i*16,jj_ast16_map_word(core,i,0))==0{return 0;}if jj_objseg_write64(sink as *i64,map_offset+40+i*16,jj_ast16_map_word(core,i,1))==0{return 0;}i=i+1;}
  if jj_objseg_write8(sink as *i64,fgr_offset,74)==0{return 0;}if jj_objseg_write8(sink as *i64,fgr_offset+1,74)==0{return 0;}if jj_objseg_write8(sink as *i64,fgr_offset+2,70)==0{return 0;}if jj_objseg_write8(sink as *i64,fgr_offset+3,71)==0{return 0;}if jj_objseg_write8(sink as *i64,fgr_offset+4,82)==0{return 0;}if jj_objseg_write8(sink as *i64,fgr_offset+5,49)==0{return 0;}if jj_objseg_write8(sink as *i64,fgr_offset+6,49)==0{return 0;}if jj_objseg_write8(sink as *i64,fgr_offset+7,10)==0{return 0;}
  if jj_objseg_write32(sink as *i64,fgr_offset+8,15)==0{return 0;}if jj_objseg_write32(sink as *i64,fgr_offset+12,32)==0{return 0;}if jj_objseg_write32(sink as *i64,fgr_offset+16,fgr_count)==0{return 0;}if jj_objseg_write32(sink as *i64,fgr_offset+20,1085)==0{return 0;}
  var fgr_total:i64=0;i=0;while i<fgr_count{var fgr_packed:i64=fgr_receipts[i];var reo_packed:i64=reo_receipts[i];var reom_packed:i64=reom_receipts[i];if jj_objseg_write64(sink as *i64,fgr_offset+32+i*32,fgr_packed)==0{return 0;}if jj_objseg_write64(sink as *i64,fgr_offset+40+i*32,reo_packed)==0{return 0;}if jj_objseg_write64(sink as *i64,fgr_offset+48+i*32,reom_packed)==0{return 0;}if jj_objseg_write64(sink as *i64,fgr_offset+56+i*32,code_hashes[i])==0{return 0;}fgr_total=fgr_total+((fgr_packed>>>32)&65535)+(reo_packed&65535)+((reo_packed>>>16)&65535)+((reo_packed>>>32)&65535)+((reo_packed>>>48)&65535)+(reom_packed&65535)+((reom_packed>>>16)&65535);i=i+1;}if jj_objseg_write64(sink as *i64,fgr_offset+24,fgr_total)==0{return 0;}
  if jj_obj_write_shstr(sink as *i64,shstr_offset)==0{return 0;}
  if jj_objseg_write8(sink as *i64,0,0x7f)==0{return 0;}if jj_objseg_write8(sink as *i64,1,69)==0{return 0;}if jj_objseg_write8(sink as *i64,2,76)==0{return 0;}if jj_objseg_write8(sink as *i64,3,70)==0{return 0;}if jj_objseg_write8(sink as *i64,4,2)==0{return 0;}if jj_objseg_write8(sink as *i64,5,1)==0{return 0;}if jj_objseg_write8(sink as *i64,6,1)==0{return 0;}
  if jj_objseg_write16(sink as *i64,16,1)==0{return 0;}if jj_objseg_write16(sink as *i64,18,62)==0{return 0;}if jj_objseg_write32(sink as *i64,20,1)==0{return 0;}if jj_objseg_write64(sink as *i64,40,section_offset)==0{return 0;}if jj_objseg_write16(sink as *i64,52,64)==0{return 0;}if jj_objseg_write16(sink as *i64,58,64)==0{return 0;}if jj_objseg_write16(sink as *i64,60,13)==0{return 0;}if jj_objseg_write16(sink as *i64,62,12)==0{return 0;}
  var desc:[10]i64;var sh:i64=section_offset+64;
  desc[0]=1;desc[1]=1;desc[2]=6;desc[3]=0;desc[4]=text_offset;desc[5]=text_size;desc[6]=0;desc[7]=0;desc[8]=16;desc[9]=0;if jj_obj_sh64(sink as *i64,sh,desc)==0{return 0;}sh=sh+64;
  desc[0]=7;desc[1]=2;desc[2]=0;desc[3]=0;desc[4]=symtab_offset;desc[5]=symtab_size;desc[6]=3;desc[7]=1;desc[8]=8;desc[9]=24;if jj_obj_sh64(sink as *i64,sh,desc)==0{return 0;}sh=sh+64;
  desc[0]=15;desc[1]=3;desc[2]=0;desc[3]=0;desc[4]=strtab_offset;desc[5]=string_size;desc[6]=0;desc[7]=0;desc[8]=1;desc[9]=0;if jj_obj_sh64(sink as *i64,sh,desc)==0{return 0;}sh=sh+64;
  desc[0]=23;desc[1]=4;desc[2]=0;desc[3]=0;desc[4]=rela_offset;desc[5]=rela_size;desc[6]=2;desc[7]=1;desc[8]=8;desc[9]=24;if jj_obj_sh64(sink as *i64,sh,desc)==0{return 0;}sh=sh+64;
  desc[0]=34;desc[1]=1;desc[2]=0;desc[3]=0;desc[4]=line_offset;desc[5]=line_size;desc[6]=0;desc[7]=0;desc[8]=1;desc[9]=0;if jj_obj_sh64(sink as *i64,sh,desc)==0{return 0;}sh=sh+64;
  desc[0]=46;desc[1]=1;desc[2]=0;desc[3]=0;desc[4]=abbrev_offset;desc[5]=abbrev_size;desc[6]=0;desc[7]=0;desc[8]=1;desc[9]=0;if jj_obj_sh64(sink as *i64,sh,desc)==0{return 0;}sh=sh+64;
  desc[0]=60;desc[1]=1;desc[2]=0;desc[3]=0;desc[4]=info_offset;desc[5]=info_size;desc[6]=0;desc[7]=0;desc[8]=1;desc[9]=0;if jj_obj_sh64(sink as *i64,sh,desc)==0{return 0;}sh=sh+64;
  desc[0]=72;desc[1]=1;desc[2]=0;desc[3]=0;desc[4]=ast_offset;desc[5]=ast_size;desc[6]=0;desc[7]=0;desc[8]=8;desc[9]=0;if jj_obj_sh64(sink as *i64,sh,desc)==0{return 0;}sh=sh+64;
  desc[0]=82;desc[1]=1;desc[2]=0;desc[3]=0;desc[4]=span_offset;desc[5]=span_size;desc[6]=0;desc[7]=0;desc[8]=8;desc[9]=0;if jj_obj_sh64(sink as *i64,sh,desc)==0{return 0;}sh=sh+64;
  desc[0]=91;desc[1]=1;desc[2]=0;desc[3]=0;desc[4]=map_offset;desc[5]=map_size;desc[6]=0;desc[7]=0;desc[8]=8;desc[9]=0;if jj_obj_sh64(sink as *i64,sh,desc)==0{return 0;}sh=sh+64;
  desc[0]=99;desc[1]=1;desc[2]=0;desc[3]=0;desc[4]=fgr_offset;desc[5]=fgr_size;desc[6]=0;desc[7]=0;desc[8]=8;desc[9]=32;if jj_obj_sh64(sink as *i64,sh,desc)==0{return 0;}sh=sh+64;
  desc[0]=107;desc[1]=3;desc[2]=0;desc[3]=0;desc[4]=shstr_offset;desc[5]=shstr_size;desc[6]=0;desc[7]=0;desc[8]=1;desc[9]=0;if jj_obj_sh64(sink as *i64,sh,desc)==0{return 0;}
  return jj_objseg_commit(sink as *i64,total);
}
