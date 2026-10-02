// R738 resource contract for the bounded x86-64 affine u64 load reaction.
fn jj_amo_resource_contract(out:*i64,n:i64)->i64{
 if out==0{return 0;}if n<12{return 0;}var i:i64=0;while i<12{out[i]=0;i=i+1;}
 out[0]=1; // x86-64 only
 out[1]=64; // load width
 out[2]=8; // exact scale
 out[3]=1; // constant offset
 out[4]=1; // local offset
 out[5]=1; // addition
 out[6]=1; // subtraction
 out[7]=1; // exact bytecode/history verification
 out[8]=1; // exact machine-shape verification
 out[9]=1; // rejection leaves bytes unchanged
 out[10]=0; // stores not admitted
 out[11]=0; // other targets not admitted
 return 1;
}
