// x86 publication diagnostics and ABI receipt phase.
// Integration-hub partition R764: concrete work lives in focused phases.
// canonical interface_EXTERN_PROTOTYPES_BEGIN
extern fn jj_core_function_field(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_ast16_source_node_for_pc(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_ast16_source_provenance_for_pc(p0:*i64,p1:i64,p2:i64)->i64;
extern fn jj_target_signature_type(p0:i64)->i64;
extern fn jj_target_value_bits(p0:i64,p1:i64)->i64;
// canonical interface_EXTERN_PROTOTYPES_END
fn jj_x86_diag_seal(report:*i64)->i64{return (report as i64)^report[0]^report[1]^report[2]^report[3]^report[4]^report[5]^report[6]^0x4a4a444941475332;}
fn jj_x86_where(function_id:i64,pc:i64,machine:i64)->i64{var f:i64=0;if function_id>=0{f=function_id+1;if f>65535{f=65535;}}if pc<0{pc=0;}if pc>0xffffff{pc=0xffffff;}if machine<0{machine=0;}if machine>0xffffff{machine=0xffffff;}return f|((pc&0xffffff)<<16)|((machine&0xffffff)<<40);}
fn jj_x86_diag(report:*i64,kind:i64,where:i64)->i64{
  if report==0{return 0;}var core:*i64=report[6] as *i64;var f:i64=where&65535;var pc:i64=(where>>>16)&0xffffff;var packed:i64=0xffffffff;var source_length:i64=0;var source_node:i64=0;
  var origin_kind:i64=0;var origin_pc:i64=0;if core!=0{source_length=core[1];if f>0{var function_id:i64=f-1;var start:i64=jj_core_function_field(core,function_id,0);var length:i64=jj_core_function_field(core,function_id,1);source_node=jj_ast16_source_node_for_pc(core,function_id,pc);if source_node>0xffffff{source_node=0xffffff;}var provenance:i64=jj_ast16_source_provenance_for_pc(core,function_id,pc);if provenance!=0{var span_start:i64=provenance&0xfffff;var span_length:i64=(provenance>>>20)&4095;origin_pc=(provenance>>>32)&0xffffff;origin_kind=(provenance>>>56)&15;if span_length>0{if span_start<source_length{start=span_start;length=span_length;}}}if length>0{if start>=0{if start<source_length{if start<=0xfffff{if length>4095{length=4095;}packed=(start&0xfffff)|((length&4095)<<20);}}}}}}
  report[0]=0x4a4a444941473032;report[1]=kind&65535;report[2]=kind>>>16;report[3]=f|((origin_kind&255)<<16)|((source_node&0xffffff)<<40);report[4]=pc;report[5]=((where>>>40)&0xffffff)|((origin_pc&0xffffff)<<24);report[6]=(source_length<<32)|packed;report[7]=jj_x86_diag_seal(report);return 1;
}
fn jj_x86_diag_lineage(report:*i64,lineage:i64)->i64{
 if report==0{return 0;}if report[0]!=0x4a4a444941473032{return 0;}if lineage==0{return 1;}var pass:i64=lineage&4095;var mode:i64=(lineage>>>12)&15;var original:i64=(lineage>>>16)&255;var replacement:i64=(lineage>>>24)&255;var ordinal:i64=(lineage>>>32)&255;var copies:i64=(lineage>>>40)&255;
 var low:i64=report[3]&0xffffff;var high:i64=(report[3]>>>40)&0xffffff;report[3]=low|((pass&4095)<<24)|((mode&15)<<36)|(high<<40);report[4]=(report[4]&0xffffff)|((original&255)<<24)|((replacement&255)<<32)|((ordinal&255)<<40)|((copies&255)<<48);report[7]=jj_x86_diag_seal(report);return 1;
}

fn jj_target_x64_abi_receipt(sig:i64,argc:i64)->i64{
  if argc<0{return 0;}if argc>6{return 0;}
  if (sig>>>((argc+1)*4))!=0x120+argc{return 0;}
  var rt:i64=jj_target_signature_type((sig>>>(argc*4))&15);
  var rb:i64=jj_target_value_bits(5,rt);
  if rb==0{return 0;}
  var h:i64=0x4a4a583634414249^sig^(rb<<8);
  var i:i64=0;
  while i<argc{
    var t:i64=jj_target_signature_type((sig>>>((argc-1-i)*4))&15);
    var b:i64=jj_target_value_bits(5,t);
    if b==0{return 0;}
    var r:i64=0;
    if i==0{r=7;}else{if i==1{r=6;}else{if i==2{r=2;}else{if i==3{r=1;}else{if i==4{r=8;}else{r=9;}}}}}
    h=((h<<7)|(h>>>57))^t^(b<<8)^(i<<16)^(r<<24);i=i+1;
  }
  if h==0{return 1;}return h;
}
