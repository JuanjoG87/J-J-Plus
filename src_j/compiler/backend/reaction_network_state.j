// reaction network bounded ReactionNetwork state and decode helpers.
fn jj_rb_shift_modrm(op:i64)->i64{if op==14{return 0xe1;}if op==15{return 0xf9;}if op==37{return 0xe9;}return 0;}
fn jj_rb_read_imm(program:*i8,pc:i64)->i64{var value:i64=0;var i:i64=0;while i<8{value=value|((program[pc+1+i]&255)<<(i*8));i=i+1;}return value;}
fn jj_rb_slot(program:*i8,pc:i64)->i64{return (program[pc+1]&255)|((program[pc+2]&255)<<8);}
fn jj_rb_binary_valid(op:i64)->i64{if op==9{return 1;}if op==10{return 1;}if op==11{return 1;}if op==16{return 1;}if op==17{return 1;}if op==18{return 1;}return 0;}
fn jj_rc_history_init(h:*i64)->i64{if h==0{return 0;}h[0]=0;return 1;}
fn jj_rc_history_get(h:*i64,index:i64)->i64{
 if h==0{return 0-1;}if index<0{return 0-1;}if index>=105{return 0-1;}var header:i64=h[0];var head:i64=header&255;var count:i64=(header>>>8)&255;if head>=15{return 0-1;}if count>15{return 0-1;}var record:i64=index/7;var field:i64=index%7;var empty:i64=15-count;if record<empty{return 0-1;}var oldest:i64=head-count;while oldest<0{oldest=oldest+15;}var physical:i64=(oldest+(record-empty))%15;return h[1+physical*7+field];
}
fn jj_rc_history_push(h:*i64,op:i64,pc:i64,machine:i64,target:i64,s:*i64)->i64{
 if h==0{return 0;}if s==0{return 0;}var header:i64=h[0];var head:i64=header&255;var count:i64=(header>>>8)&255;if head>=15{return 0;}if count>15{return 0;}var at:i64=1+head*7;h[at]=op;h[at+1]=pc;h[at+2]=machine;h[at+3]=target;h[at+4]=s[0];h[at+5]=s[1];h[at+6]=s[2];head=head+1;if head==15{head=0;}if count<15{count=count+1;}h[0]=head|(count<<8);return 1;
}
fn jj_rc_history_view4(h:*i64,index:i64,base:i64,limit:i64)->i64{if h==0{return 0-1;}if index<0{return 0-1;}if index>=limit{return 0-1;}var record:i64=index/4;var field:i64=index%4;return jj_rc_history_get(h,(base+record)*7+field);}
fn jj_rc_r16_get(h:*i64,index:i64)->i64{return jj_rc_history_view4(h,index,10,20);}
fn jj_rc_mto_get(h:*i64,index:i64)->i64{return jj_rc_history_view4(h,index,11,16);}
fn jj_rc_affine_get(h:*i64,index:i64)->i64{return jj_rc_history_view4(h,index,4,44);}
