// Named IA-32 allocator-backed function module with an optional semantic call. Mode 1 retains a terminal call-return; mode 2 materializes a
// call result as SSA so values may remain live across the unresolved edge. The
// ABI is exactly (i64)->i64 and the edge is published as
// R_386_PC32 against a signature-mangled external symbol.
extern fn jj_sink_write8_at(p0:*i8,p1:i64,p2:i64,p3:i64)->i64;
extern fn jj_sink_write16_at(p0:*i8,p1:i64,p2:i64,p3:i64)->i64;
extern fn jj_sink_write32_at(p0:*i8,p1:i64,p2:i64,p3:i64)->i64;
extern fn jj_c_hash_bytes(p0:*i8,p1:i64,p2:i64)->i64;
extern fn jj_cir_view_valid(p0:*i64)->i64;
extern fn jj_cir_validate(p0:*i64,p1:i64)->i64;
extern fn jj_target_profile_validate(p0:*i64,p1:i64)->i64;
extern fn jj_target_allocator_validate_for(p0:*i64,p1:i64,p2:*i64,p3:i64,p4:*i64,p5:i64)->i64;
extern fn jj_target_i386_module_validate(p0:*i8,p1:i64,p2:i64,p3:i64)->i64;
extern fn jj_i386_abi_name_bytes(p0:i64)->i64;
extern fn jj_i386_abi_write_name(p0:*i8,p1:i64,p2:i64,p3:*i64)->i64;
extern fn jj_i386a_slot_bytes(p0:i64)->i64;
extern fn jj_i386a_nonoverlap(p0:i64,p1:i64,p2:i64,p3:i64)->i64;
extern fn jj_i386a_align(p0:i64,p1:i64)->i64;
extern fn jj_i386a_save_mask(p0:*i64,p1:*i64)->i64;
extern fn jj_i386a_save_count(p0:i64)->i64;
extern fn jj_i386a_loc_size(p0:*i64,p1:i64)->i64;
extern fn jj_i386a_materialized(p0:*i64,p1:*i64,p2:i64)->i64;
extern fn jj_i386a_node_size(p0:*i64,p1:*i64,p2:i64)->i64;
extern fn jj_i386a_emit_prologue(p0:*i64,p1:*i64,p2:i64)->i64;
extern fn jj_i386a_emit_node(p0:*i64,p1:*i64,p2:*i64,p3:i64,p4:i64)->i64;
extern fn jj_i386a_load(p0:*i64,p1:*i64,p2:i64,p3:i64)->i64;
extern fn jj_i386a_store(p0:*i64,p1:*i64,p2:i64,p3:i64)->i64;
extern fn jj_i386a_emit_epilogue(p0:*i64,p1:*i64,p2:i64)->i64;
extern fn jj_i386a_put8(p0:*i64,p1:i64)->i64;
extern fn jj_i386a_put16(p0:*i8,p1:i64,p2:i64,p3:i64)->i64;
extern fn jj_i386a_put32(p0:*i64,p1:i64)->i64;
extern fn jj_i386a_write32(p0:*i8,p1:i64,p2:i64,p3:i64)->i64;
extern fn jj_i386a_zero(p0:*i8,p1:i64,p2:i64)->i64;
extern fn jj_i386a_shstr(p0:*i8,p1:i64,p2:i64)->i64;
extern fn jj_i386a_section(p0:*i8,p1:i64,p2:i64,p3:*i64)->i64;

fn jj_i386c_name_range(length:i64,start:i64,count:i64)->i64{
  if length<=0{return 0;}if start<0{return 0;}if count<=0{return 0;}if start>length{return 0;}if count>length-start{return 0;}return 1;
}
fn jj_i386c_same_name(context:*i64)->i64{
  if context==0{return 0;}if context[10]!=context[13]{return 0;}var source:*i8=context[7] as *i8;var i:i64=0;while i<context[10]{if source[context[9]+i]!=source[context[12]+i]{return 0;}i=i+1;}return 1;
}
fn jj_i386_allocator_call_context_seal(context:*i64)->i64{
  if context==0{return 0;}var h:i64=(context as i64)^0x4a4a493343414c4c;var i:i64=0;while i<17{h=h^context[i];h=(h<<9)|(h>>>55);h=h^(i*0x9e37);i=i+1;}if h==0{h=0x4a4a493343414c4c;}return h;
}
fn jj_i386c_context_valid(context:*i64)->i64{
  if context==0{return 0;}if context[0]==0{return 0;}if context[1]<=0{return 0;}if context[2]==0{return 0;}if context[3]==0{return 0;}if context[4]!=32{return 0;}if context[5]==0{return 0;}if context[6]<17{return 0;}if context[7]==0{return 0;}if context[8]<=0{return 0;}
  if jj_i386c_name_range(context[8],context[9],context[10])==0{return 0;}if context[11]!=0x12177{return 0;}var mode:i64=context[16];if mode<0{return 0;}if mode>2{return 0;}
  if mode==0{if context[12]!=0{return 0;}if context[13]!=0{return 0;}if context[14]!=0{return 0;}if context[15]!=0{return 0;}}
  else{if jj_i386c_name_range(context[8],context[12],context[13])==0{return 0;}if context[14]!=0x12177{return 0;}if context[15]<=0{return 0;}if context[15]>0x7fffffff{return 0;}if jj_i386c_same_name(context)!=0{return 0;}}
  if context[17]!=jj_i386_allocator_call_context_seal(context){return 0;}return 1;
}
fn jj_i386c_call_input_size(plan:*i64,value:i64)->i64{
  if plan==0{return 0;}if value<=0{return 0;}var b:i64=12+(value-1)*5;if plan[b+1]==1{if plan[b+2]==0{return 2;}if plan[b+2]==2{return 2;}return 0;}if plan[b+1]==2{return 14;}return 0;
}
fn jj_i386c_push_call_input(st:*i64,plan:*i64,value:i64,saved:i64)->i64{
  if st==0{return 0;}if plan==0{return 0;}if value<=0{return 0;}var b:i64=12+(value-1)*5;
  if plan[b+1]==1{if plan[b+2]==0{if jj_i386a_put8(st as *i64,0x57)==0{return 0;}return jj_i386a_put8(st as *i64,0x56);}if plan[b+2]==2{if jj_i386a_put8(st as *i64,0x51)==0{return 0;}return jj_i386a_put8(st as *i64,0x53);}return 0;}
  if plan[b+1]==2{if jj_i386a_load(st as *i64,plan,value,saved)==0{return 0;}if jj_i386a_put8(st as *i64,0x52)==0{return 0;}return jj_i386a_put8(st as *i64,0x50);}return 0;
}
fn jj_i386c_call_count(cir:*i64)->i64{
  if cir==0{return 0;}if cir[1]!=2{return 0;}var count:i64=cir[3];var value:i64=1;var calls:i64=0;
  while value<=count{var nb:i64=cir[11]+(value-1)*4;if cir[nb]==3{calls=calls+1;}value=value+1;}return calls;
}
fn jj_i386c_call_value(cir:*i64)->i64{
  if cir==0{return 0;}if cir[1]!=2{return 0;}var count:i64=cir[3];var value:i64=1;var found:i64=0;
  while value<=count{var nb:i64=cir[11]+(value-1)*4;if cir[nb]==3{if found!=0{return 0;}found=value;}value=value+1;}return found;
}
fn jj_i386c_call_node_size(cir:*i64,plan:*i64,value:i64)->i64{
  if cir==0{return 0;}if plan==0{return 0;}if value<=0{return 0;}var nb:i64=cir[11]+(value-1)*4;if cir[nb]!=3{return 0;}
  var input:i64=jj_i386c_call_input_size(plan,cir[nb+2]);if input<=0{return 0;}var store:i64=0;
  if jj_i386a_materialized(cir,plan,value)!=0{store=jj_i386a_loc_size(plan,value);if store<=0{return 0;}}return input+8+store;
}
fn jj_i386c_emit_call_node(st:*i64,cir:*i64,plan:*i64,value:i64,saved:i64,reloc:*i64)->i64{
  if st==0{return 0;}if cir==0{return 0;}if plan==0{return 0;}if reloc==0{return 0;}if reloc[0]!=0{return 0;}
  var nb:i64=cir[11]+(value-1)*4;if cir[nb]!=3{return 0;}if jj_i386c_push_call_input(st,plan,cir[nb+2],saved)==0{return 0;}
  reloc[0]=(st[2]+1)-64;if jj_i386a_put8(st,0xe8)==0{return 0;}if jj_i386a_put32(st,0xfffffffc)==0{return 0;}
  if jj_i386a_put8(st,0x83)==0{return 0;}if jj_i386a_put8(st,0xc4)==0{return 0;}if jj_i386a_put8(st,8)==0{return 0;}
  if jj_i386a_materialized(cir,plan,value)!=0{return jj_i386a_store(st,plan,value,saved);}return 1;
}

fn jj_i386c_code_size(cir:*i64,plan:*i64,saves:i64,mode:i64)->i64{
  if cir==0{return 0;}if plan==0{return 0;}if cir[1]!=2{return 0;}if cir[2]!=1{return 0;}var bb:i64=12;var term:i64=cir[bb+2];
  if mode==0{if term!=1{return 0;}if jj_i386c_call_count(cir)!=0{return 0;}}
  else{if mode==1{if term!=4{return 0;}if jj_i386c_call_count(cir)!=0{return 0;}}
  else{if mode==2{if term!=1{return 0;}if jj_i386c_call_count(cir)!=1{return 0;}}else{return 0;}}}
  var size:i64=3+jj_i386a_save_count(saves);if plan[5]!=0{size=size+6;}var first:i64=cir[bb];var count:i64=cir[bb+1];var value:i64=first;
  while value<first+count{var nb:i64=cir[11]+(value-1)*4;var add:i64=0;if mode==2{if cir[nb]==3{add=jj_i386c_call_node_size(cir,plan,value);}else{add=jj_i386a_node_size(cir,plan,value);}}else{add=jj_i386a_node_size(cir,plan,value);}
    if add<=0{return 0;}if size>0x7fffffff-add{return 0;}size=size+add;value=value+1;}
  if mode==1{var input_size:i64=jj_i386c_call_input_size(plan,cir[bb+3]);if input_size<=0{return 0;}if size>0x7fffffff-input_size-8{return 0;}size=size+input_size+8;}
  else{var load:i64=jj_i386a_loc_size(plan,cir[bb+3]);if load<=0{return 0;}if size>0x7fffffff-load{return 0;}size=size+load;}
  var tail:i64=2+jj_i386a_save_count(saves);if plan[5]!=0{tail=tail+6;}if size>0x7fffffff-tail{return 0;}return size+tail;
}
fn jj_i386c_emit_code(ec:*i64)->i64{
  if ec==0{return 0;}var out:*i8=ec[0] as *i8;var capacity:i64=ec[1];var cir:*i64=ec[2] as *i64;var plan:*i64=ec[3] as *i64;var code_size:i64=ec[4];var saves:i64=ec[5];var mode:i64=ec[6];var reloc:*i64=ec[7] as *i64;
  if out==0{return 0;}if cir==0{return 0;}if plan==0{return 0;}if reloc==0{return 0;}reloc[0]=0;var st:[3]i64;st[0]=out as i64;st[1]=capacity;st[2]=64;var saved:i64=jj_i386a_save_count(saves);
  if jj_i386a_emit_prologue(st as *i64,plan,saves)==0{return 0;}var bb:i64=12;var value:i64=cir[bb];var end:i64=value+cir[bb+1];
  while value<end{var nb:i64=cir[11]+(value-1)*4;if mode==2{if cir[nb]==3{if jj_i386c_emit_call_node(st as *i64,cir,plan,value,saved,reloc)==0{return 0;}}else{if jj_i386a_emit_node(st as *i64,cir,plan,value,saved)==0{return 0;}}}else{if jj_i386a_emit_node(st as *i64,cir,plan,value,saved)==0{return 0;}}value=value+1;}
  if mode==1{if jj_i386c_push_call_input(st as *i64,plan,cir[bb+3],saved)==0{return 0;}reloc[0]=(st[2]+1)-64;if jj_i386a_put8(st as *i64,0xe8)==0{return 0;}if jj_i386a_put32(st as *i64,0xfffffffc)==0{return 0;}if jj_i386a_put8(st as *i64,0x83)==0{return 0;}if jj_i386a_put8(st as *i64,0xc4)==0{return 0;}if jj_i386a_put8(st as *i64,8)==0{return 0;}}
  else{if jj_i386a_load(st as *i64,plan,cir[bb+3],saved)==0{return 0;}}
  if jj_i386a_emit_epilogue(st as *i64,plan,saves)==0{return 0;}if st[2]!=64+code_size{return 0;}if mode==0{if reloc[0]!=0{return 0;}}else{if reloc[0]<=0{return 0;}}return 1;
}

fn jj_i386c_digest(out:*i8,omega:i64,profile:i64,relocs:i64,external:i64)->i64{
  var h:i64=jj_c_hash_bytes(out,64,omega-64)^profile^0x4a4a49334d4f4431;h=((h<<11)|(h>>>53))^relocs;h=((h<<13)|(h>>>51))^1;h=((h<<17)|(h>>>47))^external;if h==0{h=0x4a4a49334d4f4431;}return h;
}
fn jj_i386c_write_symbols(out:*i8,capacity:i64,sym:i64,str:i64,code_size:i64,context:*i64)->i64{
  out[sym+16+12]=3;if jj_i386a_put16(out,capacity,sym+30,1)==0{return 0;}var source:*i8=context[7] as *i8;var nc:[4]i64;nc[0]=source as i64;nc[1]=context[9];nc[2]=context[10];nc[3]=context[11];
  if jj_i386a_write32(out,capacity,sym+32,1)==0{return 0;}if jj_i386a_write32(out,capacity,sym+36,0)==0{return 0;}if jj_i386a_write32(out,capacity,sym+40,code_size)==0{return 0;}out[sym+44]=0x12;if jj_i386a_put16(out,capacity,sym+46,1)==0{return 0;}out[str]=0;
  var next:i64=jj_i386_abi_write_name(out,capacity,str+1,nc as *i64);if next==0{return 0;}if context[16]!=0{var def_bytes:i64=jj_i386_abi_name_bytes(context[10]);if def_bytes<=0{return 0;}var ext:i64=sym+48;if jj_i386a_write32(out,capacity,ext,1+def_bytes)==0{return 0;}out[ext+12]=0x12;if jj_i386a_put16(out,capacity,ext+14,0)==0{return 0;}nc[1]=context[12];nc[2]=context[13];nc[3]=context[14];next=jj_i386_abi_write_name(out,capacity,next,nc as *i64);if next==0{return 0;}}return next;
}
fn jj_target_emit_i386_allocated_named(context:*i64)->i64{
  if jj_i386c_context_valid(context)==0{return 0;}var out:*i8=context[0] as *i8;var capacity:i64=context[1];var view:*i64=context[2] as *i64;var profile:*i64=context[3] as *i64;var plan:*i64=context[5] as *i64;var mode:i64=context[16];
  if jj_cir_view_valid(view)==0{return 0;}var cir:*i64=view[0] as *i64;var cir_slots:i64=view[1];if jj_cir_validate(cir,cir_slots)==0{return 0;}if cir[1]!=2{return 0;}if cir[2]!=1{return 0;}if cir[4]!=1{return 0;}if cir[5]!=1{return 0;}
  if jj_target_profile_validate(profile,context[4])==0{return 0;}if profile[2]!=8{return 0;}if jj_target_allocator_validate_for(cir,cir_slots,profile,context[4],plan,context[6])==0{return 0;}var bb:i64=12;
  if mode==0{if cir[bb+2]!=1{return 0;}}
  else{if mode==1{if cir[bb+2]!=4{return 0;}if cir[bb+4]!=context[15]{return 0;}if cir[bb+5]!=context[14]{return 0;}}
  else{if cir[bb+2]!=1{return 0;}var call_value:i64=jj_i386c_call_value(cir);if call_value<=0{return 0;}var call_base:i64=cir[11]+(call_value-1)*4;if cir[call_base+3]!=context[15]{return 0;}}}
  var saves:i64=jj_i386a_save_mask(cir,plan);if saves<0{return 0;}var code_size:i64=jj_i386c_code_size(cir,plan,saves,mode);if code_size<=0{return 0;}var relocs:i64=0;var external:i64=0;if mode!=0{relocs=1;external=1;}
  var rel:i64=jj_i386a_align(64+code_size,4);if rel<0{return 0;}var rel_size:i64=relocs*8;var sym:i64=rel+rel_size;var sym_size:i64=(3+external)*16;var str:i64=sym+sym_size;
  var def_bytes:i64=jj_i386_abi_name_bytes(context[10]);if def_bytes<=0{return 0;}var str_size:i64=1+def_bytes;if mode!=0{var ext_bytes:i64=jj_i386_abi_name_bytes(context[13]);if ext_bytes<=0{return 0;}if str_size>0x7fffffff-ext_bytes{return 0;}str_size=str_size+ext_bytes;}
  var omega:i64=jj_i386a_align(str+str_size,8);if omega<0{return 0;}var shstr:i64=omega+56;var shoff:i64=jj_i386a_align(shstr+50,4);if shoff<0{return 0;}var total:i64=shoff+280;if total<=shoff{return 0;}if capacity<total{return 0;}
  var cir_bytes:i64=jj_i386a_slot_bytes(cir_slots);var profile_bytes:i64=jj_i386a_slot_bytes(context[4]);var plan_bytes:i64=jj_i386a_slot_bytes(context[6]);if cir_bytes==0{return 0;}if profile_bytes==0{return 0;}if plan_bytes==0{return 0;}
  if jj_i386a_nonoverlap(out as i64,total,context as i64,144)==0{return 0;}if jj_i386a_nonoverlap(out as i64,total,view as i64,32)==0{return 0;}if jj_i386a_nonoverlap(out as i64,total,cir as i64,cir_bytes)==0{return 0;}if jj_i386a_nonoverlap(out as i64,total,profile as i64,profile_bytes)==0{return 0;}if jj_i386a_nonoverlap(out as i64,total,plan as i64,plan_bytes)==0{return 0;}if jj_i386a_nonoverlap(out as i64,total,context[7],context[8])==0{return 0;}
  if jj_i386a_nonoverlap(context as i64,144,view as i64,32)==0{return 0;}if jj_i386a_nonoverlap(context as i64,144,cir as i64,cir_bytes)==0{return 0;}if jj_i386a_nonoverlap(context as i64,144,profile as i64,profile_bytes)==0{return 0;}if jj_i386a_nonoverlap(context as i64,144,plan as i64,plan_bytes)==0{return 0;}
  if jj_i386a_nonoverlap(view as i64,32,cir as i64,cir_bytes)==0{return 0;}if jj_i386a_nonoverlap(view as i64,32,profile as i64,profile_bytes)==0{return 0;}if jj_i386a_nonoverlap(view as i64,32,plan as i64,plan_bytes)==0{return 0;}if jj_i386a_nonoverlap(cir as i64,cir_bytes,profile as i64,profile_bytes)==0{return 0;}if jj_i386a_nonoverlap(cir as i64,cir_bytes,plan as i64,plan_bytes)==0{return 0;}if jj_i386a_nonoverlap(profile as i64,profile_bytes,plan as i64,plan_bytes)==0{return 0;}
  if jj_i386a_zero(out,capacity,total)==0{return 0;}out[0]=0x7f;out[1]=69;out[2]=76;out[3]=70;out[4]=1;out[5]=1;out[6]=1;if jj_i386a_put16(out,capacity,16,1)==0{return 0;}if jj_i386a_put16(out,capacity,18,3)==0{return 0;}if jj_i386a_write32(out,capacity,20,1)==0{return 0;}if jj_i386a_write32(out,capacity,32,shoff)==0{return 0;}if jj_i386a_put16(out,capacity,40,52)==0{return 0;}if jj_i386a_put16(out,capacity,46,40)==0{return 0;}if jj_i386a_put16(out,capacity,48,7)==0{return 0;}if jj_i386a_put16(out,capacity,50,6)==0{return 0;}
  var relocation:[1]i64;var emit_context:[8]i64;emit_context[0]=out as i64;emit_context[1]=capacity;emit_context[2]=cir as i64;emit_context[3]=plan as i64;emit_context[4]=code_size;emit_context[5]=saves;emit_context[6]=mode;emit_context[7]=relocation as i64;if jj_i386c_emit_code(emit_context as *i64)==0{return 0;}if mode!=0{if relocation[0]<=0{return 0;}if jj_i386a_write32(out,capacity,rel,relocation[0])==0{return 0;}if jj_i386a_write32(out,capacity,rel+4,(3<<8)|2)==0{return 0;}}
  var end_names:i64=jj_i386c_write_symbols(out,capacity,sym,str,code_size,context);if end_names!=str+str_size{return 0;}if jj_i386a_write32(out,capacity,omega,0x4f4d4547)==0{return 0;}if jj_i386a_write32(out,capacity,omega+4,0x41333836)==0{return 0;}
  var digest:i64=jj_i386c_digest(out,omega,profile[31],relocs,external);var text_hash:i64=jj_c_hash_bytes(out,64,code_size);var vals:[6]i64;vals[0]=profile[31];vals[1]=digest;vals[2]=text_hash;vals[3]=relocs;vals[4]=1;vals[5]=external;var vi:i64=0;while vi<6{if jj_i386a_write32(out,capacity,omega+8+vi*8,vals[vi])==0{return 0;}if jj_i386a_write32(out,capacity,omega+12+vi*8,vals[vi]>>>32)==0{return 0;}vi=vi+1;}
  if jj_i386a_shstr(out,capacity,shstr)==0{return 0;}var d:[10]i64;var sh:i64=shoff+40;d[0]=1;d[1]=1;d[2]=6;d[3]=0;d[4]=64;d[5]=code_size;d[6]=0;d[7]=0;d[8]=16;d[9]=0;if jj_i386a_section(out,capacity,sh,d as *i64)==0{return 0;}
  sh=sh+40;d[0]=7;d[1]=9;d[2]=0;d[3]=0;d[4]=rel;d[5]=rel_size;d[6]=3;d[7]=1;d[8]=4;d[9]=8;if jj_i386a_section(out,capacity,sh,d as *i64)==0{return 0;}
  sh=sh+40;d[0]=17;d[1]=2;d[2]=0;d[3]=0;d[4]=sym;d[5]=sym_size;d[6]=4;d[7]=2;d[8]=4;d[9]=16;if jj_i386a_section(out,capacity,sh,d as *i64)==0{return 0;}
  sh=sh+40;d[0]=25;d[1]=3;d[2]=0;d[3]=0;d[4]=str;d[5]=str_size;d[6]=0;d[7]=0;d[8]=1;d[9]=0;if jj_i386a_section(out,capacity,sh,d as *i64)==0{return 0;}
  sh=sh+40;d[0]=33;d[1]=1;d[2]=0;d[3]=0;d[4]=omega;d[5]=56;d[6]=0;d[7]=0;d[8]=8;d[9]=0;if jj_i386a_section(out,capacity,sh,d as *i64)==0{return 0;}
  sh=sh+40;d[0]=40;d[1]=3;d[2]=0;d[3]=0;d[4]=shstr;d[5]=50;d[6]=0;d[7]=0;d[8]=1;d[9]=0;if jj_i386a_section(out,capacity,sh,d as *i64)==0{return 0;}
  if jj_target_i386_module_validate(out,total,profile[31],digest)==0{jj_i386a_zero(out,capacity,total);return 0;}return total;
}
fn jj_i386_allocator_call_resource_contract(out:*i64,slots:i64)->i64{
  if out==0{return 0;}if slots!=8{return 0;}out[0]=512;out[1]=512;out[2]=2048;out[3]=2;out[4]=1;out[5]=1;out[6]=1;out[7]=(out as i64)^0x4a4a493343414c52;return 1;
}
