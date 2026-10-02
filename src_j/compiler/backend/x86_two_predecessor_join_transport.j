// R761 bounded CFG-wide location and acyclic copy-set authority.
// Directly selects one or two join values from bytecode liveness and block locations.
// No legacy post-patch planner, byte-pattern discovery, cycles or critical-edge split.
extern fn jj_n_bc_len(p0:*i8,p1:i64,p2:i64)->i64;
extern fn jj_vm_rd16(p0:*i8)->i64;
extern fn jj_vm_rd32(p0:*i8)->i64;
extern fn jj_reo_code_hash(p0:*i8,p1:i64)->i64;
extern fn jj_n_offset_for_pc(p0:*i8,p1:i64,p2:i64,p3:i64,p4:i64)->i64;
extern fn jj_codeseg_emit(p0:*i64,p1:*i64,p2:i64,p3:i64)->i64;
fn jj_xcfg_hash_program(program:*i8,start:i64,end:i64)->i64{
 if program==0{return 0;}var h:i64=0x4a4a584346424331^start^(end<<17);var pc:i64=start;
 while pc<end{var n:i64=jj_n_bc_len(program,pc,end);if n<=0{return 0;}var j:i64=0;while j<n{h=((h<<5)|(h>>>59))^(program[pc+j]&255)^((pc+j)<<23);j=j+1;}pc=pc+n;}
 if pc!=end{return 0;}if h==0{return 1;}return h;
}
fn jj_xcfg_block_index(plan:*i64,pc:i64)->i64{
 if plan==0{return 0-1;}var i:i64=0;while i<plan[2]{if plan[16+i*8]==pc{return i;}i=i+1;}return 0-1;
}
fn jj_xcfg_action(ctx:*i64,index:i64)->*i64{return ((ctx as i64)+(64+index*8)*8) as *i64;}
fn jj_xcfg_block(ctx:*i64,index:i64)->*i64{return ((ctx as i64)+(128+index*8)*8) as *i64;}
fn jj_xcfg_rot(h:i64,v:i64)->i64{return ((h<<7)|(h>>>57))^v;}
fn jj_xcfg_action_local(a:*i64)->i64{if a==0{return 0-1;}return a[3]&255;}
fn jj_xcfg_action_slot(a:*i64)->i64{if a==0{return 0-1;}return (a[3]>>>8)&255;}
fn jj_xcfg_action_replacement(a:*i64)->i64{if a==0{return 0;}return (a[3]>>>16)&255;}
fn jj_xcfg_action_ordinal(a:*i64)->i64{if a==0{return 0;}return (a[3]>>>24)&255;}
fn jj_xcfg_plan_seal(ctx:*i64)->i64{
 if ctx==0{return 0;}var h:i64=(ctx as i64)^0x4a4a584346473131;var i:i64=0;
 while i<19{h=jj_xcfg_rot(h,ctx[i]^(i<<41));i=i+1;}i=29;while i<35{h=jj_xcfg_rot(h,ctx[i]^(i<<37));i=i+1;}
 i=0;while i<ctx[13]{var a:*i64=jj_xcfg_action(ctx,i);var j:i64=0;while j<7{h=jj_xcfg_rot(h,a[j]^(i<<33)^(j<<49));j=j+1;}i=i+1;}
 i=0;while i<ctx[8]{var b:*i64=jj_xcfg_block(ctx,i);var k:i64=0;while k<8{h=jj_xcfg_rot(h,b[k]^(i<<31)^(k<<47));k=k+1;}i=i+1;}
 if h==0{return 1;}return h;
}
fn jj_xcfg_valid(ctx:*i64)->i64{
 if ctx==0{return 0;}if ctx[0]!=0x4a4a584346473131{return 0;}if ctx[1]!=1{return 0;}if ctx[2]<1{return 0;}if ctx[2]>4{return 0;}
 if ctx[8]<3{return 0;}if ctx[8]>16{return 0;}if ctx[9]<1{return 0;}if ctx[9]>2{return 0;}if ctx[10]<0{return 0;}if ctx[10]>2{return 0;}
 if ctx[13]<1{return 0;}if ctx[13]>8{return 0;}if ctx[28]!=jj_xcfg_plan_seal(ctx){return 0;}return 1;
}
fn jj_xcfg_active(ctx:*i64)->i64{if jj_xcfg_valid(ctx)==0{return 0;}return ctx[2];}
fn jj_xcfg_plan_receipt(ctx:*i64)->i64{if jj_xcfg_valid(ctx)==0{return 0;}return ctx[18];}
fn jj_xcfg_lineage(ctx:*i64)->i64{
 if ctx==0{return 761;}return 761|((ctx[2]&15)<<12)|((ctx[35]&255)<<16)|((ctx[36]&255)<<24)|((ctx[37]&255)<<32)|((ctx[10]&255)<<40);
}
fn jj_xcfg_fail(ctx:*i64,packed:i64,machine:i64)->i64{
 if ctx!=0{ctx[21]=packed>>>32;ctx[22]=packed&0xffffffff;ctx[23]=machine;ctx[35]=0;ctx[36]=0;ctx[37]=0;
  var pc:i64=ctx[22];var i:i64=0;while i<ctx[13]{var a:*i64=jj_xcfg_action(ctx,i);if a[0]==pc{ctx[35]=jj_xcfg_action_local(a);ctx[36]=jj_xcfg_action_replacement(a);ctx[37]=jj_xcfg_action_ordinal(a);i=ctx[13];}else{i=i+1;}}
  if ctx[35]==0{var cursor:i64=ctx[19];if cursor>=0{if cursor<ctx[13]{var c:*i64=jj_xcfg_action(ctx,cursor);ctx[35]=jj_xcfg_action_local(c);ctx[36]=jj_xcfg_action_replacement(c);ctx[37]=jj_xcfg_action_ordinal(c);}}}
 }return 0;
}
fn jj_xcfg_add_action(ctx:*i64,packed:i64,old_offset:i64)->i64{
 if ctx==0{return 0;}var pc:i64=packed&0xffffffff;var kind:i64=(packed>>>32)&255;var block:i64=(packed>>>40)&255;var local:i64=(packed>>>48)&255;var physical:i64=(packed>>>56)&255;
 var old_len:i64=0;var new_len:i64=0;var replacement:i64=0;
 if kind==1{old_len=8;new_len=1;replacement=1;}if kind==2{old_len=6;new_len=3;replacement=1;}if kind==3{old_len=3;new_len=2;replacement=1;}if kind==4{old_len=8;new_len=8;replacement=3;}
 if kind==5{old_len=8;new_len=1;replacement=2;}if kind==6{old_len=6;new_len=1;replacement=1;}if kind==7{old_len=6;new_len=1;replacement=2;}if kind==8{old_len=8;new_len=8;replacement=3;}
 if old_len==0{return 0;}if old_offset<0{return 0;}if old_offset>0xffffffff{return 0;}var count:i64=ctx[13];if count>=8{return 0;}
 var pos:i64=count;while pos>0{var prior:*i64=jj_xcfg_action(ctx,pos-1);if prior[4]<=old_offset{break;}var dst:*i64=jj_xcfg_action(ctx,pos);var j:i64=0;while j<8{dst[j]=prior[j];j=j+1;}pos=pos-1;}
 var a:*i64=jj_xcfg_action(ctx,pos);a[0]=pc;a[1]=kind;a[2]=block;a[3]=(local&255)|((physical&255)<<8)|((replacement&255)<<16)|(255<<24);a[4]=old_offset;a[5]=old_len;a[6]=new_len;a[7]=0-1;ctx[13]=count+1;if new_len<old_len{ctx[14]=ctx[14]+1;}return 1;
}
fn jj_xcfg_copy_ordinals(ctx:*i64)->i64{
 if ctx==0{return 0;}var ordinal:i64=0;var i:i64=0;while i<ctx[13]{var a:*i64=jj_xcfg_action(ctx,i);var kind:i64=a[1];var mark:i64=255;if kind==4{mark=ordinal;ordinal=ordinal+1;}if kind==8{mark=ordinal;ordinal=ordinal+1;}a[3]=(a[3]&0x00ffffff)|((mark&255)<<24);i=i+1;}ctx[10]=ordinal;return 1;
}
fn jj_xcfg_scan_blocks(program:*i8,plan:*i64,ctx:*i64)->i64{
 var blocks:i64=plan[2];var bi:i64=0;while bi<blocks{var pr:i64=16+bi*8;var b:*i64=jj_xcfg_block(ctx,bi);var begin:i64=plan[pr];var end:i64=plan[pr+1];if begin<ctx[3]{return 0;}if end<=begin{return 0;}if end>ctx[4]{return 0;}b[0]=begin;b[1]=end;b[2]=0;b[3]=0;b[4]=0;b[5]=0;var s0:i64=0-1;var s1:i64=0-1;if plan[pr+3]>=0{s0=jj_xcfg_block_index(plan,plan[pr+3]);if s0<=bi{return 0;}}if plan[pr+4]>=0{s1=jj_xcfg_block_index(plan,plan[pr+4]);if s1<=bi{return 0;}}b[6]=(s0&0xffffffff)|((s1&0xffffffff)<<32);b[7]=0;var seen:i64=0;var pc:i64=begin;
  while pc<end{var n:i64=jj_n_bc_len(program,pc,end);if n<=0{return 0;}var op:i64=program[pc]&255;if op==2{var l:i64=jj_vm_rd16(program+pc+1);if l>=ctx[6]{return 0;}var bit:i64=1<<l;if (seen&bit)==0{b[2]=b[2]|bit;}}if op==3{var d:i64=jj_vm_rd16(program+pc+1);if d>=ctx[6]{return 0;}var db:i64=1<<d;b[3]=b[3]|db;seen=seen|db;}if op==4{return 0;}if op==29{return 0;}if op>=33{if op<=36{return 0;}}if op==49{return 0;}pc=pc+n;}if pc!=end{return 0;}bi=bi+1;}
 bi=blocks;while bi>0{bi=bi-1;var bb:*i64=jj_xcfg_block(ctx,bi);var packed:i64=bb[6];var x0:i64=packed&0xffffffff;var x1:i64=(packed>>>32)&0xffffffff;var out:i64=0;if x0!=0xffffffff{var bx0:*i64=jj_xcfg_block(ctx,x0);out=out|bx0[4];}if x1!=0xffffffff{var bx1:*i64=jj_xcfg_block(ctx,x1);out=out|bx1[4];}bb[5]=out;bb[4]=bb[2]|(out&((0-1)^bb[3]));}return 1;
}
fn jj_xcfg_pred_count(ctx:*i64,join:i64)->i64{
 if ctx==0{return 0-1;}var count:i64=0;var i:i64=0;while i<ctx[8]{if i!=join{var b:*i64=jj_xcfg_block(ctx,i);var s0:i64=b[6]&0xffffffff;var s1:i64=(b[6]>>>32)&0xffffffff;if s0==join{count=count+1;}if s1==join{count=count+1;}}i=i+1;}return count;
}
fn jj_xcfg_pred_pair(ctx:*i64,join:i64,out:*i64)->i64{
 if ctx==0{return 0;}if out==0{return 0;}var p0:i64=0-1;var p1:i64=0-1;var i:i64=0;while i<ctx[8]{if i!=join{var b:*i64=jj_xcfg_block(ctx,i);var hit:i64=0;var s0:i64=b[6]&0xffffffff;var s1:i64=(b[6]>>>32)&0xffffffff;if s0==join{hit=1;}if s1==join{hit=1;}if hit!=0{if p0<0{p0=i;}else{if p1<0{p1=i;}else{return 0;}}}}i=i+1;}if p0<0{return 0;}if p1<0{return 0;}out[10]=p0;out[11]=p1;return 1;
}
fn jj_xcfg_succ_count(ctx:*i64,bi:i64)->i64{
 if ctx==0{return 0-1;}if bi<0{return 0-1;}if bi>=ctx[8]{return 0-1;}var b:*i64=jj_xcfg_block(ctx,bi);var n:i64=0;if (b[6]&0xffffffff)!=0xffffffff{n=n+1;}if ((b[6]>>>32)&0xffffffff)!=0xffffffff{n=n+1;}return n;
}
fn jj_xcfg_binary(op:i64)->i64{if op==9{return 1;}if op==10{return 1;}if op==11{return 1;}if op==16{return 1;}if op==17{return 1;}if op==18{return 1;}return 0;}
// Scratch out[0..8]: join pc,end,count,local0,local1,load0,load1,binary,return.
fn jj_xcfg_join_probe(program:*i8,ctx:*i64,join:i64)->i64{
 if program==0{return 0-1;}if ctx==0{return 0-1;}if join<0{return 0;}if join>=ctx[8]{return 0;}var out:*i64=((ctx as i64)+320*8) as *i64;var b:*i64=jj_xcfg_block(ctx,join);var pc0:i64=b[0];var end0:i64=b[1];var n0:i64=jj_n_bc_len(program,pc0,end0);if n0!=3{return 0;}if (program[pc0]&255)!=2{return 0;}var l0:i64=jj_vm_rd16(program+pc0+1);if l0<ctx[5]{return 0;}if l0>=ctx[6]{return 0;}var pc1:i64=pc0+n0;var n1:i64=jj_n_bc_len(program,pc1,end0);if n1<=0{return 0;}
 if (program[pc1]&255)==30{if pc1+n1!=end0{return 0;}out[0]=pc0;out[1]=end0;out[2]=1;out[3]=l0;out[4]=0-1;out[5]=pc0;out[6]=0-1;out[7]=0-1;out[8]=pc1;return 1;}
 if (program[pc1]&255)!=2{return 0;}if n1!=3{return 0;}var l1:i64=jj_vm_rd16(program+pc1+1);if l1<ctx[5]{return 0;}if l1>=ctx[6]{return 0;}if l1==l0{return 0;}var pcb:i64=pc1+n1;var nb:i64=jj_n_bc_len(program,pcb,end0);if nb!=1{return 0;}if jj_xcfg_binary(program[pcb]&255)==0{return 0;}var pcr:i64=pcb+nb;var nr:i64=jj_n_bc_len(program,pcr,end0);if nr!=1{return 0;}if (program[pcr]&255)!=30{return 0;}if pcr+nr!=end0{return 0;}out[0]=pc0;out[1]=end0;out[2]=2;out[3]=l0;out[4]=l1;out[5]=pc0;out[6]=pc1;out[7]=pcb;out[8]=pcr;return 2;
}
// packed: low8 block, bits8..15 value count, bits16..23 local0, bits24..31 local1, bits32..39 join block.
// Only stores immediately preceding the edge terminator are deliveries. Earlier stores remain ordinary frame state.
// return low32=store0+2, high32=store1+2; zero means absent, -1 malformed.
fn jj_xcfg_pred_stores(program:*i8,ctx:*i64,packed:i64)->i64{
 if program==0{return 0-1;}if ctx==0{return 0-1;}var bi:i64=packed&255;var values:i64=(packed>>>8)&255;var l0:i64=(packed>>>16)&255;var l1:i64=(packed>>>24)&255;var join:i64=(packed>>>32)&255;if bi>=ctx[8]{return 0-1;}if join>=ctx[8]{return 0-1;}var b:*i64=jj_xcfg_block(ctx,bi);var pc:i64=b[0];var q0:i64=0-1;var q1:i64=0-1;var q2:i64=0-1;var q3:i64=0-1;var q4:i64=0-1;
 while pc<b[1]{var n:i64=jj_n_bc_len(program,pc,b[1]);if n<=0{return 0-1;}q4=q3;q3=q2;q2=q1;q1=q0;q0=pc;pc=pc+n;}if pc!=b[1]{return 0-1;}if q0<0{return 0-1;}var lastop:i64=program[q0]&255;if lastop==28{return 0;}var t0:i64=q0;var t1:i64=q1;var t2:i64=q2;var t3:i64=q3;if lastop==27{var jb:*i64=jj_xcfg_block(ctx,join);if jj_vm_rd32(program+q0+1)!=jb[0]{return 0-1;}t0=q1;t1=q2;t2=q3;t3=q4;}else{var s0b:i64=b[6]&0xffffffff;var s1b:i64=(b[6]>>>32)&0xffffffff;if s0b!=join{if s1b!=join{return 0-1;}}}
 if values==1{if t0<0{return 0;}if t1<0{return 0;}if (program[t0]&255)!=3{return 0;}if jj_vm_rd16(program+t0+1)!=l0{return 0;}if (program[t1]&255)!=1{return 0;}return (t0+2)&0xffffffff;}
 if values!=2{return 0-1;}if t0<0{return 0;}if t1<0{return 0;}if t2<0{return 0;}if t3<0{return 0;}if (program[t0]&255)!=3{return 0;}if (program[t1]&255)!=1{return 0;}if (program[t2]&255)!=3{return 0;}if (program[t3]&255)!=1{return 0;}var d0:i64=jj_vm_rd16(program+t0+1);var d1:i64=jj_vm_rd16(program+t2+1);if d0==d1{return 0;}var st0:i64=0-2;var st1:i64=0-2;if d0==l0{st0=t0;}if d0==l1{st1=t0;}if d1==l0{st0=t2;}if d1==l1{st1=t2;}if st0<0{return 0;}if st1<0{return 0;}return ((st1+2)&0xffffffff)<<32|((st0+2)&0xffffffff);
}
fn jj_xcfg_refs(program:*i8,ctx:*i64,local:i64)->i64{
 if program==0{return 0-1;}if ctx==0{return 0-1;}var loads:i64=0;var stores:i64=0;var address:i64=0;var pc:i64=ctx[3];while pc<ctx[4]{var n:i64=jj_n_bc_len(program,pc,ctx[4]);if n<=0{return 0-1;}var op:i64=program[pc]&255;if op==2{if jj_vm_rd16(program+pc+1)==local{loads=loads+1;}}if op==3{if jj_vm_rd16(program+pc+1)==local{stores=stores+1;}}if op==4{var a:i64=jj_vm_rd16(program+pc+1);var ar:i64=jj_vm_rd16(program+pc+3);if local>=a{if local<a+ar{address=1;}}}pc=pc+n;}if pc!=ctx[4]{return 0-1;}if loads>65535{return 0-1;}if stores>65535{return 0-1;}return loads|(stores<<16)|(address<<32);
}
// Candidate result is copied to scratch q[16..30] by prepare.
fn jj_xcfg_probe_candidate(program:*i8,ctx:*i64,join:i64)->i64{
 var p:*i64=((ctx as i64)+320*8) as *i64;var values:i64=jj_xcfg_join_probe(program,ctx,join);if values<=0{return values;}if jj_xcfg_pred_count(ctx,join)!=2{return 0;}if jj_xcfg_pred_pair(ctx,join,p)==0{return 0;}var p0:i64=p[10];var p1:i64=p[11];var l0:i64=p[3];var l1:i64=p[4];var jb:*i64=jj_xcfg_block(ctx,join);var b0:*i64=jj_xcfg_block(ctx,p0);var b1:*i64=jj_xcfg_block(ctx,p1);var bit0:i64=1<<l0;if (jb[4]&bit0)==0{return 0;}if (b0[5]&bit0)==0{return 0;}if (b1[5]&bit0)==0{return 0;}if values==2{var bit1:i64=1<<l1;if (jb[4]&bit1)==0{return 0;}if (b0[5]&bit1)==0{return 0;}if (b1[5]&bit1)==0{return 0;}}
 var key0:i64=(p0&255)|((values&255)<<8)|((l0&255)<<16)|((l1&255)<<24)|((join&255)<<32);var key1:i64=(p1&255)|((values&255)<<8)|((l0&255)<<16)|((l1&255)<<24)|((join&255)<<32);var stores0:i64=jj_xcfg_pred_stores(program,ctx,key0);if stores0==0-2{return 0;}if stores0<0{return 0-1;}var stores1:i64=jj_xcfg_pred_stores(program,ctx,key1);if stores1==0-2{return 0;}if stores1<0{return 0-1;}var s00:i64=(stores0&0xffffffff)-2;var s01:i64=((stores0>>>32)&0xffffffff)-2;var s10:i64=(stores1&0xffffffff)-2;var s11:i64=((stores1>>>32)&0xffffffff)-2;var all0:i64=0;var all1:i64=0;var none0:i64=0;var none1:i64=0;if s00>=0{if values==1{all0=1;}else{if s01>=0{all0=1;}}}if s10>=0{if values==1{all1=1;}else{if s11>=0{all1=1;}}}if s00<0{if values==1{none0=1;}else{if s01<0{none0=1;}}}if s10<0{if values==1{none1=1;}else{if s11<0{none1=1;}}}
 var succ0:i64=jj_xcfg_succ_count(ctx,p0);var succ1:i64=jj_xcfg_succ_count(ctx,p1);var mode:i64=0;if all0!=0{if all1!=0{if succ0==1{if succ1==1{if values==1{mode=1;}else{mode=3;}}}}}if mode==0{if all0!=0{if none1!=0{if succ0==1{if succ1==2{if values==1{mode=2;}else{mode=4;}}}}}if mode==0{if all1!=0{if none0!=0{if succ1==1{if succ0==2{var tp:i64=p0;p0=p1;p1=tp;var ts0:i64=s00;s00=s10;s10=ts0;var ts1:i64=s01;s01=s11;s11=ts1;if values==1{mode=2;}else{mode=4;}}}}}}}if mode==0{return 0;}
 var refs0:i64=jj_xcfg_refs(program,ctx,l0);if refs0<0{return 0-1;}var expected_stores:i64=3;if mode==2{expected_stores=2;}if mode==4{expected_stores=2;}if (refs0&65535)!=1{return 0;}if ((refs0>>>16)&65535)!=expected_stores{return 0;}if (refs0>>>32)!=0{return 0;}if values==2{var refs1:i64=jj_xcfg_refs(program,ctx,l1);if refs1<0{return 0-1;}if (refs1&65535)!=1{return 0;}if ((refs1>>>16)&65535)!=expected_stores{return 0;}if (refs1>>>32)!=0{return 0;}}
 p[16]=mode;p[17]=join;p[18]=p0;p[19]=p1;p[20]=values;p[21]=l0;p[22]=l1;p[23]=p[5];p[24]=p[6];p[25]=p[7];p[26]=p[8];p[27]=s00;p[28]=s01;p[29]=s10;p[30]=s11;return mode;
}
fn jj_xcfg_find_block(ctx:*i64,pc:i64)->i64{var i:i64=0;while i<ctx[8]{var b:*i64=jj_xcfg_block(ctx,i);if pc>=b[0]{if pc<b[1]{return i;}}i=i+1;}return 0-1;}
fn jj_xcfg_set_location(ctx:*i64,packed:i64,locations:i64)->i64{
 if ctx==0{return 0;}var block:i64=packed&255;var ordinal:i64=(packed>>>8)&255;if block>=ctx[8]{return 0;}if ordinal>1{return 0;}var shift:i64=ordinal*16;var mask:i64=0xffff<<shift;var b:*i64=jj_xcfg_block(ctx,block);b[7]=(b[7]&((0-1)^mask))|((locations&0xffff)<<shift);return 1;
}
fn jj_xcfg_hash_tables(ctx:*i64)->i64{
 var lh:i64=0x4a4a584c49564532;var i:i64=0;while i<ctx[8]{var b:*i64=jj_xcfg_block(ctx,i);lh=jj_xcfg_rot(lh,b[2]^b[3]^b[4]^b[5]^b[6]^b[7]^i);i=i+1;}ctx[16]=lh;var ah:i64=0x4a4a584143543032;i=0;while i<ctx[13]{var a:*i64=jj_xcfg_action(ctx,i);ah=jj_xcfg_rot(ah,a[0]^a[1]^a[2]^a[3]^a[4]^a[5]^a[6]^i);i=i+1;}ctx[17]=ah;return 1;
}
// Input fields ctx[512..518]: start,end,argc,locals,map pointer,map mode,old size.
fn jj_xcfg_prepare(program:*i8,plan:*i64,ctx:*i64)->i64{
 if program==0{return 0-1;}if plan==0{return 0-1;}if ctx==0{return 0-1;}ctx[0]=0;ctx[1]=0;ctx[13]=0;ctx[14]=0;ctx[21]=0;ctx[22]=0;ctx[23]=0;ctx[35]=0;ctx[36]=0;ctx[37]=0;
 var start:i64=ctx[512];var end:i64=ctx[513];var argc:i64=ctx[514];var locals:i64=ctx[515];var map:*i64=ctx[516] as *i64;var map_mode:i64=ctx[517];var old_size:i64=ctx[518];if start<0{return jj_xcfg_fail(ctx,(76140<<32)|(start&0xffffffff),0)-1;}if end<=start{return jj_xcfg_fail(ctx,(76140<<32)|(start&0xffffffff),0)-1;}if argc<0{return jj_xcfg_fail(ctx,(76140<<32)|(start&0xffffffff),0)-1;}if locals<argc{return jj_xcfg_fail(ctx,(76140<<32)|(start&0xffffffff),0)-1;}if locals>16{return 0;}if old_size<=0{return jj_xcfg_fail(ctx,(76140<<32)|(start&0xffffffff),0)-1;}if old_size>=12288{return 0;}if plan[0]!=0x4a4a42504c414e31{return jj_xcfg_fail(ctx,(76140<<32)|(start&0xffffffff),0)-1;}if plan[1]!=1{return 0;}if plan[2]<3{return 0;}if plan[2]>16{return 0;}if plan[4]!=0{return 0;}
 ctx[3]=start;ctx[4]=end;ctx[5]=argc;ctx[6]=locals;ctx[7]=old_size;ctx[8]=plan[2];if jj_xcfg_scan_blocks(program,plan,ctx)==0{return 0;}var selected:*i64=((ctx as i64)+384*8) as *i64;var candidates:i64=0;var join:i64=0;while join<ctx[8]{if jj_xcfg_pred_count(ctx,join)==2{var candidate:i64=jj_xcfg_probe_candidate(program,ctx,join);if candidate<0{return jj_xcfg_fail(ctx,(76141<<32)|(start&0xffffffff),0)-1;}if candidate!=0{candidates=candidates+1;if candidates>1{return 0;}var probe:*i64=((ctx as i64)+320*8) as *i64;var ci:i64=16;while ci<=30{selected[ci]=probe[ci];ci=ci+1;}}}join=join+1;}if candidates==0{return 0;}
 var mode:i64=selected[16];var join_index:i64=selected[17];var p0:i64=selected[18];var p1:i64=selected[19];var values:i64=selected[20];var local0:i64=selected[21];var local1:i64=selected[22];var physical0:i64=local0;var physical1:i64=local1;if map_mode!=0{if map==0{return jj_xcfg_fail(ctx,(76142<<32)|(selected[23]&0xffffffff),0)-1;}physical0=map[local0];if values==2{physical1=map[local1];}}if physical0<0{return jj_xcfg_fail(ctx,(76142<<32)|(selected[23]&0xffffffff),0)-1;}if physical0>255{return 0;}if values==2{if physical1<0{return jj_xcfg_fail(ctx,(76142<<32)|(selected[24]&0xffffffff),0)-1;}if physical1>255{return 0;}}
 ctx[0]=0x4a4a584346473131;ctx[1]=0;ctx[2]=mode;ctx[3]=start;ctx[4]=end;ctx[5]=argc;ctx[6]=locals;ctx[7]=old_size;ctx[8]=plan[2];ctx[9]=values;ctx[10]=0;ctx[11]=jj_xcfg_block(ctx,join_index)[0];ctx[12]=selected[26];ctx[13]=0;ctx[14]=0;ctx[15]=jj_xcfg_hash_program(program,start,end);ctx[16]=0;ctx[17]=0;ctx[18]=0;ctx[19]=0;ctx[20]=0;ctx[24]=0;ctx[25]=0;ctx[26]=map_mode;ctx[27]=0;ctx[28]=0;ctx[29]=join_index;ctx[30]=p0;ctx[31]=p1;ctx[32]=local0;ctx[33]=local1;ctx[34]=selected[25];if ctx[15]==0{return jj_xcfg_fail(ctx,(76143<<32)|(start&0xffffffff),0)-1;}
 var loc0:i64=1;var loc1:i64=2;var slotloc:i64=3;if mode==1{jj_xcfg_set_location(ctx,p0,3|(loc0<<8));jj_xcfg_set_location(ctx,p1,3|(loc0<<8));jj_xcfg_set_location(ctx,join_index,loc0|(loc0<<8));}if mode==2{jj_xcfg_set_location(ctx,p0,3|(slotloc<<8));jj_xcfg_set_location(ctx,p1,3|(slotloc<<8));jj_xcfg_set_location(ctx,join_index,slotloc|(slotloc<<8));}if mode==3{jj_xcfg_set_location(ctx,p0,3|(loc0<<8));jj_xcfg_set_location(ctx,p1,3|(loc0<<8));jj_xcfg_set_location(ctx,join_index,loc0|(loc0<<8));jj_xcfg_set_location(ctx,p0|(1<<8),3|(loc1<<8));jj_xcfg_set_location(ctx,p1|(1<<8),3|(loc1<<8));jj_xcfg_set_location(ctx,join_index|(1<<8),loc1|(loc1<<8));}if mode==4{jj_xcfg_set_location(ctx,p0,3|(slotloc<<8));jj_xcfg_set_location(ctx,p1,3|(slotloc<<8));jj_xcfg_set_location(ctx,join_index,slotloc|(slotloc<<8));jj_xcfg_set_location(ctx,p0|(1<<8),3|(slotloc<<8));jj_xcfg_set_location(ctx,p1|(1<<8),3|(slotloc<<8));jj_xcfg_set_location(ctx,join_index|(1<<8),slotloc|(slotloc<<8));}
 var os00:i64=0;var os01:i64=0;var os10:i64=0;var os11:i64=0;var ol0:i64=0;var ol1:i64=0;var ort:i64=0;if selected[27]>=0{os00=jj_n_offset_for_pc(program,start,end,argc,selected[27]);}if selected[28]>=0{os01=jj_n_offset_for_pc(program,start,end,argc,selected[28]);}if selected[29]>=0{os10=jj_n_offset_for_pc(program,start,end,argc,selected[29]);}if selected[30]>=0{os11=jj_n_offset_for_pc(program,start,end,argc,selected[30]);}ol0=jj_n_offset_for_pc(program,start,end,argc,selected[23]);if values==2{ol1=jj_n_offset_for_pc(program,start,end,argc,selected[24]);}ort=jj_n_offset_for_pc(program,start,end,argc,selected[26]);if ol0<0{return jj_xcfg_fail(ctx,(76144<<32)|(selected[23]&0xffffffff),0)-1;}if values==2{if ol1<0{return jj_xcfg_fail(ctx,(76144<<32)|(selected[24]&0xffffffff),0)-1;}}
 if mode==1{if os00<0{return jj_xcfg_fail(ctx,(76144<<32)|(selected[27]&0xffffffff),0)-1;}if os10<0{return jj_xcfg_fail(ctx,(76144<<32)|(selected[29]&0xffffffff),0)-1;}if ort<0{return jj_xcfg_fail(ctx,(76144<<32)|(selected[26]&0xffffffff),0)-1;}if jj_xcfg_add_action(ctx,(physical0<<56)|(local0<<48)|(p0<<40)|(1<<32)|(selected[27]&0xffffffff),os00)==0{return 0-1;}if jj_xcfg_add_action(ctx,(physical0<<56)|(local0<<48)|(p1<<40)|(1<<32)|(selected[29]&0xffffffff),os10)==0{return 0-1;}if jj_xcfg_add_action(ctx,(physical0<<56)|(local0<<48)|(join_index<<40)|(2<<32)|(selected[23]&0xffffffff),ol0)==0{return 0-1;}if jj_xcfg_add_action(ctx,(physical0<<56)|(local0<<48)|(join_index<<40)|(3<<32)|(selected[26]&0xffffffff),ort)==0{return 0-1;}}
 if mode==2{if os00<0{return jj_xcfg_fail(ctx,(76144<<32)|(selected[27]&0xffffffff),0)-1;}if jj_xcfg_add_action(ctx,(physical0<<56)|(local0<<48)|(p0<<40)|(4<<32)|(selected[27]&0xffffffff),os00)==0{return 0-1;}}
 if mode==3{if os00<0{return 0-1;}if os01<0{return 0-1;}if os10<0{return 0-1;}if os11<0{return 0-1;}if jj_xcfg_add_action(ctx,(physical0<<56)|(local0<<48)|(p0<<40)|(1<<32)|(selected[27]&0xffffffff),os00)==0{return 0-1;}if jj_xcfg_add_action(ctx,(physical1<<56)|(local1<<48)|(p0<<40)|(5<<32)|(selected[28]&0xffffffff),os01)==0{return 0-1;}if jj_xcfg_add_action(ctx,(physical0<<56)|(local0<<48)|(p1<<40)|(1<<32)|(selected[29]&0xffffffff),os10)==0{return 0-1;}if jj_xcfg_add_action(ctx,(physical1<<56)|(local1<<48)|(p1<<40)|(5<<32)|(selected[30]&0xffffffff),os11)==0{return 0-1;}if jj_xcfg_add_action(ctx,(physical0<<56)|(local0<<48)|(join_index<<40)|(6<<32)|(selected[23]&0xffffffff),ol0)==0{return 0-1;}if jj_xcfg_add_action(ctx,(physical1<<56)|(local1<<48)|(join_index<<40)|(7<<32)|(selected[24]&0xffffffff),ol1)==0{return 0-1;}}
 if mode==4{if os00<0{return 0-1;}if os01<0{return 0-1;}if jj_xcfg_add_action(ctx,(physical0<<56)|(local0<<48)|(p0<<40)|(4<<32)|(selected[27]&0xffffffff),os00)==0{return 0-1;}if jj_xcfg_add_action(ctx,(physical1<<56)|(local1<<48)|(p0<<40)|(8<<32)|(selected[28]&0xffffffff),os01)==0{return 0-1;}}
 if jj_xcfg_copy_ordinals(ctx)==0{return jj_xcfg_fail(ctx,(76145<<32)|(ctx[11]&0xffffffff),0)-1;}if jj_xcfg_hash_tables(ctx)==0{return jj_xcfg_fail(ctx,(76146<<32)|(ctx[11]&0xffffffff),0)-1;}ctx[18]=jj_xcfg_rot(ctx[15],ctx[16]^ctx[17]^mode^values^0x52554e373631);if ctx[18]==0{ctx[18]=1;}ctx[1]=1;ctx[28]=jj_xcfg_plan_seal(ctx);if jj_xcfg_valid(ctx)==0{return jj_xcfg_fail(ctx,(76146<<32)|(ctx[11]&0xffffffff),0)-1;}return mode;
}
fn jj_xcfg_emit_value(state:*i64,value:i64,size:i64)->i64{if state==0{return 0;}if state[10]==0{return 0;}return jj_codeseg_emit(state[10] as *i64,(((state as i64)+16) as *i64),value,size);}
fn jj_xcfg_verify_action(code:*i8,a:*i64,unused:i64)->i64{
 if code==0{return 0;}if a==0{return 0;}var at:i64=a[7];if at<0{return 0;}var kind:i64=a[1];var slot:i64=jj_xcfg_action_slot(a);if kind==1{if (code[at]&255)!=0x59{return 0;}var i:i64=1;while i<8{if (code[at+i]&255)!=0x90{return 0;}i=i+1;}return 1;}if kind==5{if (code[at]&255)!=0x5a{return 0;}var i5:i64=1;while i5<8{if (code[at+i5]&255)!=0x90{return 0;}i5=i5+1;}return 1;}
 if kind==2{if (code[at]&255)!=0x48{return 0;}if (code[at+1]&255)!=0x89{return 0;}if (code[at+2]&255)!=0xc8{return 0;}var j:i64=3;while j<6{if (code[at+j]&255)!=0x90{return 0;}j=j+1;}return 1;}if kind==6{if (code[at]&255)!=0x51{return 0;}var j6:i64=1;while j6<6{if (code[at+j6]&255)!=0x90{return 0;}j6=j6+1;}return 1;}if kind==7{if (code[at]&255)!=0x52{return 0;}var j7:i64=1;while j7<6{if (code[at+j7]&255)!=0x90{return 0;}j7=j7+1;}return 1;}
 if kind==3{if (code[at]&255)!=0xc9{return 0;}if (code[at+1]&255)!=0xc3{return 0;}if (code[at+2]&255)!=0x90{return 0;}return 1;}var d:i64=(0-(slot+1)*8)&0xffffffff;if kind==4{if (code[at]&255)!=0x59{return 0;}if (code[at+1]&255)!=0x48{return 0;}if (code[at+2]&255)!=0x89{return 0;}if (code[at+3]&255)!=0x8d{return 0;}var got4:i64=(code[at+4]&255)|((code[at+5]&255)<<8)|((code[at+6]&255)<<16)|((code[at+7]&255)<<24);if got4!=d{return 0;}return 1;}if kind==8{if (code[at]&255)!=0x5a{return 0;}if (code[at+1]&255)!=0x48{return 0;}if (code[at+2]&255)!=0x89{return 0;}if (code[at+3]&255)!=0x95{return 0;}var got8:i64=(code[at+4]&255)|((code[at+5]&255)<<8)|((code[at+6]&255)<<16)|((code[at+7]&255)<<24);if got8!=d{return 0;}return 1;}return 0;
}
// Returns 1 action emitted, 0 ordinary PC, -1 divergence.
fn jj_xcfg_emit(state:*i64,ctx:*i64,pc:i64)->i64{
 if state==0{return 0-1;}if jj_xcfg_valid(ctx)==0{return 0-1;}var cursor:i64=ctx[19];if cursor>=ctx[13]{return 0;}var a:*i64=jj_xcfg_action(ctx,cursor);if pc<a[0]{return 0;}if pc>a[0]{jj_xcfg_fail(ctx,(76121<<32)|(a[0]&0xffffffff),state[2]-ctx[25]);return 0-1;}var machine:i64=state[2]-ctx[25];if machine!=a[4]{jj_xcfg_fail(ctx,(76122<<32)|(pc&0xffffffff),machine);return 0-1;}a[7]=machine;var kind:i64=a[1];var slot:i64=jj_xcfg_action_slot(a);
 if kind==1{if jj_xcfg_emit_value(state,0x59,1)==0{return 0-1;}var i:i64=1;while i<8{if jj_xcfg_emit_value(state,0x90,1)==0{return 0-1;}i=i+1;}}if kind==5{if jj_xcfg_emit_value(state,0x5a,1)==0{return 0-1;}var i5:i64=1;while i5<8{if jj_xcfg_emit_value(state,0x90,1)==0{return 0-1;}i5=i5+1;}}
 if kind==2{if jj_xcfg_emit_value(state,0x48,1)==0{return 0-1;}if jj_xcfg_emit_value(state,0x89,1)==0{return 0-1;}if jj_xcfg_emit_value(state,0xc8,1)==0{return 0-1;}var j:i64=3;while j<6{if jj_xcfg_emit_value(state,0x90,1)==0{return 0-1;}j=j+1;}}if kind==6{if jj_xcfg_emit_value(state,0x51,1)==0{return 0-1;}var j6:i64=1;while j6<6{if jj_xcfg_emit_value(state,0x90,1)==0{return 0-1;}j6=j6+1;}}if kind==7{if jj_xcfg_emit_value(state,0x52,1)==0{return 0-1;}var j7:i64=1;while j7<6{if jj_xcfg_emit_value(state,0x90,1)==0{return 0-1;}j7=j7+1;}}
 if kind==3{if jj_xcfg_emit_value(state,0xc9,1)==0{return 0-1;}if jj_xcfg_emit_value(state,0xc3,1)==0{return 0-1;}if jj_xcfg_emit_value(state,0x90,1)==0{return 0-1;}}if kind==4{if jj_xcfg_emit_value(state,0x59,1)==0{return 0-1;}if jj_xcfg_emit_value(state,0x48,1)==0{return 0-1;}if jj_xcfg_emit_value(state,0x89,1)==0{return 0-1;}if jj_xcfg_emit_value(state,0x8d,1)==0{return 0-1;}if jj_xcfg_emit_value(state,0-(slot+1)*8,4)==0{return 0-1;}}if kind==8{if jj_xcfg_emit_value(state,0x5a,1)==0{return 0-1;}if jj_xcfg_emit_value(state,0x48,1)==0{return 0-1;}if jj_xcfg_emit_value(state,0x89,1)==0{return 0-1;}if jj_xcfg_emit_value(state,0x95,1)==0{return 0-1;}if jj_xcfg_emit_value(state,0-(slot+1)*8,4)==0{return 0-1;}}
 var code:*i8=(state[0] as *i8)+ctx[25];if jj_xcfg_verify_action(code,a,0)==0{jj_xcfg_fail(ctx,(76123<<32)|(pc&0xffffffff),machine);return 0-1;}ctx[19]=cursor+1;ctx[20]=jj_xcfg_rot(ctx[20]^0x4a4a58454d4955,a[0]^a[1]^a[3]^a[4]^a[7]);return 1;
}
fn jj_xcfg_emission_valid(ctx:*i64)->i64{
 if jj_xcfg_valid(ctx)==0{return 0;}if ctx[19]!=ctx[13]{return 0;}var h:i64=0;var i:i64=0;while i<ctx[13]{var a:*i64=jj_xcfg_action(ctx,i);if a[7]!=a[4]{return 0;}h=jj_xcfg_rot(h^0x4a4a58454d4955,a[0]^a[1]^a[3]^a[4]^a[7]);i=i+1;}if h!=ctx[20]{return 0;}ctx[24]=jj_xcfg_rot(ctx[18],h^ctx[13]^ctx[10]);if ctx[24]==0{ctx[24]=1;}return ctx[24];
}
fn jj_xcfg_region_count(ctx:*i64)->i64{if jj_xcfg_valid(ctx)==0{return 0;}return ctx[14];}
// low32 old offset, bits32..39 old length, bits40..47 new length, bits48..55 action index+1.
fn jj_xcfg_region(ctx:*i64,ordinal:i64)->i64{
 if jj_xcfg_valid(ctx)==0{return 0;}if ordinal<0{return 0;}if ordinal>=ctx[14]{return 0;}var found:i64=0;var i:i64=0;while i<ctx[13]{var a:*i64=jj_xcfg_action(ctx,i);if a[6]<a[5]{if found==ordinal{return (a[4]&0xffffffff)|((a[5]&255)<<32)|((a[6]&255)<<40)|(((i+1)&255)<<48);}found=found+1;}i=i+1;}return 0;
}
fn jj_xcfg_region_valid(code:*i8,ctx:*i64,ordinal:i64)->i64{var p:i64=jj_xcfg_region(ctx,ordinal);if p==0{return 0;}var ai:i64=((p>>>48)&255)-1;if ai<0{return 0;}return jj_xcfg_verify_action(code,jj_xcfg_action(ctx,ai),0);}
fn jj_xcfg_compact_region_valid(code:*i8,ctx:*i64,ordinal:i64)->i64{
 if code==0{return 0;}var p:i64=jj_xcfg_region(ctx,ordinal);if p==0{return 0;}var ai:i64=((p>>>48)&255)-1;if ai<0{return 0;}var a:*i64=jj_xcfg_action(ctx,ai);var kind:i64=a[1];if kind==1{if (code[0]&255)!=0x59{return 0;}return 1;}if kind==5{if (code[0]&255)!=0x5a{return 0;}return 1;}if kind==2{if (code[0]&255)!=0x48{return 0;}if (code[1]&255)!=0x89{return 0;}if (code[2]&255)!=0xc8{return 0;}return 1;}if kind==6{if (code[0]&255)!=0x51{return 0;}return 1;}if kind==7{if (code[0]&255)!=0x52{return 0;}return 1;}if kind==3{if (code[0]&255)!=0xc9{return 0;}if (code[1]&255)!=0xc3{return 0;}return 1;}return 0;
}
fn jj_xcfg_region_pc(ctx:*i64,ordinal:i64)->i64{var p:i64=jj_xcfg_region(ctx,ordinal);if p==0{return 0-1;}var ai:i64=((p>>>48)&255)-1;if ai<0{return 0-1;}var a:*i64=jj_xcfg_action(ctx,ai);return a[0];}
