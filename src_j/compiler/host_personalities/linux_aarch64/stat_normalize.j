// Pure Linux AArch64 asm-generic stat to canonical runtime layout normalization.
fn jj_aarch64_stat_rd32(p:*i8,o:i64)->i64{return (p[o]&255)|((p[o+1]&255)<<8)|((p[o+2]&255)<<16)|((p[o+3]&255)<<24);}
fn jj_aarch64_stat_rd64(p:*i8,o:i64)->i64{var lo:i64=jj_aarch64_stat_rd32(p,o);var hi:i64=jj_aarch64_stat_rd32(p,o+4);return lo|(hi<<32);}
fn jj_aarch64_stat_s32(p:*i8,o:i64)->i64{var v:i64=jj_aarch64_stat_rd32(p,o);if (v&0x80000000)!=0{return v|0xffffffff00000000;}return v;}
fn jj_aarch64_stat_wr32(p:*i8,o:i64,v:i64)->i64{p[o]=v;p[o+1]=v>>>8;p[o+2]=v>>>16;p[o+3]=v>>>24;return 1;}
fn jj_aarch64_stat_wr64(p:*i8,o:i64,v:i64)->i64{if jj_aarch64_stat_wr32(p,o,v)==0{return 0;}return jj_aarch64_stat_wr32(p,o+4,v>>>32);}
fn jj_aarch64_stat_normalize(raw:*i8,out:*i8)->i64{
 if raw==0{return 0;}if out==0{return 0;}var i:i64=0;while i<144{out[i]=0;i=i+1;}
 if jj_aarch64_stat_wr64(out,0,jj_aarch64_stat_rd64(raw,0))==0{return 0;}
 if jj_aarch64_stat_wr64(out,8,jj_aarch64_stat_rd64(raw,8))==0{return 0;}
 if jj_aarch64_stat_wr64(out,16,jj_aarch64_stat_rd32(raw,20))==0{return 0;}
 if jj_aarch64_stat_wr32(out,24,jj_aarch64_stat_rd32(raw,16))==0{return 0;}
 if jj_aarch64_stat_wr32(out,28,jj_aarch64_stat_rd32(raw,24))==0{return 0;}
 if jj_aarch64_stat_wr32(out,32,jj_aarch64_stat_rd32(raw,28))==0{return 0;}
 if jj_aarch64_stat_wr64(out,40,jj_aarch64_stat_rd64(raw,32))==0{return 0;}
 if jj_aarch64_stat_wr64(out,48,jj_aarch64_stat_rd64(raw,48))==0{return 0;}
 if jj_aarch64_stat_wr64(out,56,jj_aarch64_stat_s32(raw,56))==0{return 0;}
 if jj_aarch64_stat_wr64(out,64,jj_aarch64_stat_rd64(raw,64))==0{return 0;}
 if jj_aarch64_stat_wr64(out,72,jj_aarch64_stat_rd64(raw,72))==0{return 0;}
 if jj_aarch64_stat_wr64(out,80,jj_aarch64_stat_rd64(raw,80))==0{return 0;}
 if jj_aarch64_stat_wr64(out,88,jj_aarch64_stat_rd64(raw,88))==0{return 0;}
 if jj_aarch64_stat_wr64(out,96,jj_aarch64_stat_rd64(raw,96))==0{return 0;}
 if jj_aarch64_stat_wr64(out,104,jj_aarch64_stat_rd64(raw,104))==0{return 0;}
 if jj_aarch64_stat_wr64(out,112,jj_aarch64_stat_rd64(raw,112))==0{return 0;}return 1;
}
