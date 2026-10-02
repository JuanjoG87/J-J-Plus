// Controlled-unroll admission only. No cloning is performed here.
// target_regs is the active target budget. i386 may supply a small budget as
// pressure evidence, but its register count is not the language-wide ceiling.
// loop=[simple,trip_known,body_nodes,calls,branches,peak_live,spills,code_bytes]
fn jj_unroll_admit(loop:*i64,factor:i64,target_regs:i64)->i64{
 if loop==0{return 0;}if factor!=2{if factor!=4{return 0;}}
 if target_regs<3{return 0;}if target_regs>64{return 0;}
 if loop[0]!=1{return 0;}if loop[1]!=1{return 0;}if loop[2]<=0{return 0;}if loop[2]>12{return 0;}
 if loop[3]!=0{return 0;}if loop[4]>1{return 0;}if loop[5]+factor-1>target_regs{return 0;}if loop[6]!=0{return 0;}
 var grown:i64=loop[7]*factor;if grown>192{return 0;}return 1;
}
fn jj_unroll_resource_contract(out:*i64,n:i64)->i64{if out==0{return 0;}if n<8{return 0;}out[0]=8;out[1]=4;out[2]=12;out[3]=192;out[4]=0;out[5]=0;out[6]=0;out[7]=0;return 1;}
