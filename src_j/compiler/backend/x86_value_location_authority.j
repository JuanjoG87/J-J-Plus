// R757 x86 scalar value-location authority with sealed variable instruction layout.
// A bounded binary result may be written directly to its spill slot by using
// x86 memory-destination ALU forms; no scratch lane or hidden reload register is
// introduced.
// Unsupported plans fall back before bytes are emitted. The admitted path uses
// four allocator lanes and direct frame memory operands; no hidden scratch
// register is introduced to disguise pressure.
extern fn jj_cir_begin(p0:*i64,p1:i64,p2:i64,p3:i64)->i64;
extern fn jj_cir_add_argument(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_cir_add_constant(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_cir_add_binary(p0:*i64,p1:i64,p2:i64,p3:i64,p4:i64)->i64;
extern fn jj_cir_finish(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_cir_validate(p0:*i64,p1:i64)->i64;
extern fn jj_target_profile_build(p0:i64,p1:*i64,p2:i64)->i64;
extern fn jj_target_allocator_build(p0:*i64,p1:i64,p2:*i64,p3:i64,p4:*i64,p5:i64)->i64;
extern fn jj_target_allocator_validate_for(p0:*i64,p1:i64,p2:*i64,p3:i64,p4:*i64,p5:i64)->i64;
extern fn jj_target_allocator_value_kind(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_target_allocator_value_index(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_target_allocator_spill_count(p0:*i64,p1:i64)->i64;
extern fn jj_target_allocator_frame_bytes(p0:*i64,p1:i64)->i64;
extern fn jj_n_e8(p0:*i64,p1:i64)->i64;
extern fn jj_n_e32(p0:*i64,p1:i64)->i64;
extern fn jj_n_e64(p0:*i64,p1:i64)->i64;

fn jj_xvl_rd16(p:*i8)->i64{return (p[0]&255)|((p[1]&255)<<8);}
fn jj_xvl_rd64(p:*i8)->i64{var v:i64=0;var i:i64=0;while i<8{v=v|((p[i]&255)<<(i*8));i=i+1;}return v;}
fn jj_xvl_supported_binary(op:i64)->i64{if op==9{return 1;}if op==10{return 1;}if op==11{return 1;}if op==16{return 1;}if op==17{return 1;}if op==18{return 1;}return 0;}
fn jj_xvl_code_hash(program:*i8,start:i64,end:i64)->i64{if program==0{return 0;}if start<0{return 0;}if end<=start{return 0;}var h:i64=0x4a4a58564c434f44^start^(end<<1);var pc:i64=start;while pc<end{h=((h<<7)|(h>>>57))^(program[pc]&255)^pc;pc=pc+1;}if h==0{return 1;}return h;}
fn jj_xvl_candidate(program:*i8,start:i64,end:i64,argc:i64,locals:i64)->i64{
  if program==0{return 0;}if start<0{return 0;}if end<=start{return 0;}if argc<0{return 0;}if argc>1{return 0;}if locals<argc{return 0;}if locals>64{return 0;}var pc:i64=start;var binaries:i64=0;var returns:i64=0;var values:i64=argc;var operations:i64=0;
  while pc<end{operations=operations+1;if operations>127{return 0;}var op:i64=program[pc]&255;if op==1{if pc+9>end{return 0;}values=values+1;if values>127{return 0;}pc=pc+9;}else{if op==2{if pc+3>end{return 0;}pc=pc+3;}else{if op==3{if pc+3>end{return 0;}pc=pc+3;}else{if jj_xvl_supported_binary(op)!=0{binaries=binaries+1;values=values+1;if values>127{return 0;}pc=pc+1;}else{if op==31{pc=pc+1;}else{if op==30{returns=returns+1;pc=pc+1;if pc!=end{return 0;}}else{return 0;}}}}}}}
  if pc!=end{return 0;}if binaries<=0{return 0;}if returns!=1{return 0;}return 1;
}
fn jj_xvl_zero(ctx:*i64)->i64{if ctx==0{return 0;}var i:i64=0;while i<1816{ctx[i]=0;i=i+1;}return 1;}
fn jj_xvl_fail(ctx:*i64)->i64{jj_xvl_zero(ctx);return 0;}
fn jj_xvl_profile(ctx:*i64)->*i64{return ((ctx as i64)+16*8) as *i64;}
fn jj_xvl_cir(ctx:*i64)->*i64{return ((ctx as i64)+48*8) as *i64;}
fn jj_xvl_plan(ctx:*i64)->*i64{return ((ctx as i64)+560*8) as *i64;}
fn jj_xvl_env(ctx:*i64)->*i64{return ((ctx as i64)+1232*8) as *i64;}
fn jj_xvl_stack(ctx:*i64)->*i64{return ((ctx as i64)+1296*8) as *i64;}
fn jj_xvl_materialized(ctx:*i64)->*i64{return ((ctx as i64)+1552*8) as *i64;}
fn jj_xvl_layout(ctx:*i64)->*i64{return ((ctx as i64)+1680*8) as *i64;}
fn jj_xvl_node_base(cir:*i64,value:i64)->i64{if cir==0{return 0;}if value<=0{return 0;}if value>cir[2]{return 0;}return 8+(value-1)*4;}
fn jj_xvl_signed32(value:i64)->i64{if value<0-2147483648{return 0;}if value>2147483647{return 0;}return 1;}
fn jj_xvl_binary_spill_ok(plan:*i64,key:i64)->i64{
  if plan==0{return 0;}var op:i64=key&255;var dst:i64=(key>>>8)&255;var lhs:i64=(key>>>16)&255;var rhs:i64=(key>>>24)&255;if jj_xvl_supported_binary(op)==0{return 0;}if op==11{return 0;}if jj_target_allocator_value_kind(plan,672,dst)!=2{return 0;}if jj_target_allocator_value_kind(plan,672,lhs)!=1{return 0;}if jj_target_allocator_value_kind(plan,672,rhs)!=1{return 0;}var di:i64=jj_target_allocator_value_index(plan,672,dst);var ll:i64=jj_target_allocator_value_index(plan,672,lhs);var rl:i64=jj_target_allocator_value_index(plan,672,rhs);if di<0{return 0;}if di>=plan[4]{return 0;}if ll<0{return 0;}if ll>3{return 0;}if rl<0{return 0;}if rl>3{return 0;}return 1;
}
fn jj_xvl_binary_plan_ok(plan:*i64,op:i64,dst:i64,lhs:i64,rhs:i64)->i64{
  if plan==0{return 0;}if jj_xvl_supported_binary(op)==0{return 0;}var dk:i64=jj_target_allocator_value_kind(plan,672,dst);if dk==2{return jj_xvl_binary_spill_ok(plan,op|(dst<<8)|(lhs<<16)|(rhs<<24));}var lk:i64=jj_target_allocator_value_kind(plan,672,lhs);var rk:i64=jj_target_allocator_value_kind(plan,672,rhs);if dk!=1{return 0;}if lk<1{return 0;}if lk>2{return 0;}if rk<1{return 0;}if rk>2{return 0;}if lk==2{if rk==2{return 0;}}var dl:i64=jj_target_allocator_value_index(plan,672,dst);var ll:i64=jj_target_allocator_value_index(plan,672,lhs);var rl:i64=jj_target_allocator_value_index(plan,672,rhs);if dl<0{return 0;}if dl>3{return 0;}
  if lk==1{if dl==ll{return 1;}}
  if op!=10{if rk==1{if dl==rl{return 1;}}}
  if lk==1{if rk==1{return 1;}}
  return 0;
}
fn jj_xvl_plan_receipts(cir:*i64,plan:*i64,out:*i64)->i64{
  if cir==0{return 0;}if plan==0{return 0;}if out==0{return 0;}var stores:i64=0;var reads:i64=0;var value:i64=1;
  while value<=plan[1]{var kind:i64=jj_target_allocator_value_kind(plan,672,value);var index:i64=jj_target_allocator_value_index(plan,672,value);if kind==1{if index<0{return 0;}if index>3{return 0;}}else{if kind==2{if index<0{return 0;}if index>=plan[4]{return 0;}var nb:i64=jj_xvl_node_base(cir,value);if nb==0{return 0;}var nop:i64=cir[nb];if nop==2{if jj_xvl_signed32(cir[nb+3])==0{return 0;}}else{if jj_xvl_supported_binary(nop)==0{return 0;}if jj_xvl_binary_spill_ok(plan,nop|(value<<8)|(cir[nb+2]<<16)|(cir[nb+3]<<24))==0{return 0;}}if plan[12+(value-1)*5]<=value{return 0;}stores=stores+1;}else{return 0;}}value=value+1;}
  value=1;while value<=plan[1]{var base:i64=jj_xvl_node_base(cir,value);if base==0{return 0;}var op:i64=cir[base];if jj_xvl_supported_binary(op)!=0{var lhs:i64=cir[base+2];var rhs:i64=cir[base+3];if jj_xvl_binary_plan_ok(plan,op,value,lhs,rhs)==0{return 0;}if jj_target_allocator_value_kind(plan,672,lhs)==2{reads=reads+1;}if jj_target_allocator_value_kind(plan,672,rhs)==2{reads=reads+1;}}value=value+1;}
  if plan[4]>0{if stores<=0{return 0;}if reads<=0{return 0;}}out[0]=stores;out[1]=reads;return 1;
}
fn jj_xvl_binary_regs_size(op:i64,dst:i64,lhs:i64,rhs:i64)->i64{
  if jj_xvl_supported_binary(op)==0{return 0;}if dst==lhs{if op==11{return 4;}return 3;}if op!=10{if dst==rhs{if op==11{return 4;}return 3;}if op==11{return 7;}return 6;}if dst==rhs{if lhs==rhs{return 3;}return 6;}return 6;
}
fn jj_xvl_binary_size(ctx:*i64,op:i64,dst:i64,lhs:i64,rhs:i64)->i64{
  if ctx==0{return 0;}var plan:*i64=jj_xvl_plan(ctx);if jj_xvl_binary_plan_ok(plan,op,dst,lhs,rhs)==0{return 0;}var dk:i64=jj_target_allocator_value_kind(plan,672,dst);if dk==2{return 8;}var lk:i64=jj_target_allocator_value_kind(plan,672,lhs);var rk:i64=jj_target_allocator_value_kind(plan,672,rhs);var dl:i64=jj_target_allocator_value_index(plan,672,dst);var ll:i64=jj_target_allocator_value_index(plan,672,lhs);var rl:i64=jj_target_allocator_value_index(plan,672,rhs);if lk==1{if rk==1{return jj_xvl_binary_regs_size(op,dl,ll,rl);}if dl!=ll{return 0;}if op==11{return 5;}return 4;}if rk!=1{return 0;}if op==10{return 0;}if dl!=rl{return 0;}if op==11{return 5;}return 4;
}
fn jj_xvl_layout_seal(ctx:*i64)->i64{if ctx==0{return 0;}var layout:*i64=jj_xvl_layout(ctx);if layout[1]<1{return 0;}if layout[1]>127{return 0;}var h:i64=(layout as i64)^0x4a4a584c41595331^layout[0]^layout[1]^layout[2]^layout[3]^layout[4]^layout[5]^layout[6];var i:i64=0;while i<layout[1]{h=((h<<7)|(h>>>57))^layout[8+i]^i;i=i+1;}if h==0{return 1;}return h;}
fn jj_xvl_layout_valid(ctx:*i64)->i64{if ctx==0{return 0;}var layout:*i64=jj_xvl_layout(ctx);if layout[0]!=0x4a4a584c41593031{return 0;}if layout[1]<1{return 0;}if layout[1]>127{return 0;}if layout[2]<=0{return 0;}if layout[2]>0xffffffff{return 0;}if layout[3]!=ctx[9]{return 0;}if layout[4]!=jj_xvl_plan(ctx)[11]{return 0;}if layout[5]!=ctx[4]{return 0;}if layout[6]!=ctx[5]{return 0;}var previous:i64=0-1;var previous_pc:i64=ctx[4]-1;var i:i64=0;while i<layout[1]{var entry:i64=layout[8+i];var pc:i64=entry&0xffffffff;var offset:i64=(entry>>>32)&0xffffffff;if pc<ctx[4]{return 0;}if pc>=ctx[5]{return 0;}if pc<=previous_pc{return 0;}if offset<previous{return 0;}if i==0{if offset!=0{return 0;}}previous_pc=pc;previous=offset;i=i+1;}if layout[7]!=jj_xvl_layout_seal(ctx){return 0;}return 1;}
fn jj_xvl_layout_build(ctx:*i64,program:*i8,start:i64,end:i64)->i64{
  if ctx==0{return 0;}if program==0{return 0;}var layout:*i64=jj_xvl_layout(ctx);var z:i64=0;while z<136{layout[z]=0;z=z+1;}var env:*i64=jj_xvl_env(ctx);var stack:*i64=jj_xvl_stack(ctx);var materialized:*i64=jj_xvl_materialized(ctx);z=0;while z<64{env[z]=0;z=z+1;}z=0;while z<256{stack[z]=0;z=z+1;}z=0;while z<128{materialized[z]=0;z=z+1;}
  var next_value:i64=1;if ctx[2]==1{env[0]=1;next_value=2;}var depth:i64=0;var pc:i64=start;var offset:i64=0;var count:i64=0;var returned:i64=0;var plan:*i64=jj_xvl_plan(ctx);
  while pc<end{if count>=127{return 0;}layout[8+count]=(pc&0xffffffff)|((offset&0xffffffff)<<32);count=count+1;var op:i64=program[pc]&255;var size:i64=0;
    if op==1{var cv:i64=next_value;next_value=next_value+1;var ck:i64=jj_target_allocator_value_kind(plan,672,cv);if ck==1{size=10;}else{if ck==2{if jj_xvl_signed32(jj_xvl_rd64(program+pc+1))==0{return 0;}size=8;}else{return 0;}}materialized[cv]=1;stack[depth]=cv;depth=depth+1;pc=pc+9;}
    else{if op==2{var ls:i64=jj_xvl_rd16(program+pc+1);var lv:i64=env[ls];if lv<=0{return 0;}if materialized[lv]==0{if lv!=1{return 0;}if ctx[2]!=1{return 0;}if jj_target_allocator_value_kind(plan,672,lv)!=1{return 0;}materialized[lv]=1;size=4;}stack[depth]=lv;depth=depth+1;pc=pc+3;}
    else{if op==3{if depth<=0{return 0;}depth=depth-1;env[jj_xvl_rd16(program+pc+1)]=stack[depth];pc=pc+3;}
    else{if jj_xvl_supported_binary(op)!=0{if depth<2{return 0;}var rhs:i64=stack[depth-1];var lhs:i64=stack[depth-2];depth=depth-2;var dst:i64=next_value;next_value=next_value+1;if materialized[lhs]==0{return 0;}if materialized[rhs]==0{return 0;}size=jj_xvl_binary_size(ctx,op,dst,lhs,rhs);if size<=0{return 0;}materialized[dst]=1;stack[depth]=dst;depth=depth+1;pc=pc+1;}
    else{if op==31{if depth<=0{return 0;}depth=depth-1;pc=pc+1;}
    else{if op==30{if depth!=1{return 0;}if stack[0]!=ctx[6]{return 0;}depth=0;returned=1;size=2;pc=pc+1;}
    else{return 0;}}}}}}
    if offset>0xffffffff-size{return 0;}offset=offset+size;
  }
  if pc!=end{return 0;}if returned!=1{return 0;}if next_value-1!=ctx[7]{return 0;}layout[0]=0x4a4a584c41593031;layout[1]=count;layout[2]=offset;layout[3]=ctx[9];layout[4]=plan[11];layout[5]=start;layout[6]=end;layout[7]=jj_xvl_layout_seal(ctx);return jj_xvl_layout_valid(ctx);
}
fn jj_xvl_seal(ctx:*i64)->i64{
  if ctx==0{return 0;}var cir:*i64=jj_xvl_cir(ctx);var plan:*i64=jj_xvl_plan(ctx);
  var h:i64=0x4a4a58564c523737^ctx[2]^(ctx[3]<<8)^ctx[4]^(ctx[5]<<1)^ctx[6]^(ctx[7]<<17)^ctx[9]^ctx[10]^(ctx[11]<<7)^(ctx[12]<<19)^(ctx[13]<<31)^ctx[14]^(ctx[15]<<43)^cir[7]^plan[11]^jj_xvl_layout(ctx)[7];
  if h==0{return 1;}return h;
}
fn jj_xvl_validate(ctx:*i64)->i64{
  if ctx==0{return 0;}if ctx[0]!=0x4a4a58564c523737{return 0;}if ctx[1]!=4{return 0;}if ctx[2]<0{return 0;}if ctx[2]>1{return 0;}if ctx[3]<ctx[2]{return 0;}if ctx[3]>64{return 0;}if ctx[4]>=ctx[5]{return 0;}
  var profile:*i64=jj_xvl_profile(ctx);var cir:*i64=jj_xvl_cir(ctx);var plan:*i64=jj_xvl_plan(ctx);if jj_cir_validate(cir,512)==0{return 0;}if jj_target_allocator_validate_for(cir,512,profile,32,plan,672)==0{return 0;}
  var spills:i64=jj_target_allocator_spill_count(plan,672);if spills<0{return 0;}if spills>16-ctx[2]{return 0;}if ctx[10]!=spills{return 0;}if ctx[11]!=ctx[2]+spills+1{return 0;}if ctx[14]!=ctx[2]{return 0;}if ctx[15]!=16{return 0;}if jj_target_allocator_frame_bytes(plan,672)!=((spills*8+15)&(0-16)){return 0;}
  if ctx[6]<=0{return 0;}if ctx[6]>plan[1]{return 0;}if ctx[7]<=0{return 0;}if ctx[7]>127{return 0;}if jj_target_allocator_value_kind(plan,672,ctx[6])!=1{return 0;}if jj_target_allocator_value_index(plan,672,ctx[6])!=0{return 0;}
  var receipt:*i64=jj_xvl_env(ctx);if jj_xvl_plan_receipts(cir,plan,receipt)==0{return 0;}if ctx[12]!=receipt[0]{return 0;}if ctx[13]!=receipt[1]{return 0;}if jj_xvl_layout_valid(ctx)==0{return 0;}if ctx[8]!=jj_xvl_seal(ctx){return 0;}return 1;
}

fn jj_xvl_layout_receipt(ctx:*i64)->i64{if jj_xvl_validate(ctx)==0{return 0;}return jj_xvl_layout(ctx)[7];}
fn jj_xvl_body_size(ctx:*i64)->i64{if jj_xvl_validate(ctx)==0{return 0;}return jj_xvl_layout(ctx)[2];}
fn jj_xvl_offset_for_pc(ctx:*i64,target:i64)->i64{if jj_xvl_validate(ctx)==0{return 0-1;}if target<ctx[4]{return 0-1;}if target>ctx[5]{return 0-1;}var base:i64=11+ctx[2]*7;var layout:*i64=jj_xvl_layout(ctx);if target==ctx[5]{return base+layout[2];}var lo:i64=0;var hi:i64=layout[1];while lo<hi{var mid:i64=(lo+hi)>>1;var pc:i64=layout[8+mid]&0xffffffff;if pc<target{lo=mid+1;}else{hi=mid;}}if lo>=layout[1]{return 0-1;}var entry:i64=layout[8+lo];if (entry&0xffffffff)!=target{return 0-1;}return base+((entry>>>32)&0xffffffff);}

fn jj_xvl_prepare(program:*i8,start:i64,end:i64,argc:i64,locals:i64,ctx:*i64)->i64{
  if program==0{return 0;}if ctx==0{return 0;}if jj_xvl_candidate(program,start,end,argc,locals)==0{return 0;}if jj_xvl_zero(ctx)==0{return 0;}
  var profile:*i64=jj_xvl_profile(ctx);var cir:*i64=jj_xvl_cir(ctx);var plan:*i64=jj_xvl_plan(ctx);var env:*i64=jj_xvl_env(ctx);var stack:*i64=jj_xvl_stack(ctx);
  if jj_target_profile_build(5,profile,32)==0{return jj_xvl_fail(ctx);}if profile[22]!=4{return jj_xvl_fail(ctx);}if jj_cir_begin(cir,512,argc,1)==0{return jj_xvl_fail(ctx);}
  var next_value:i64=1;if argc==1{var av:i64=jj_cir_add_argument(cir,512,0);if av!=1{return jj_xvl_fail(ctx);}env[0]=av;next_value=2;}
  var depth:i64=0;var pc:i64=start;var result:i64=0;var returns:i64=0;var binaries:i64=0;
  while pc<end{
    var op:i64=program[pc]&255;
    if op==1{if pc+9>end{return jj_xvl_fail(ctx);}if depth>=256{return jj_xvl_fail(ctx);}var cv:i64=jj_cir_add_constant(cir,512,jj_xvl_rd64(program+pc+1));if cv!=next_value{return jj_xvl_fail(ctx);}stack[depth]=cv;depth=depth+1;next_value=next_value+1;pc=pc+9;}
    else{if op==2{if pc+3>end{return jj_xvl_fail(ctx);}var ls:i64=jj_xvl_rd16(program+pc+1);if ls>=locals{return jj_xvl_fail(ctx);}if env[ls]<=0{return jj_xvl_fail(ctx);}if depth>=256{return jj_xvl_fail(ctx);}stack[depth]=env[ls];depth=depth+1;pc=pc+3;}
    else{if op==3{if pc+3>end{return jj_xvl_fail(ctx);}var ss:i64=jj_xvl_rd16(program+pc+1);if ss>=locals{return jj_xvl_fail(ctx);}if depth<=0{return jj_xvl_fail(ctx);}depth=depth-1;env[ss]=stack[depth];pc=pc+3;}
    else{if jj_xvl_supported_binary(op)!=0{if depth<2{return jj_xvl_fail(ctx);}var rhs:i64=stack[depth-1];var lhs:i64=stack[depth-2];depth=depth-2;var bv:i64=jj_cir_add_binary(cir,512,op,lhs,rhs);if bv!=next_value{return jj_xvl_fail(ctx);}stack[depth]=bv;depth=depth+1;next_value=next_value+1;binaries=binaries+1;pc=pc+1;}
    else{if op==31{if depth<=0{return jj_xvl_fail(ctx);}depth=depth-1;pc=pc+1;}
    else{if op==30{if depth!=1{return jj_xvl_fail(ctx);}result=stack[0];depth=0;returns=returns+1;pc=pc+1;if pc!=end{return jj_xvl_fail(ctx);}}
    else{return jj_xvl_fail(ctx);}}}}}}
  }
  if pc!=end{return jj_xvl_fail(ctx);}if returns!=1{return jj_xvl_fail(ctx);}if binaries<=0{return jj_xvl_fail(ctx);}if jj_cir_finish(cir,512,result)==0{return jj_xvl_fail(ctx);}
  if jj_target_allocator_build(cir,512,profile,32,plan,672)==0{return jj_xvl_fail(ctx);}if plan[1]>127{return jj_xvl_fail(ctx);}if jj_target_allocator_validate_for(cir,512,profile,32,plan,672)==0{return jj_xvl_fail(ctx);}var spills:i64=jj_target_allocator_spill_count(plan,672);if spills<0{return jj_xvl_fail(ctx);}if spills>16-argc{return jj_xvl_fail(ctx);}if jj_target_allocator_value_kind(plan,672,result)!=1{return jj_xvl_fail(ctx);}if jj_target_allocator_value_index(plan,672,result)!=0{return jj_xvl_fail(ctx);}
  if jj_xvl_plan_receipts(cir,plan,env)==0{return jj_xvl_fail(ctx);}
  var stores:i64=env[0];var reads:i64=env[1];ctx[0]=0x4a4a58564c523737;ctx[1]=4;ctx[2]=argc;ctx[3]=locals;ctx[4]=start;ctx[5]=end;ctx[6]=result;ctx[7]=plan[1];ctx[9]=jj_xvl_code_hash(program,start,end);ctx[10]=spills;ctx[11]=argc+spills+1;ctx[12]=stores;ctx[13]=reads;ctx[14]=argc;ctx[15]=16;if ctx[9]==0{return jj_xvl_fail(ctx);}if jj_xvl_layout_build(ctx,program,start,end)==0{return jj_xvl_fail(ctx);}ctx[8]=jj_xvl_seal(ctx);if ctx[8]==0{return jj_xvl_fail(ctx);}if jj_xvl_validate(ctx)==0{return jj_xvl_fail(ctx);}return 1;
}

fn jj_xvl_frame_bytes(ctx:*i64)->i64{if jj_xvl_validate(ctx)==0{return 0;}var bytes:i64=ctx[11]*8;return (bytes+15)&(0-16);}
fn jj_xvl_nops(state:*i64,count:i64)->i64{if count<0{return 0;}var i:i64=0;while i<count{if jj_n_e8(state,0x90)==0{return 0;}i=i+1;}return 1;}
fn jj_xvl_reg_code(lane:i64)->i64{if lane==0{return 0;}if lane==1{return 1;}if lane==2{return 2;}if lane==3{return 8;}return 0-1;}
fn jj_xvl_spill_slot(ctx:*i64,index:i64)->i64{if ctx==0{return 0-1;}if index<0{return 0-1;}if index>=ctx[10]{return 0-1;}var slot:i64=ctx[14]+index;if slot<0{return 0-1;}if slot>=16{return 0-1;}return slot;}
fn jj_xvl_spill_disp(ctx:*i64,index:i64)->i64{var slot:i64=jj_xvl_spill_slot(ctx,index);if slot<0{return 0;}var disp:i64=0-((slot+1)*8);if disp<0-128{return 0;}if disp>0-1{return 0;}return disp;}
fn jj_xvl_emit_mov(state:*i64,dst_lane:i64,src_lane:i64)->i64{
  var d:i64=jj_xvl_reg_code(dst_lane);var s:i64=jj_xvl_reg_code(src_lane);if d<0{return 0;}if s<0{return 0;}var rex:i64=0x48;if s>=8{rex=rex|4;}if d>=8{rex=rex|1;}if jj_n_e8(state,rex)==0{return 0;}if jj_n_e8(state,0x89)==0{return 0;}return jj_n_e8(state,0xc0|((s&7)<<3)|(d&7));
}
fn jj_xvl_emit_simple(state:*i64,opcode:i64,dst_lane:i64,src_lane:i64)->i64{
  var d:i64=jj_xvl_reg_code(dst_lane);var s:i64=jj_xvl_reg_code(src_lane);if d<0{return 0;}if s<0{return 0;}var rex:i64=0x48;if s>=8{rex=rex|4;}if d>=8{rex=rex|1;}if jj_n_e8(state,rex)==0{return 0;}if jj_n_e8(state,opcode)==0{return 0;}return jj_n_e8(state,0xc0|((s&7)<<3)|(d&7));
}
fn jj_xvl_emit_imul(state:*i64,dst_lane:i64,src_lane:i64)->i64{
  var d:i64=jj_xvl_reg_code(dst_lane);var s:i64=jj_xvl_reg_code(src_lane);if d<0{return 0;}if s<0{return 0;}var rex:i64=0x48;if d>=8{rex=rex|4;}if s>=8{rex=rex|1;}if jj_n_e8(state,rex)==0{return 0;}if jj_n_e8(state,0x0f)==0{return 0;}if jj_n_e8(state,0xaf)==0{return 0;}return jj_n_e8(state,0xc0|((d&7)<<3)|(s&7));
}
fn jj_xvl_emit_neg(state:*i64,lane:i64)->i64{var r:i64=jj_xvl_reg_code(lane);if r<0{return 0;}var rex:i64=0x48;if r>=8{rex=rex|1;}if jj_n_e8(state,rex)==0{return 0;}if jj_n_e8(state,0xf7)==0{return 0;}return jj_n_e8(state,0xd8|(r&7));}
fn jj_xvl_emit_constant(state:*i64,lane:i64,value:i64)->i64{var r:i64=jj_xvl_reg_code(lane);if r<0{return 0;}var rex:i64=0x48;if r>=8{rex=0x49;}if jj_n_e8(state,rex)==0{return 0;}if jj_n_e8(state,0xb8|(r&7))==0{return 0;}if jj_n_e64(state,value)==0{return 0;}return 1;}
fn jj_xvl_emit_spill_constant(ctx:*i64,state:*i64,index:i64,value:i64)->i64{if jj_xvl_signed32(value)==0{return 0;}var disp:i64=jj_xvl_spill_disp(ctx,index);if disp==0{return 0;}if jj_n_e8(state,0x48)==0{return 0;}if jj_n_e8(state,0xc7)==0{return 0;}if jj_n_e8(state,0x45)==0{return 0;}if jj_n_e8(state,disp)==0{return 0;}if jj_n_e32(state,value)==0{return 0;}return 1;}
fn jj_xvl_emit_arg0(state:*i64,lane:i64)->i64{
  var r:i64=jj_xvl_reg_code(lane);if r<0{return 0;}var rex:i64=0x48;if r>=8{rex=0x4c;}if jj_n_e8(state,rex)==0{return 0;}if jj_n_e8(state,0x8b)==0{return 0;}if jj_n_e8(state,0x45|((r&7)<<3))==0{return 0;}if jj_n_e8(state,0xf8)==0{return 0;}return 1;
}
fn jj_xvl_emit_reg_mem(ctx:*i64,state:*i64,op:i64,dst_lane:i64,spill_index:i64)->i64{
  var d:i64=jj_xvl_reg_code(dst_lane);if d<0{return 0;}var disp:i64=jj_xvl_spill_disp(ctx,spill_index);if disp==0{return 0;}var rex:i64=0x48;if d>=8{rex=0x4c;}if jj_n_e8(state,rex)==0{return 0;}
  if op==11{if jj_n_e8(state,0x0f)==0{return 0;}if jj_n_e8(state,0xaf)==0{return 0;}if jj_n_e8(state,0x45|((d&7)<<3))==0{return 0;}return jj_n_e8(state,disp);}
  var code:i64=0;if op==9{code=0x03;}if op==10{code=0x2b;}if op==16{code=0x23;}if op==17{code=0x0b;}if op==18{code=0x33;}if code==0{return 0;}if jj_n_e8(state,code)==0{return 0;}if jj_n_e8(state,0x45|((d&7)<<3))==0{return 0;}return jj_n_e8(state,disp);
}
fn jj_xvl_emit_reg_spill(ctx:*i64,state:*i64,key:i64)->i64{var spill_index:i64=key&255;var src_lane:i64=(key>>>8)&255;var s:i64=jj_xvl_reg_code(src_lane);if s<0{return 0;}var disp:i64=jj_xvl_spill_disp(ctx,spill_index);if disp==0{return 0;}var rex:i64=0x48;if s>=8{rex=0x4c;}if jj_n_e8(state,rex)==0{return 0;}if jj_n_e8(state,0x89)==0{return 0;}if jj_n_e8(state,0x45|((s&7)<<3))==0{return 0;}return jj_n_e8(state,disp);}
fn jj_xvl_emit_spill_reg_op(ctx:*i64,state:*i64,key:i64)->i64{var op:i64=key&255;var spill_index:i64=(key>>>8)&255;var src_lane:i64=(key>>>16)&255;var s:i64=jj_xvl_reg_code(src_lane);if s<0{return 0;}var disp:i64=jj_xvl_spill_disp(ctx,spill_index);if disp==0{return 0;}var code:i64=0;if op==9{code=0x01;}if op==10{code=0x29;}if op==16{code=0x21;}if op==17{code=0x09;}if op==18{code=0x31;}if code==0{return 0;}var rex:i64=0x48;if s>=8{rex=0x4c;}if jj_n_e8(state,rex)==0{return 0;}if jj_n_e8(state,code)==0{return 0;}if jj_n_e8(state,0x45|((s&7)<<3))==0{return 0;}return jj_n_e8(state,disp);}
fn jj_xvl_emit_binary_spill(ctx:*i64,state:*i64,key:i64)->i64{var plan:*i64=jj_xvl_plan(ctx);if jj_xvl_binary_spill_ok(plan,key)==0{return 0;}var op:i64=key&255;var dst:i64=(key>>>8)&255;var lhs:i64=(key>>>16)&255;var rhs:i64=(key>>>24)&255;var di:i64=jj_target_allocator_value_index(plan,672,dst);var ll:i64=jj_target_allocator_value_index(plan,672,lhs);var rl:i64=jj_target_allocator_value_index(plan,672,rhs);if jj_xvl_emit_reg_spill(ctx,state,di|(ll<<8))==0{return 0;}return jj_xvl_emit_spill_reg_op(ctx,state,op|(di<<8)|(rl<<16));}
fn jj_xvl_emit_binary_regs(state:*i64,op:i64,dst:i64,lhs:i64,rhs:i64)->i64{
  var commutative:i64=0;if op!=10{commutative=1;}if dst==lhs{if op==11{return jj_xvl_emit_imul(state,dst,rhs);}var code:i64=0x01;if op==10{code=0x29;}if op==16{code=0x21;}if op==17{code=0x09;}if op==18{code=0x31;}return jj_xvl_emit_simple(state,code,dst,rhs);}
  if commutative!=0{if dst==rhs{if op==11{return jj_xvl_emit_imul(state,dst,lhs);}var code2:i64=0x01;if op==16{code2=0x21;}if op==17{code2=0x09;}if op==18{code2=0x31;}return jj_xvl_emit_simple(state,code2,dst,lhs);}if jj_xvl_emit_mov(state,dst,lhs)==0{return 0;}if op==11{return jj_xvl_emit_imul(state,dst,rhs);}var code3:i64=0x01;if op==16{code3=0x21;}if op==17{code3=0x09;}if op==18{code3=0x31;}return jj_xvl_emit_simple(state,code3,dst,rhs);}
  if dst==rhs{if lhs==rhs{return jj_xvl_emit_simple(state,0x31,dst,dst);}if jj_xvl_emit_neg(state,dst)==0{return 0;}return jj_xvl_emit_simple(state,0x01,dst,lhs);}if jj_xvl_emit_mov(state,dst,lhs)==0{return 0;}return jj_xvl_emit_simple(state,0x29,dst,rhs);
}
fn jj_xvl_emit_binary(ctx:*i64,state:*i64,op:i64,dst:i64,lhs:i64,rhs:i64)->i64{
  var plan:*i64=jj_xvl_plan(ctx);if jj_xvl_binary_plan_ok(plan,op,dst,lhs,rhs)==0{return 0;}var dk:i64=jj_target_allocator_value_kind(plan,672,dst);if dk==2{return jj_xvl_emit_binary_spill(ctx,state,op|(dst<<8)|(lhs<<16)|(rhs<<24));}var lk:i64=jj_target_allocator_value_kind(plan,672,lhs);var rk:i64=jj_target_allocator_value_kind(plan,672,rhs);var dl:i64=jj_target_allocator_value_index(plan,672,dst);var ll:i64=jj_target_allocator_value_index(plan,672,lhs);var rl:i64=jj_target_allocator_value_index(plan,672,rhs);if lk==1{if rk==1{return jj_xvl_emit_binary_regs(state,op,dl,ll,rl);}if dl!=ll{return 0;}return jj_xvl_emit_reg_mem(ctx,state,op,dl,rl);}if rk!=1{return 0;}if op==10{return 0;}if dl!=rl{return 0;}return jj_xvl_emit_reg_mem(ctx,state,op,dl,ll);
}

fn jj_xvl_emit_body(ctx:*i64,state:*i64,program:*i8,start:i64,end:i64)->i64{
  if jj_xvl_validate(ctx)==0{return 0;}if state==0{return 0;}if program==0{return 0;}if start!=ctx[4]{return 0;}if end!=ctx[5]{return 0;}if jj_xvl_code_hash(program,start,end)!=ctx[9]{return 0;}var layout:*i64=jj_xvl_layout(ctx);var body_start:i64=state[2];
  var env:*i64=jj_xvl_env(ctx);var stack:*i64=jj_xvl_stack(ctx);var materialized:*i64=jj_xvl_materialized(ctx);var plan:*i64=jj_xvl_plan(ctx);var i:i64=0;while i<64{env[i]=0;i=i+1;}i=0;while i<256{stack[i]=0;i=i+1;}i=0;while i<128{materialized[i]=0;i=i+1;}
  var next_value:i64=1;if ctx[2]==1{env[0]=1;next_value=2;}var depth:i64=0;var pc:i64=start;var returned:i64=0;var stores:i64=0;var reads:i64=0;var operation:i64=0;
  while pc<end{if operation>=layout[1]{return 0;}var entry:i64=layout[8+operation];if (entry&0xffffffff)!=(pc&0xffffffff){return 0;}if ((entry>>>32)&0xffffffff)!=state[2]-body_start{return 0;}var before:i64=state[2];var op:i64=program[pc]&255;state[16]=75620+op;state[17]=pc;
    if op==1{var cv:i64=next_value;next_value=next_value+1;var ck:i64=jj_target_allocator_value_kind(plan,672,cv);var cl:i64=jj_target_allocator_value_index(plan,672,cv);if ck==1{if jj_xvl_emit_constant(state,cl,jj_xvl_rd64(program+pc+1))==0{return 0;}}else{if ck==2{if jj_xvl_emit_spill_constant(ctx,state,cl,jj_xvl_rd64(program+pc+1))==0{return 0;}stores=stores+1;}else{return 0;}}materialized[cv]=1;stack[depth]=cv;depth=depth+1;pc=pc+9;}
    else{if op==2{var ls:i64=jj_xvl_rd16(program+pc+1);var lv:i64=env[ls];if lv<=0{return 0;}if materialized[lv]==0{if lv!=1{return 0;}if ctx[2]!=1{return 0;}if jj_target_allocator_value_kind(plan,672,lv)!=1{return 0;}var ll:i64=jj_target_allocator_value_index(plan,672,lv);if jj_xvl_emit_arg0(state,ll)==0{return 0;}materialized[lv]=1;}stack[depth]=lv;depth=depth+1;pc=pc+3;}
    else{if op==3{if depth<=0{return 0;}depth=depth-1;env[jj_xvl_rd16(program+pc+1)]=stack[depth];pc=pc+3;}
    else{if jj_xvl_supported_binary(op)!=0{if depth<2{return 0;}var rhs:i64=stack[depth-1];var lhs:i64=stack[depth-2];depth=depth-2;var dst:i64=next_value;next_value=next_value+1;if materialized[lhs]==0{return 0;}if materialized[rhs]==0{return 0;}if jj_target_allocator_value_kind(plan,672,lhs)==2{reads=reads+1;}if jj_target_allocator_value_kind(plan,672,rhs)==2{reads=reads+1;}if jj_xvl_emit_binary(ctx,state,op,dst,lhs,rhs)==0{return 0;}if jj_target_allocator_value_kind(plan,672,dst)==2{stores=stores+1;}materialized[dst]=1;stack[depth]=dst;depth=depth+1;pc=pc+1;}
    else{if op==31{if depth<=0{return 0;}depth=depth-1;pc=pc+1;}
    else{if op==30{if depth!=1{return 0;}var rv:i64=stack[0];if rv!=ctx[6]{return 0;}if jj_target_allocator_value_kind(plan,672,rv)!=1{return 0;}if jj_target_allocator_value_index(plan,672,rv)!=0{return 0;}if jj_n_e8(state,0xc9)==0{return 0;}if jj_n_e8(state,0xc3)==0{return 0;}depth=0;returned=1;pc=pc+1;}
    else{return 0;}}}}}}
    var expected:i64=layout[2];if operation+1<layout[1]{expected=(layout[8+operation+1]>>>32)&0xffffffff;}expected=expected-((entry>>>32)&0xffffffff);if state[2]-before!=expected{return 0;}operation=operation+1;
  }
  if operation!=layout[1]{return 0;}if state[2]-body_start!=layout[2]{return 0;}if pc!=end{return 0;}if returned!=1{return 0;}if next_value-1!=ctx[7]{return 0;}if stores!=ctx[12]{return 0;}if reads!=ctx[13]{return 0;}return 1;
}

fn jj_xvl_resource_contract(out:*i64,slots:i64)->i64{if out==0{return 0;}if slots!=12{return 0;}var i:i64=0;while i<12{out[i]=0;i=i+1;}out[0]=1816;out[1]=512;out[2]=672;out[3]=64;out[4]=256;out[5]=128;out[6]=4;out[7]=2;out[8]=1;out[9]=16;out[10]=4;out[11]=(out as i64)^0x4a4a58564c523537;return 1;}
