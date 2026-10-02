// Allocator-governed IA-32 ELF32 object emitter for sealed CIR v1/v2.
// The target plan controls physical pairs and reusable spill slots. Binary
// operations consume register or frame operands directly; the host stack is
// never used as an expression transport.
extern fn jj_sink_write8_at(p0:*i8,p1:i64,p2:i64,p3:i64)->i64;
extern fn jj_sink_write16_at(p0:*i8,p1:i64,p2:i64,p3:i64)->i64;
extern fn jj_sink_write32_at(p0:*i8,p1:i64,p2:i64,p3:i64)->i64;
extern fn jj_c_hash_bytes(p0:*i8,p1:i64,p2:i64)->i64;
extern fn jj_cir_view_valid(p0:*i64)->i64;
extern fn jj_cir_validate(p0:*i64,p1:i64)->i64;
extern fn jj_target_profile_validate(p0:*i64,p1:i64)->i64;
extern fn jj_target_allocator_validate_for(p0:*i64,p1:i64,p2:*i64,p3:i64,p4:*i64,p5:i64)->i64;
extern fn jj_target_i386_module_validate(p0:*i8,p1:i64,p2:i64,p3:i64)->i64;

fn jj_i386a_put8(st:*i64,v:i64)->i64{
  if jj_sink_write8_at(st[0] as *i8,st[1],st[2],v)==0{return 0;}st[2]=st[2]+1;return 1;
}
fn jj_i386a_put16(out:*i8,cap:i64,at:i64,v:i64)->i64{return jj_sink_write16_at(out,cap,at,v);}
fn jj_i386a_put32(st:*i64,v:i64)->i64{
  if jj_sink_write32_at(st[0] as *i8,st[1],st[2],v)==0{return 0;}st[2]=st[2]+4;return 1;
}
fn jj_i386a_write32(out:*i8,cap:i64,at:i64,v:i64)->i64{return jj_sink_write32_at(out,cap,at,v);}
fn jj_i386a_zero(out:*i8,cap:i64,n:i64)->i64{
  if out==0{return 0;}if n<=0{return 0;}if n>cap{return 0;}var i:i64=0;while i<n{out[i]=0;i=i+1;}return 1;
}
fn jj_i386a_nonoverlap(a:i64,an:i64,b:i64,bn:i64)->i64{
  if a<=0{return 0;}if b<=0{return 0;}if an<=0{return 0;}if bn<=0{return 0;}
  if a<b{if b-a<an{return 0;}}else{if a-b<bn{return 0;}}return 1;
}
fn jj_i386a_slot_bytes(slots:i64)->i64{
  if slots<=0{return 0;}if slots>0x0fffffffffffffff{return 0;}return slots*8;
}
fn jj_i386a_align(v:i64,a:i64)->i64{
  if v<0{return 0-1;}if a<=0{return 0-1;}if v>0x7fffffffffffffff-(a-1){return 0-1;}return ((v+a-1)/a)*a;
}
fn jj_i386a_count(cir:*i64)->i64{
  if cir[1]==1{return cir[2];}if cir[1]==2{return cir[3];}return 0;
}
fn jj_i386a_node_base(cir:*i64,value:i64)->i64{
  if value<=0{return 0;}if cir[1]==1{return 8+(value-1)*4;}if cir[1]==2{return cir[11]+(value-1)*4;}return 0;
}
fn jj_i386a_base(value:i64)->i64{if value<=0{return 0;}return 12+(value-1)*5;}
fn jj_i386a_materialized(cir:*i64,plan:*i64,value:i64)->i64{
  var b:i64=jj_i386a_base(value);if b==0{return 0;}
  if cir[1]==1{if value==cir[2]{if cir[6]==value{return 0;}}}
  if plan[b]>value{return 1;}return 0;
}
fn jj_i386a_save_mask(cir:*i64,plan:*i64)->i64{
  var count:i64=jj_i386a_count(cir);if count<=0{return 0-1;}var mask:i64=0;var value:i64=1;
  while value<=count{
    if jj_i386a_materialized(cir,plan,value)!=0{
      var b:i64=jj_i386a_base(value);if plan[b+1]==1{
        if plan[b+2]==0{mask=mask|6;}else{if plan[b+2]==2{mask=mask|1;}else{return 0-1;}}
      }
    }
    value=value+1;
  }
  return mask;
}
fn jj_i386a_save_count(mask:i64)->i64{
  var n:i64=0;if (mask&1)!=0{n=n+1;}if (mask&2)!=0{n=n+1;}if (mask&4)!=0{n=n+1;}return n;
}
fn jj_i386a_loc_size(plan:*i64,value:i64)->i64{
  var b:i64=jj_i386a_base(value);if b==0{return 0;}if plan[b+1]==1{return 4;}if plan[b+1]==2{return 12;}return 0;
}
fn jj_i386a_disp(plan:*i64,value:i64,saved:i64)->i64{
  var b:i64=jj_i386a_base(value);if b==0{return 0;}if plan[b+1]!=2{return 0;}var slot:i64=plan[b+2];
  if slot<0{return 0;}if slot>0x0fffffff{return 0;}if saved<0{return 0;}if saved>3{return 0;}return 0-(saved*4+8+slot*8);
}
fn jj_i386a_load(st:*i64,plan:*i64,value:i64,saved:i64)->i64{
  var b:i64=jj_i386a_base(value);if b==0{return 0;}var kind:i64=plan[b+1];var index:i64=plan[b+2];
  if kind==1{
    if index==0{if jj_i386a_put8(st,0x89)==0{return 0;}if jj_i386a_put8(st,0xf0)==0{return 0;}if jj_i386a_put8(st,0x89)==0{return 0;}return jj_i386a_put8(st,0xfa);}
    if index==2{if jj_i386a_put8(st,0x89)==0{return 0;}if jj_i386a_put8(st,0xd8)==0{return 0;}if jj_i386a_put8(st,0x89)==0{return 0;}return jj_i386a_put8(st,0xca);}
    return 0;
  }
  if kind==2{
    var d:i64=jj_i386a_disp(plan,value,saved);if d==0{return 0;}
    if jj_i386a_put8(st,0x8b)==0{return 0;}if jj_i386a_put8(st,0x85)==0{return 0;}if jj_i386a_put32(st,d)==0{return 0;}
    if jj_i386a_put8(st,0x8b)==0{return 0;}if jj_i386a_put8(st,0x95)==0{return 0;}return jj_i386a_put32(st,d+4);
  }
  return 0;
}
fn jj_i386a_store(st:*i64,plan:*i64,value:i64,saved:i64)->i64{
  var b:i64=jj_i386a_base(value);if b==0{return 0;}var kind:i64=plan[b+1];var index:i64=plan[b+2];
  if kind==1{
    if index==0{if jj_i386a_put8(st,0x89)==0{return 0;}if jj_i386a_put8(st,0xc6)==0{return 0;}if jj_i386a_put8(st,0x89)==0{return 0;}return jj_i386a_put8(st,0xd7);}
    if index==2{if jj_i386a_put8(st,0x89)==0{return 0;}if jj_i386a_put8(st,0xc3)==0{return 0;}if jj_i386a_put8(st,0x89)==0{return 0;}return jj_i386a_put8(st,0xd1);}
    return 0;
  }
  if kind==2{
    var d:i64=jj_i386a_disp(plan,value,saved);if d==0{return 0;}
    if jj_i386a_put8(st,0x89)==0{return 0;}if jj_i386a_put8(st,0x85)==0{return 0;}if jj_i386a_put32(st,d)==0{return 0;}
    if jj_i386a_put8(st,0x89)==0{return 0;}if jj_i386a_put8(st,0x95)==0{return 0;}return jj_i386a_put32(st,d+4);
  }
  return 0;
}
fn jj_i386a_load_arg(st:*i64)->i64{
  if jj_i386a_put8(st,0x8b)==0{return 0;}if jj_i386a_put8(st,0x85)==0{return 0;}if jj_i386a_put32(st,8)==0{return 0;}
  if jj_i386a_put8(st,0x8b)==0{return 0;}if jj_i386a_put8(st,0x95)==0{return 0;}return jj_i386a_put32(st,12);
}
fn jj_i386a_constant(st:*i64,value:i64)->i64{
  if jj_i386a_put8(st,0xb8)==0{return 0;}if jj_i386a_put32(st,value)==0{return 0;}
  if jj_i386a_put8(st,0xba)==0{return 0;}return jj_i386a_put32(st,value>>>32);
}
fn jj_i386a_read_ops(op:i64,codes:*i64)->i64{
  if codes==0{return 0;}
  if op==9{codes[0]=0x03;codes[1]=0x13;codes[2]=0x01;codes[3]=0x11;return 1;}
  if op==10{codes[0]=0x2b;codes[1]=0x1b;codes[2]=0x29;codes[3]=0x19;return 1;}
  if op==16{codes[0]=0x23;codes[1]=0x23;codes[2]=0x21;codes[3]=0x21;return 1;}
  if op==17{codes[0]=0x0b;codes[1]=0x0b;codes[2]=0x09;codes[3]=0x09;return 1;}
  if op==18{codes[0]=0x33;codes[1]=0x33;codes[2]=0x31;codes[3]=0x31;return 1;}
  return 0;
}
fn jj_i386a_apply(st:*i64,plan:*i64,value:i64,op:i64,saved:i64)->i64{
  var codes:[4]i64;if jj_i386a_read_ops(op,codes as *i64)==0{return 0;}var b:i64=jj_i386a_base(value);if b==0{return 0;}
  if plan[b+1]==1{
    var lo:i64=0;var hi:i64=0;if plan[b+2]==0{lo=0xf0;hi=0xfa;}else{if plan[b+2]==2{lo=0xd8;hi=0xca;}else{return 0;}}
    if jj_i386a_put8(st,codes[2])==0{return 0;}if jj_i386a_put8(st,lo)==0{return 0;}
    if jj_i386a_put8(st,codes[3])==0{return 0;}return jj_i386a_put8(st,hi);
  }
  if plan[b+1]==2{
    var d:i64=jj_i386a_disp(plan,value,saved);if d==0{return 0;}
    if jj_i386a_put8(st,codes[0])==0{return 0;}if jj_i386a_put8(st,0x85)==0{return 0;}if jj_i386a_put32(st,d)==0{return 0;}
    if jj_i386a_put8(st,codes[1])==0{return 0;}if jj_i386a_put8(st,0x95)==0{return 0;}return jj_i386a_put32(st,d+4);
  }
  return 0;
}
fn jj_i386a_op_supported(op:i64)->i64{
  if op==9{return 1;}if op==10{return 1;}if op==16{return 1;}if op==17{return 1;}if op==18{return 1;}return 0;
}
fn jj_i386a_node_size(cir:*i64,plan:*i64,value:i64)->i64{
  var cb:i64=jj_i386a_node_base(cir,value);if cb==0{return 0;}var op:i64=cir[cb];var store:i64=0;
  if jj_i386a_materialized(cir,plan,value)!=0{store=jj_i386a_loc_size(plan,value);if store==0{return 0;}}
  if op==1{return 12+store;}if op==2{return 10+store;}if jj_i386a_op_supported(op)==0{return 0;}
  var lhs:i64=jj_i386a_loc_size(plan,cir[cb+2]);var rhs:i64=jj_i386a_loc_size(plan,cir[cb+3]);if lhs==0{return 0;}if rhs==0{return 0;}
  return lhs+rhs+store;
}
fn jj_i386a_prologue_size(plan:*i64,saves:i64)->i64{
  var n:i64=3+jj_i386a_save_count(saves);if plan[5]!=0{n=n+6;}return n;
}
fn jj_i386a_epilogue_size(plan:*i64,saves:i64)->i64{
  var n:i64=2+jj_i386a_save_count(saves);if plan[5]!=0{n=n+6;}return n;
}
fn jj_i386a_v1_code_size(cir:*i64,plan:*i64,saves:i64)->i64{
  var count:i64=cir[2];if count<=0{return 0;}var size:i64=jj_i386a_prologue_size(plan,saves);var value:i64=1;
  while value<=count{var add:i64=jj_i386a_node_size(cir,plan,value);if add<=0{return 0;}if size>0x7fffffff-add{return 0;}size=size+add;value=value+1;}
  if cir[6]!=count{var load:i64=jj_i386a_loc_size(plan,cir[6]);if load==0{return 0;}if size>0x7fffffff-load{return 0;}size=size+load;}
  var tail:i64=jj_i386a_epilogue_size(plan,saves);if size>0x7fffffff-tail{return 0;}return size+tail;
}
fn jj_i386a_v2_layout(cir:*i64,plan:*i64,saves:i64,offsets:*i64)->i64{
  if offsets==0{return 0;}var blocks:i64=cir[2];if blocks<=0{return 0;}if blocks>64{return 0;}var size:i64=jj_i386a_prologue_size(plan,saves);var bi:i64=0;
  while bi<blocks{
    offsets[bi]=size;var bb:i64=12+bi*6;var first:i64=cir[bb];var count:i64=cir[bb+1];var value:i64=first;
    while value<first+count{var add:i64=jj_i386a_node_size(cir,plan,value);if add<=0{return 0;}if size>0x7fffffff-add{return 0;}size=size+add;value=value+1;}
    var term:i64=cir[bb+2];var tail:i64=0;
    if term==1{tail=jj_i386a_loc_size(plan,cir[bb+3])+jj_i386a_epilogue_size(plan,saves);}
    else{if term==2{tail=5;}else{if term==3{tail=jj_i386a_loc_size(plan,cir[bb+3])+13;}else{return 0;}}}
    if tail<=0{return 0;}if size>0x7fffffff-tail{return 0;}size=size+tail;bi=bi+1;
  }
  return size;
}
fn jj_i386a_code_size(cir:*i64,plan:*i64,saves:i64,offsets:*i64)->i64{
  if cir[1]==1{return jj_i386a_v1_code_size(cir,plan,saves);}if cir[1]==2{return jj_i386a_v2_layout(cir,plan,saves,offsets);}return 0;
}
fn jj_i386a_emit_prologue(st:*i64,plan:*i64,saves:i64)->i64{
  if jj_i386a_put8(st,0x55)==0{return 0;}if jj_i386a_put8(st,0x89)==0{return 0;}if jj_i386a_put8(st,0xe5)==0{return 0;}
  if (saves&1)!=0{if jj_i386a_put8(st,0x53)==0{return 0;}}
  if (saves&2)!=0{if jj_i386a_put8(st,0x56)==0{return 0;}}
  if (saves&4)!=0{if jj_i386a_put8(st,0x57)==0{return 0;}}
  if plan[5]!=0{if jj_i386a_put8(st,0x81)==0{return 0;}if jj_i386a_put8(st,0xec)==0{return 0;}if jj_i386a_put32(st,plan[5])==0{return 0;}}
  return 1;
}
fn jj_i386a_emit_epilogue(st:*i64,plan:*i64,saves:i64)->i64{
  if plan[5]!=0{if jj_i386a_put8(st,0x81)==0{return 0;}if jj_i386a_put8(st,0xc4)==0{return 0;}if jj_i386a_put32(st,plan[5])==0{return 0;}}
  if (saves&4)!=0{if jj_i386a_put8(st,0x5f)==0{return 0;}}
  if (saves&2)!=0{if jj_i386a_put8(st,0x5e)==0{return 0;}}
  if (saves&1)!=0{if jj_i386a_put8(st,0x5b)==0{return 0;}}
  if jj_i386a_put8(st,0x5d)==0{return 0;}return jj_i386a_put8(st,0xc3);
}
fn jj_i386a_emit_node(st:*i64,cir:*i64,plan:*i64,value:i64,saved:i64)->i64{
  var cb:i64=jj_i386a_node_base(cir,value);if cb==0{return 0;}var op:i64=cir[cb];
  if op==1{if jj_i386a_load_arg(st)==0{return 0;}}
  else{if op==2{if jj_i386a_constant(st,cir[cb+3])==0{return 0;}}
  else{if jj_i386a_op_supported(op)==0{return 0;}if jj_i386a_load(st,plan,cir[cb+2],saved)==0{return 0;}if jj_i386a_apply(st,plan,cir[cb+3],op,saved)==0{return 0;}}}
  if jj_i386a_materialized(cir,plan,value)!=0{return jj_i386a_store(st,plan,value,saved);}return 1;
}
fn jj_i386a_emit_v1(st:*i64,cir:*i64,plan:*i64,saves:i64)->i64{
  var saved:i64=jj_i386a_save_count(saves);var value:i64=1;while value<=cir[2]{if jj_i386a_emit_node(st,cir,plan,value,saved)==0{return 0;}value=value+1;}
  if cir[6]!=cir[2]{if jj_i386a_load(st,plan,cir[6],saved)==0{return 0;}}return jj_i386a_emit_epilogue(st,plan,saves);
}
fn jj_i386a_emit_rel32(st:*i64,target:i64,tail:i64)->i64{
  var current:i64=st[2]-64;if target<0{return 0;}return jj_i386a_put32(st,target-(current+tail));
}
fn jj_i386a_emit_v2(st:*i64,cir:*i64,plan:*i64,saves:i64,offsets:*i64)->i64{
  var saved:i64=jj_i386a_save_count(saves);var blocks:i64=cir[2];var bi:i64=0;
  while bi<blocks{
    if st[2]-64!=offsets[bi]{return 0;}var bb:i64=12+bi*6;var first:i64=cir[bb];var value:i64=first;
    while value<first+cir[bb+1]{if jj_i386a_emit_node(st,cir,plan,value,saved)==0{return 0;}value=value+1;}
    var term:i64=cir[bb+2];
    if term==1{if jj_i386a_load(st,plan,cir[bb+3],saved)==0{return 0;}if jj_i386a_emit_epilogue(st,plan,saves)==0{return 0;}}
    else{if term==2{if jj_i386a_put8(st,0xe9)==0{return 0;}if jj_i386a_emit_rel32(st,offsets[cir[bb+4]],4)==0{return 0;}}
    else{if term==3{
      if jj_i386a_load(st,plan,cir[bb+3],saved)==0{return 0;}if jj_i386a_put8(st,0x09)==0{return 0;}if jj_i386a_put8(st,0xd0)==0{return 0;}
      if jj_i386a_put8(st,0x0f)==0{return 0;}if jj_i386a_put8(st,0x84)==0{return 0;}if jj_i386a_emit_rel32(st,offsets[cir[bb+4]],4)==0{return 0;}
      if jj_i386a_put8(st,0xe9)==0{return 0;}if jj_i386a_emit_rel32(st,offsets[cir[bb+5]],4)==0{return 0;}
    }else{return 0;}}}
    bi=bi+1;
  }
  return 1;
}
fn jj_i386a_emit_code(out:*i8,cap:i64,cir:*i64,plan:*i64,code_size:i64,saves:i64)->i64{
  var st:[3]i64;var offsets:[64]i64;st[0]=out as i64;st[1]=cap;st[2]=64;
  if cir[1]==2{if jj_i386a_v2_layout(cir,plan,saves,offsets as *i64)!=code_size{return 0;}}
  if jj_i386a_emit_prologue(st as *i64,plan,saves)==0{return 0;}
  if cir[1]==1{if jj_i386a_emit_v1(st as *i64,cir,plan,saves)==0{return 0;}}
  else{if cir[1]==2{if jj_i386a_emit_v2(st as *i64,cir,plan,saves,offsets as *i64)==0{return 0;}}else{return 0;}}
  if st[2]!=64+code_size{return 0;}return 1;
}
fn jj_i386a_write_name(out:*i8,cap:i64,at:i64)->i64{
  var name:[15]i64;name[0]=106;name[1]=106;name[2]=95;name[3]=97;name[4]=108;name[5]=108;name[6]=111;name[7]=99;name[8]=95;name[9]=112;name[10]=114;name[11]=111;name[12]=98;name[13]=101;name[14]=0;
  var i:i64=0;while i<15{if jj_sink_write8_at(out,cap,at+i,name[i])==0{return 0;}i=i+1;}return 1;
}
fn jj_i386a_shstr(out:*i8,cap:i64,at:i64)->i64{
  var s:[50]i64;s[0]=0;s[1]=46;s[2]=116;s[3]=101;s[4]=120;s[5]=116;s[6]=0;s[7]=46;s[8]=114;s[9]=101;s[10]=108;s[11]=46;s[12]=116;s[13]=101;s[14]=120;s[15]=116;s[16]=0;s[17]=46;s[18]=115;s[19]=121;s[20]=109;s[21]=116;s[22]=97;s[23]=98;s[24]=0;s[25]=46;s[26]=115;s[27]=116;s[28]=114;s[29]=116;s[30]=97;s[31]=98;s[32]=0;s[33]=46;s[34]=111;s[35]=109;s[36]=101;s[37]=103;s[38]=97;s[39]=0;s[40]=46;s[41]=115;s[42]=104;s[43]=115;s[44]=116;s[45]=114;s[46]=116;s[47]=97;s[48]=98;s[49]=0;
  var i:i64=0;while i<50{if jj_sink_write8_at(out,cap,at+i,s[i])==0{return 0;}i=i+1;}return 1;
}
fn jj_i386a_section(out:*i8,cap:i64,at:i64,d:*i64)->i64{
  var i:i64=0;while i<10{if jj_i386a_write32(out,cap,at+i*4,d[i])==0{return 0;}i=i+1;}return 1;
}
fn jj_i386a_digest(out:*i8,omega:i64,profile:i64)->i64{
  var h:i64=jj_c_hash_bytes(out,64,omega-64)^profile^0x4a4a49334d4f4431;h=((h<<11)|(h>>>53))^0;h=((h<<13)|(h>>>51))^1;h=((h<<17)|(h>>>47))^0;
  if h==0{h=0x4a4a49334d4f4431;}return h;
}
fn jj_target_emit_i386_allocated(context:*i64)->i64{
  if context==0{return 0;}var out:*i8=context[0] as *i8;var capacity:i64=context[1];var view:*i64=context[2] as *i64;
  var profile:*i64=context[3] as *i64;var profile_slots:i64=context[4];var plan:*i64=context[5] as *i64;var plan_slots:i64=context[6];
  if out==0{return 0;}if view==0{return 0;}if profile==0{return 0;}if plan==0{return 0;}if profile_slots!=32{return 0;}
  if jj_cir_view_valid(view)==0{return 0;}var cir:*i64=view[0] as *i64;var cir_slots:i64=view[1];if jj_cir_validate(cir,cir_slots)==0{return 0;}
  if jj_target_profile_validate(profile,profile_slots)==0{return 0;}if profile[2]!=8{return 0;}
  if jj_target_allocator_validate_for(cir,cir_slots,profile,profile_slots,plan,plan_slots)==0{return 0;}
  var saves:i64=jj_i386a_save_mask(cir,plan);if saves<0{return 0;}var offsets:[64]i64;var code_size:i64=jj_i386a_code_size(cir,plan,saves,offsets as *i64);if code_size<=0{return 0;}
  var rel:i64=jj_i386a_align(64+code_size,4);if rel<0{return 0;}var sym:i64=rel;var sym_size:i64=48;var str:i64=sym+sym_size;var str_size:i64=16;
  var omega:i64=jj_i386a_align(str+str_size,8);if omega<0{return 0;}var shstr:i64=omega+56;var shoff:i64=jj_i386a_align(shstr+50,4);if shoff<0{return 0;}
  var total:i64=shoff+280;if total<=shoff{return 0;}if capacity<total{return 0;}
  var cir_bytes:i64=jj_i386a_slot_bytes(cir_slots);var profile_bytes:i64=jj_i386a_slot_bytes(profile_slots);var plan_bytes:i64=jj_i386a_slot_bytes(plan_slots);
  if cir_bytes==0{return 0;}if profile_bytes==0{return 0;}if plan_bytes==0{return 0;}
  if jj_i386a_nonoverlap(out as i64,total,context as i64,56)==0{return 0;}if jj_i386a_nonoverlap(out as i64,total,view as i64,32)==0{return 0;}
  if jj_i386a_nonoverlap(out as i64,total,cir as i64,cir_bytes)==0{return 0;}if jj_i386a_nonoverlap(out as i64,total,profile as i64,profile_bytes)==0{return 0;}
  if jj_i386a_nonoverlap(out as i64,total,plan as i64,plan_bytes)==0{return 0;}if jj_i386a_nonoverlap(context as i64,56,view as i64,32)==0{return 0;}
  if jj_i386a_nonoverlap(context as i64,56,cir as i64,cir_bytes)==0{return 0;}if jj_i386a_nonoverlap(context as i64,56,profile as i64,profile_bytes)==0{return 0;}
  if jj_i386a_nonoverlap(context as i64,56,plan as i64,plan_bytes)==0{return 0;}if jj_i386a_nonoverlap(view as i64,32,cir as i64,cir_bytes)==0{return 0;}
  if jj_i386a_nonoverlap(view as i64,32,profile as i64,profile_bytes)==0{return 0;}if jj_i386a_nonoverlap(view as i64,32,plan as i64,plan_bytes)==0{return 0;}
  if jj_i386a_nonoverlap(cir as i64,cir_bytes,profile as i64,profile_bytes)==0{return 0;}if jj_i386a_nonoverlap(cir as i64,cir_bytes,plan as i64,plan_bytes)==0{return 0;}
  if jj_i386a_nonoverlap(profile as i64,profile_bytes,plan as i64,plan_bytes)==0{return 0;}if jj_i386a_zero(out,capacity,total)==0{return 0;}
  out[0]=0x7f;out[1]=69;out[2]=76;out[3]=70;out[4]=1;out[5]=1;out[6]=1;
  if jj_i386a_put16(out,capacity,16,1)==0{return 0;}if jj_i386a_put16(out,capacity,18,3)==0{return 0;}if jj_i386a_write32(out,capacity,20,1)==0{return 0;}
  if jj_i386a_write32(out,capacity,32,shoff)==0{return 0;}if jj_i386a_put16(out,capacity,40,52)==0{return 0;}if jj_i386a_put16(out,capacity,46,40)==0{return 0;}
  if jj_i386a_put16(out,capacity,48,7)==0{return 0;}if jj_i386a_put16(out,capacity,50,6)==0{return 0;}
  if jj_i386a_emit_code(out,capacity,cir,plan,code_size,saves)==0{return 0;}
  out[sym+16+12]=3;if jj_i386a_put16(out,capacity,sym+30,1)==0{return 0;}if jj_i386a_write32(out,capacity,sym+32,1)==0{return 0;}
  if jj_i386a_write32(out,capacity,sym+36,0)==0{return 0;}if jj_i386a_write32(out,capacity,sym+40,code_size)==0{return 0;}out[sym+44]=0x12;
  if jj_i386a_put16(out,capacity,sym+46,1)==0{return 0;}out[str]=0;if jj_i386a_write_name(out,capacity,str+1)==0{return 0;}
  if jj_i386a_write32(out,capacity,omega,0x4f4d4547)==0{return 0;}if jj_i386a_write32(out,capacity,omega+4,0x41333836)==0{return 0;}
  var digest:i64=jj_i386a_digest(out,omega,profile[31]);var text_hash:i64=jj_c_hash_bytes(out,64,code_size);var vals:[6]i64;
  vals[0]=profile[31];vals[1]=digest;vals[2]=text_hash;vals[3]=0;vals[4]=1;vals[5]=0;var vi:i64=0;
  while vi<6{if jj_i386a_write32(out,capacity,omega+8+vi*8,vals[vi])==0{return 0;}if jj_i386a_write32(out,capacity,omega+12+vi*8,vals[vi]>>>32)==0{return 0;}vi=vi+1;}
  if jj_i386a_shstr(out,capacity,shstr)==0{return 0;}var d:[10]i64;var sh:i64=shoff+40;
  d[0]=1;d[1]=1;d[2]=6;d[3]=0;d[4]=64;d[5]=code_size;d[6]=0;d[7]=0;d[8]=16;d[9]=0;if jj_i386a_section(out,capacity,sh,d as *i64)==0{return 0;}
  sh=sh+40;d[0]=7;d[1]=9;d[2]=0;d[3]=0;d[4]=rel;d[5]=0;d[6]=3;d[7]=1;d[8]=4;d[9]=8;if jj_i386a_section(out,capacity,sh,d as *i64)==0{return 0;}
  sh=sh+40;d[0]=17;d[1]=2;d[4]=sym;d[5]=sym_size;d[6]=4;d[7]=2;d[8]=4;d[9]=16;if jj_i386a_section(out,capacity,sh,d as *i64)==0{return 0;}
  sh=sh+40;d[0]=25;d[1]=3;d[4]=str;d[5]=str_size;d[6]=0;d[7]=0;d[8]=1;d[9]=0;if jj_i386a_section(out,capacity,sh,d as *i64)==0{return 0;}
  sh=sh+40;d[0]=33;d[1]=1;d[4]=omega;d[5]=56;d[8]=8;if jj_i386a_section(out,capacity,sh,d as *i64)==0{return 0;}
  sh=sh+40;d[0]=40;d[1]=3;d[4]=shstr;d[5]=50;d[8]=1;if jj_i386a_section(out,capacity,sh,d as *i64)==0{return 0;}
  if jj_target_i386_module_validate(out,total,profile[31],digest)==0{return 0;}return total;
}
fn jj_i386_allocator_object_resource_contract(out:*i64,slots:i64)->i64{
  if out==0{return 0;}if slots!=8{return 0;}out[0]=256;out[1]=256;out[2]=0;out[3]=2;out[4]=0;out[5]=1;out[6]=1;out[7]=(out as i64)^0x4a4a4933414c4c50;return 1;
}
