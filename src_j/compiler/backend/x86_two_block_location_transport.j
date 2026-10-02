// R758 bounded physical-location transport across one sealed conditional edge.
// RCX carries one value. No scratch register, heap, critical-edge split, Phi copy,
// cycle resolution, or hidden allocation is admitted.
extern fn jj_n_bc_len(p0:*i8,p1:i64,p2:i64)->i64;
extern fn jj_vm_rd16(p0:*i8)->i64;
extern fn jj_vm_rd32(p0:*i8)->i64;
extern fn jj_n_offset_for_pc(p0:*i8,p1:i64,p2:i64,p3:i64,p4:i64)->i64;
extern fn jj_reo_code_hash(p0:*i8,p1:i64)->i64;

fn jj_x2t_seal(ctx:*i64)->i64{
 if ctx==0{return 0;}
 var h:i64=(ctx as i64)^0x4a4a583254524e31;
 var i:i64=0;
 while i<23{h=((h<<7)|(h>>>57))^ctx[i]^(i<<41);i=i+1;}
 if h==0{return 1;}return h;
}
fn jj_x2t_valid(ctx:*i64)->i64{
 if ctx==0{return 0;}if ctx[0]!=0x4a4a583254524e31{return 0;}
 if ctx[1]!=1{return 0;}if ctx[23]!=jj_x2t_seal(ctx){return 0;}return 1;
}
fn jj_x2t_block_index(plan:*i64,pc:i64)->i64{
 if plan==0{return 0-1;}var n:i64=plan[2];var i:i64=0;
 while i<n{if plan[16+i*8]==pc{return i;}i=i+1;}return 0-1;
}
fn jj_x2t_physical(ctx:*i64,slot:i64)->i64{
 if slot<0{return 0-1;}if ctx[29]==0{return slot;}if slot>=64{return 0-1;}
 var map:*i64=ctx[28] as *i64;if map==0{return 0-1;}return map[slot];
}
fn jj_x2t_hash_program(program:*i8,start:i64,end:i64)->i64{
 if program==0{return 0;}var h:i64=0x4a4a583254424331^start^(end<<17);var pc:i64=start;
 while pc<end{var n:i64=jj_n_bc_len(program,pc,end);if n<=0{return 0;}var j:i64=0;
  while j<n{h=((h<<5)|(h>>>59))^(program[pc+j]&255)^((pc+j)<<23);j=j+1;}pc=pc+n;}
 if pc!=end{return 0;}if h==0{return 1;}return h;
}
fn jj_x2t_disp(slot:i64)->i64{return (0-(slot+1)*8)&0xffffffff;}
fn jj_x2t_nops(code:*i8,at:i64,n:i64)->i64{
 if code==0{return 0;}if at<0{return 0;}if n<0{return 0;}var i:i64=0;
 while i<n{code[at+i]=0x90;i=i+1;}return 1;
}

// probe input: [0]=block index. output [1..12] is one candidate.
fn jj_x2t_probe(program:*i8,plan:*i64,probe:*i64)->i64{
 if program==0{return 0-1;}if plan==0{return 0-1;}if probe==0{return 0-1;}
 var bi:i64=probe[0];if bi<0{return 0-1;}if bi>=plan[2]{return 0-1;}
 var b:i64=16+bi*8;var begin:i64=plan[b];var bend:i64=plan[b+1];var last:i64=plan[b+2];
 if last<begin{return 0;}if (program[last]&255)!=28{return 0;}if plan[b+4]!=bend{return 0;}
 var si:i64=jj_x2t_block_index(plan,bend);if si<0{return 0-1;}var sb:i64=16+si*8;
 if plan[sb+5]!=1{return 0;}var spc:i64=bend;var send:i64=plan[sb+1];
 var sn:i64=jj_n_bc_len(program,spc,send);if sn!=3{return 0;}if (program[spc]&255)!=2{return 0;}
 var retpc:i64=spc+sn;var rn:i64=jj_n_bc_len(program,retpc,send);if rn!=1{return 0;}
 if (program[retpc]&255)!=30{return 0;}if retpc+rn!=send{return 0;}
 var p0:i64=0-1;var p1:i64=0-1;var p2:i64=0-1;var walk:i64=begin;
 while walk<bend{p2=p1;p1=p0;p0=walk;var wn:i64=jj_n_bc_len(program,walk,bend);if wn<=0{return 0-1;}walk=walk+wn;}
 if walk!=bend{return 0-1;}if p0!=last{return 0;}if p1<begin{return 0;}if p2<begin{return 0;}
 if (program[p1]&255)!=2{return 0;}if (program[p2]&255)!=3{return 0;}
 var local:i64=jj_vm_rd16(program+p2+1);var cond:i64=jj_vm_rd16(program+p1+1);
 if local!=jj_vm_rd16(program+spc+1){return 0;}if local==cond{return 0;}
 probe[1]=p2;probe[2]=p1;probe[3]=last;probe[4]=spc;probe[5]=begin;probe[6]=bend;
 probe[7]=plan[sb];probe[8]=send;probe[9]=local;probe[10]=cond;probe[11]=plan[b+3];probe[12]=plan[b+4];
 return 1;
}

// Input fields supplied in ctx: 24=start,25=end,26=argc,27=locals,
// 28=physical-map pointer,29=map mode,30=old machine size.
fn jj_x2t_prepare(program:*i8,plan:*i64,ctx:*i64)->i64{
 if program==0{return 0-1;}if plan==0{return 0-1;}if ctx==0{return 0-1;}
 var start:i64=ctx[24];var end:i64=ctx[25];var argc:i64=ctx[26];var locals:i64=ctx[27];var old_size:i64=ctx[30];
 if start<0{return 0-1;}if end<=start{return 0-1;}if argc<0{return 0-1;}if locals<argc{return 0-1;}
 if old_size<=0{return 0-1;}if plan[0]!=0x4a4a42504c414e31{return 0-1;}if plan[1]!=1{return 0;}
 var blocks:i64=plan[2];if blocks<2{return 0;}if blocks>16{return 0;}
 var probe:*i64=((ctx as i64)+34*8) as *i64;var candidate:i64=0;var bi:i64=0;
 while bi<blocks{probe[0]=bi;var status:i64=jj_x2t_probe(program,plan,probe);if status<0{return 0-1;}
  if status!=0{candidate=candidate+1;if candidate>1{return 0;}
   var k:i64=1;while k<=12{ctx[34+k]=probe[k];k=k+1;}}
  bi=bi+1;}
 if candidate==0{return 0;}var selected:*i64=((ctx as i64)+35*8) as *i64;
 var store_pc:i64=selected[0];var cond_pc:i64=selected[1];var branch_pc:i64=selected[2];var load_pc:i64=selected[3];
 var local:i64=selected[8];var cond_local:i64=selected[9];if local<argc{return 0;}if local>=locals{return 0;}if cond_local>=locals{return 0;}
 var refs:i64=0;var stores:i64=0;var loads:i64=0;var pc:i64=start;
 while pc<end{var n:i64=jj_n_bc_len(program,pc,end);if n<=0{return 0-1;}var op:i64=program[pc]&255;
  if op==2{if jj_vm_rd16(program+pc+1)==local{loads=loads+1;refs=refs+1;}}
  if op==3{if jj_vm_rd16(program+pc+1)==local{stores=stores+1;refs=refs+1;}}
  if op==4{var a:i64=jj_vm_rd16(program+pc+1);var ar:i64=jj_vm_rd16(program+pc+3);if local>=a{if local<a+ar{return 0;}}}
  pc=pc+n;}
 if pc!=end{return 0-1;}if refs!=2{return 0;}if stores!=1{return 0;}if loads!=1{return 0;}
 var physical:i64=jj_x2t_physical(ctx,local);var cond_physical:i64=jj_x2t_physical(ctx,cond_local);
 if physical<0{return 0-1;}if cond_physical<0{return 0-1;}if physical==cond_physical{return 0;}
 var store_rel:i64=jj_n_offset_for_pc(program,start,end,argc,store_pc);var cond_rel:i64=jj_n_offset_for_pc(program,start,end,argc,cond_pc);
 var branch_rel:i64=jj_n_offset_for_pc(program,start,end,argc,branch_pc);var load_rel:i64=jj_n_offset_for_pc(program,start,end,argc,load_pc);
 if store_rel<0{return 0-1;}if cond_rel!=store_rel+8{return 0;}if branch_rel!=cond_rel+6{return 0;}
 if load_rel!=branch_rel+10{return 0;}if load_rel+6>old_size{return 0-1;}
 var z:i64=0;while z<24{ctx[z]=0;z=z+1;}
 ctx[0]=0x4a4a583254524e31;ctx[1]=1;ctx[2]=start;ctx[3]=end;ctx[4]=selected[4];ctx[5]=selected[5];
 ctx[6]=selected[6];ctx[7]=selected[7];ctx[8]=store_pc;ctx[9]=cond_pc;ctx[10]=branch_pc;ctx[11]=load_pc;
 ctx[12]=local;ctx[13]=cond_local;ctx[14]=physical;ctx[15]=cond_physical;ctx[16]=store_rel;ctx[17]=cond_rel;
 ctx[18]=branch_rel;ctx[19]=load_rel;ctx[20]=old_size;ctx[21]=jj_x2t_hash_program(program,start,end);ctx[22]=1;
 if ctx[21]==0{return 0-1;}ctx[23]=jj_x2t_seal(ctx);return 1;
}
fn jj_x2t_fail(ctx:*i64,packed:i64,machine:i64)->i64{
 if ctx!=0{ctx[31]=(packed>>>32)&0xffffffff;ctx[32]=packed&0xffffffff;ctx[33]=machine;}return 0;
}
fn jj_x2t_pattern(code:*i8,at:i64,ctx:*i64)->i64{
 if code==0{return 0;}if ctx==0{return 0;}var sd:i64=jj_x2t_disp(ctx[14]);var cd:i64=jj_x2t_disp(ctx[15]);
 if (code[at]&255)!=0x58{return 0;}if (code[at+1]&255)!=0x48{return 0;}if (code[at+2]&255)!=0x89{return 0;}
 if (code[at+3]&255)!=0x85{return 0;}if (jj_vm_rd32(code+at+4)&0xffffffff)!=sd{return 0;}
 var cm:i64=at+8;if (code[cm]&255)!=0x48{return 0;}if (code[cm+1]&255)!=0x8b{return 0;}
 if (code[cm+2]&255)!=0x85{return 0;}if (jj_vm_rd32(code+cm+3)&0xffffffff)!=cd{return 0;}
 var bm:i64=cm+7;if (code[bm]&255)!=0x48{return 0;}if (code[bm+1]&255)!=0x85{return 0;}
 if (code[bm+2]&255)!=0xc0{return 0;}if (code[bm+3]&255)!=0x0f{return 0;}if (code[bm+4]&255)!=0x84{return 0;}
 var lm:i64=bm+9;if (code[lm]&255)!=0x48{return 0;}if (code[lm+1]&255)!=0x8b{return 0;}
 if (code[lm+2]&255)!=0x85{return 0;}if (jj_vm_rd32(code+lm+3)&0xffffffff)!=sd{return 0;}
 if (code[lm+7]&255)!=0xc9{return 0;}if (code[lm+8]&255)!=0xc3{return 0;}return 1;
}
fn jj_x2t_apply(code:*i8,ctx:*i64)->i64{
 if code==0{return 0;}if jj_x2t_valid(ctx)==0{return 0;}ctx[31]=75802;ctx[32]=ctx[8];ctx[33]=0;
 var old_size:i64=ctx[20];if old_size<33{return jj_x2t_fail(ctx,(75802<<32)|((ctx[8])&0xffffffff),0);}
 var at:i64=0;var found:i64=0;var site:i64=0;
 while at+33<=old_size{if jj_x2t_pattern(code,at,ctx)!=0{found=found+1;site=at;}at=at+1;}
 if found==0{return jj_x2t_fail(ctx,(75803<<32)|((ctx[8])&0xffffffff),0);}if found!=1{return jj_x2t_fail(ctx,(75806<<32)|((ctx[8])&0xffffffff),site);}
 var lm:i64=site+24;var before:i64=jj_reo_code_hash(code,old_size);if before==0{return jj_x2t_fail(ctx,(75806<<32)|((ctx[8])&0xffffffff),site);}
 code[site]=0x59;if jj_x2t_nops(code,site+1,7)==0{return jj_x2t_fail(ctx,(75803<<32)|((ctx[8])&0xffffffff),site);}
 code[lm]=0x48;code[lm+1]=0x89;code[lm+2]=0xc8;if jj_x2t_nops(code,lm+3,4)==0{return jj_x2t_fail(ctx,(75805<<32)|((ctx[11])&0xffffffff),lm);}
 if (code[site]&255)!=0x59{return jj_x2t_fail(ctx,(75806<<32)|((ctx[8])&0xffffffff),site);}
 if (code[lm]&255)!=0x48{return jj_x2t_fail(ctx,(75806<<32)|((ctx[11])&0xffffffff),lm);}if (code[lm+1]&255)!=0x89{return jj_x2t_fail(ctx,(75806<<32)|((ctx[11])&0xffffffff),lm);}
 if (code[lm+2]&255)!=0xc8{return jj_x2t_fail(ctx,(75806<<32)|((ctx[11])&0xffffffff),lm);}var after:i64=jj_reo_code_hash(code,old_size);
 if after==0{return jj_x2t_fail(ctx,(75806<<32)|((ctx[11])&0xffffffff),lm);}if after==before{return jj_x2t_fail(ctx,(75806<<32)|((ctx[11])&0xffffffff),lm);}
 ctx[0]=0x4a4a583254524e31;ctx[1]=2;ctx[16]=site;ctx[17]=lm;ctx[21]=before;ctx[22]=after;ctx[23]=jj_x2t_seal(ctx);
 ctx[31]=0;ctx[32]=0;ctx[33]=0;return 1;
}
fn jj_x2t_applied_valid(ctx:*i64)->i64{
 if ctx==0{return 0;}if ctx[0]!=0x4a4a583254524e31{return 0;}if ctx[1]!=2{return 0;}
 if ctx[21]==0{return 0;}if ctx[22]==0{return 0;}if ctx[21]==ctx[22]{return 0;}
 if ctx[23]!=jj_x2t_seal(ctx){return 0;}return 1;
}
fn jj_x2t_resource_contract(out:*i64,n:i64)->i64{
 if out==0{return 0;}if n<12{return 0;}out[0]=47;out[1]=16;out[2]=4;out[3]=1;out[4]=0;out[5]=0;
 out[6]=3;out[7]=127;out[8]=75801;out[9]=75806;out[10]=0;out[11]=1;return 1;
}
