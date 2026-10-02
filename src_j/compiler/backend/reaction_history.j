// reaction history bounded Reaction16 pocket with Number of Reactive Demand (NDR).
extern fn jj_rc_r16_get(p0:*i64,p1:i64)->i64;
// The pocket is derived from five consecutive bytecode operations before the
// final machine interval is committed. It preserves the original byte count.
extern fn jj_reo_wr32(p0:*i8,p1:i64)->i64;
extern fn jj_reo_nop(p0:*i8,p1:i64,p2:i64)->i64;

fn jj_r16_binary_bytes(code:*i8,at:i64,op:i64)->i64{
  if op==9{code[at]=0x48;code[at+1]=0x01;code[at+2]=0xc8;return 3;}
  if op==10{code[at]=0x48;code[at+1]=0x29;code[at+2]=0xc8;return 3;}
  if op==11{code[at]=0x48;code[at+1]=0x0f;code[at+2]=0xaf;code[at+3]=0xc1;return 4;}
  if op==16{code[at]=0x48;code[at+1]=0x21;code[at+2]=0xc8;return 3;}
  if op==17{code[at]=0x48;code[at+1]=0x09;code[at+2]=0xc8;return 3;}
  if op==18{code[at]=0x48;code[at+1]=0x31;code[at+2]=0xc8;return 3;}
  return 0;
}

fn jj_r16_self_shift(code:*i8,begin:i64,end:i64,slot:i64,descriptor:i64,targets:i64)->i64{
  if code==0{return 0;}if begin<0{return 0;}if end<=begin{return 0;}if slot<0{return 0;}if slot>32767{return 0;}if targets!=0{return 0;}
  var shift_op:i64=descriptor&255;var binary_op:i64=(descriptor>>>8)&255;var amount:i64=(descriptor>>>16)&255;
  if amount>=64{return 0;}var expected:i64=45;if binary_op==11{expected=46;}if end-begin!=expected{return 0;}
  var shift_modrm:i64=0;if shift_op==14{shift_modrm=0xe1;}else{if shift_op==15{shift_modrm=0xf9;}else{if shift_op==37{shift_modrm=0xe9;}else{return 0;}}}
  var at:i64=begin;code[at]=0x48;code[at+1]=0x8b;code[at+2]=0x85;if jj_reo_wr32(code+at+3,0-((slot+1)*8))==0{return 0;}at=at+7;
  code[at]=0x48;code[at+1]=0x89;code[at+2]=0xc1;at=at+3;
  code[at]=0x48;code[at+1]=0xc1;code[at+2]=shift_modrm;code[at+3]=amount;at=at+4;
  var used:i64=jj_r16_binary_bytes(code,at,binary_op);if used==0{return 0;}at=at+used;code[at]=0x50;at=at+1;
  if end-at<5{return 0;}if jj_reo_nop(code,at,end-5)==0{return 0;}
  code[end-5]=0x0f;code[end-4]=0x1f;code[end-3]=0x44;code[end-2]=0x00;code[end-1]=0x53;
  return 2;
}

fn jj_r16_try_history(code:*i8,end:i64,program:*i8,history:*i64,receipt:*i64,reo_receipt:*i64)->i64{
  if code==0{return 0-1;}if program==0{return 0-1;}if history==0{return 0-1;}if receipt==0{return 0-1;}if reo_receipt==0{return 0-1;}
  if jj_rc_r16_get(history,0)!=2{return 0;}if jj_rc_r16_get(history,4)!=2{return 0;}if jj_rc_r16_get(history,8)!=1{return 0;}
  var shift_op:i64=jj_rc_r16_get(history,12);var binary_op:i64=jj_rc_r16_get(history,16);
  if shift_op!=14{if shift_op!=15{if shift_op!=37{return 0;}}}
  if binary_op!=9{if binary_op!=10{if binary_op!=11{if binary_op!=16{if binary_op!=17{if binary_op!=18{return 0;}}}}}}
  var targets:i64=jj_rc_r16_get(history,3)|jj_rc_r16_get(history,7)|jj_rc_r16_get(history,11)|jj_rc_r16_get(history,15)|jj_rc_r16_get(history,19);if targets!=0{return 0;}
  var first_pc:i64=jj_rc_r16_get(history,1);var second_pc:i64=jj_rc_r16_get(history,5);var constant_pc:i64=jj_rc_r16_get(history,9);if first_pc<0{return 0-1;}if second_pc<0{return 0-1;}if constant_pc<0{return 0-1;}
  var slot_a:i64=(program[first_pc+1]&255)|((program[first_pc+2]&255)<<8);var slot_b:i64=(program[second_pc+1]&255)|((program[second_pc+2]&255)<<8);if slot_a!=slot_b{return 0;}
  var amount:i64=0;var i:i64=0;while i<8{amount=amount|((program[constant_pc+1+i]&255)<<(i*8));i=i+1;}if amount<0{return 0;}if amount>=64{return 0;}
  var descriptor:i64=shift_op|(binary_op<<8)|(amount<<16);var ndr:i64=jj_r16_self_shift(code,jj_rc_r16_get(history,2),end,slot_a,descriptor,targets);if ndr==0{return 0;}
  var packed:i64=receipt[0];var count:i64=(packed>>>16)&65535;var fingerprint:i64=(packed>>>32)&65535;var ndr_total:i64=(packed>>>48)&65535;var old_reom:i64=packed&65535;
  var reo_packed:i64=reo_receipt[0];var old_shift:i64=(reo_packed>>>32)&65535;if old_reom==0{return 0-1;}if old_shift==0{return 0-1;}
  if count>=65535{return 0-1;}if ndr_total>65533{return 0-1;}var disp16:i64=(0-((slot_a+1)*8))&65535;var token:i64=(shift_op*257+binary_op*17+amount*3+disp16)&65535;fingerprint=(fingerprint*257+token)&65535;ndr_total=ndr_total+2;
  packed=(packed-1+(1<<16))&0x00000000ffffffff;packed=packed|(fingerprint<<32)|(ndr_total<<48);receipt[0]=packed;reo_receipt[0]=reo_packed-(1<<32);return 1;
}
