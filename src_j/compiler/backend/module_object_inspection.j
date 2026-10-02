// on-demand inspection companion; excluded from resident selfhost closures.

fn jj_obj_zero(out:*i8,count:i64)->i64{if out==0{return 0;}if count<0{return 0;}var i:i64=0;while i<count{out[i]=0;i=i+1;}return 1;}
