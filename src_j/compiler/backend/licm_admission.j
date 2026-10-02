// R721 LICM admission only. The caller must already have proved dominance and
// loop membership. This authority never moves code by itself.
// candidate=[pure,may_trap,has_call,load_kind,load_object,load_version]
// loop=[writes_external,writes_kind,writes_object,has_unknown_call,preheader,pressure_delta]
fn jj_licm_admit(candidate:*i64,loop:*i64)->i64{
 if candidate==0{return 0;}if loop==0{return 0;}
 if candidate[0]!=1{return 0;}if candidate[1]!=0{return 0;}if candidate[2]!=0{return 0;}
 if loop[4]!=1{return 0;}if loop[5]>0{return 0;}
 var kind:i64=candidate[3];if kind==0{return 1;}if kind<1{return 0;}if kind>3{return 0;}
 if loop[3]!=0{if kind!=1{return 0;}}
 if loop[0]!=0{if kind!=1{return 0;}}
 if loop[1]==kind{if loop[2]==candidate[4]{return 0;}}
 if candidate[5]<1{return 0;}return 1;
}
fn jj_licm_resource_contract(out:*i64,n:i64)->i64{if out==0{return 0;}if n<8{return 0;}out[0]=6;out[1]=6;out[2]=0;out[3]=0;out[4]=0;out[5]=0;out[6]=0;out[7]=0;return 1;}
