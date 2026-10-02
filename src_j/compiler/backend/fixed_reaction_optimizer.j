// fixed reaction Reduccion Estequiometrica Operacional: constant reaction pockets.
extern fn jj_rc_affine_get(p0:*i64,p1:i64)->i64;
fn jj_reo_rd64(p:*i8)->i64{var v:i64=0;var i:i64=0;while i<8{v=v|((p[i]&255)<<(i*8));i=i+1;}return v;}
fn jj_reo_wr32(p:*i8,v:i64)->i64{var i:i64=0;while i<4{p[i]=v>>>(i*8);i=i+1;}return 1;}
fn jj_reo_nop_unit(p:*i8,at:i64,n:i64)->i64{
  if n==1{p[at]=0x90;return 1;}if n==2{p[at]=0x66;p[at+1]=0x90;return 1;}if n==3{p[at]=0x0f;p[at+1]=0x1f;p[at+2]=0x00;return 1;}
  if n==4{p[at]=0x0f;p[at+1]=0x1f;p[at+2]=0x40;p[at+3]=0x00;return 1;}if n==5{p[at]=0x0f;p[at+1]=0x1f;p[at+2]=0x44;p[at+3]=0x00;p[at+4]=0x00;return 1;}
  if n==6{p[at]=0x66;p[at+1]=0x0f;p[at+2]=0x1f;p[at+3]=0x44;p[at+4]=0x00;p[at+5]=0x00;return 1;}
  if n==7{p[at]=0x0f;p[at+1]=0x1f;p[at+2]=0x80;p[at+3]=0;p[at+4]=0;p[at+5]=0;p[at+6]=0;return 1;}
  if n==8{p[at]=0x0f;p[at+1]=0x1f;p[at+2]=0x84;p[at+3]=0;p[at+4]=0;p[at+5]=0;p[at+6]=0;p[at+7]=0;return 1;}
  if n==9{p[at]=0x66;p[at+1]=0x0f;p[at+2]=0x1f;p[at+3]=0x84;p[at+4]=0;p[at+5]=0;p[at+6]=0;p[at+7]=0;p[at+8]=0;return 1;}return 0;
}
fn jj_reo_nop(p:*i8,begin:i64,end:i64)->i64{var at:i64=begin;while end-at>=9{if jj_reo_nop_unit(p,at,9)==0{return 0;}at=at+9;}if at<end{return jj_reo_nop_unit(p,at,end-at);}return 1;}
fn jj_reo_nop_unit_match(p:*i8,at:i64,n:i64)->i64{
  if p==0{return 0;}if at<0{return 0;}if n<=0{return 0;}if n>9{return 0;}
  if n==1{if (p[at]&255)!=0x90{return 0;}return 1;}
  if n==2{if (p[at]&255)!=0x66{return 0;}if (p[at+1]&255)!=0x90{return 0;}return 1;}
  if n==3{if (p[at]&255)!=0x0f{return 0;}if (p[at+1]&255)!=0x1f{return 0;}if (p[at+2]&255)!=0x00{return 0;}return 1;}
  if n==4{if (p[at]&255)!=0x0f{return 0;}if (p[at+1]&255)!=0x1f{return 0;}if (p[at+2]&255)!=0x40{return 0;}if (p[at+3]&255)!=0x00{return 0;}return 1;}
  if n==5{if (p[at]&255)!=0x0f{return 0;}if (p[at+1]&255)!=0x1f{return 0;}if (p[at+2]&255)!=0x44{return 0;}if (p[at+3]&255)!=0x00{return 0;}if (p[at+4]&255)!=0x00{return 0;}return 1;}
  if n==6{if (p[at]&255)!=0x66{return 0;}if (p[at+1]&255)!=0x0f{return 0;}if (p[at+2]&255)!=0x1f{return 0;}if (p[at+3]&255)!=0x44{return 0;}if (p[at+4]&255)!=0x00{return 0;}if (p[at+5]&255)!=0x00{return 0;}return 1;}
  if n==7{if (p[at]&255)!=0x0f{return 0;}if (p[at+1]&255)!=0x1f{return 0;}if (p[at+2]&255)!=0x80{return 0;}if (p[at+3]&255)!=0{return 0;}if (p[at+4]&255)!=0{return 0;}if (p[at+5]&255)!=0{return 0;}if (p[at+6]&255)!=0{return 0;}return 1;}
  if n==8{if (p[at]&255)!=0x0f{return 0;}if (p[at+1]&255)!=0x1f{return 0;}if (p[at+2]&255)!=0x84{return 0;}if (p[at+3]&255)!=0{return 0;}if (p[at+4]&255)!=0{return 0;}if (p[at+5]&255)!=0{return 0;}if (p[at+6]&255)!=0{return 0;}if (p[at+7]&255)!=0{return 0;}return 1;}
  if (p[at]&255)!=0x66{return 0;}if (p[at+1]&255)!=0x0f{return 0;}if (p[at+2]&255)!=0x1f{return 0;}if (p[at+3]&255)!=0x84{return 0;}if (p[at+4]&255)!=0{return 0;}if (p[at+5]&255)!=0{return 0;}if (p[at+6]&255)!=0{return 0;}if (p[at+7]&255)!=0{return 0;}if (p[at+8]&255)!=0{return 0;}return 1;
}
fn jj_reo_nop_match(p:*i8,begin:i64,end:i64)->i64{
  if p==0{return 0;}if begin<0{return 0;}if end<begin{return 0;}var at:i64=begin;while end-at>=9{if jj_reo_nop_unit_match(p,at,9)==0{return 0;}at=at+9;}if at<end{return jj_reo_nop_unit_match(p,at,end-at);}return 1;
}
fn jj_reo_stack_neutral_begin(code:*i8,previous:i64,current:i64)->i64{
  if code==0{return 0-1;}if previous<0{return 0-1;}if current<=previous{return 0-1;}if current-previous>64{return 0-1;}var pop:i64=code[current]&255;if pop<0x58{return 0-1;}if pop>0x5f{return 0-1;}var push:i64=pop-8;var at:i64=current-1;while at>=previous{if (code[at]&255)==push{if jj_reo_nop_match(code,at+1,current)!=0{return at;}}at=at-1;}return 0-1;
}
fn jj_reo_try_stack_neutral(code:*i8,previous:i64,current:i64)->i64{
  var begin:i64=jj_reo_stack_neutral_begin(code,previous,current);if begin<0{return 0;}if jj_reo_nop(code,begin,current+1)==0{return 0-1;}return current+1-begin;
}


// R719 bounded affine history. Eleven exact bytecode operations are retained as
// four-word records: opcode, bytecode pc, machine offset, target census.
fn jj_reo_affine_s32(v:i64)->i64{var lo:i64=v&0xffffffff;if lo>=0x80000000{return lo-0x100000000;}return lo;}
fn jj_reo_affine_disp_valid(d:i64)->i64{if d>=0{return 0;}if (0-d)%8!=0{return 0;}return 1;}
fn jj_reo_affine_legacy_shape(code:*i8,begin:i64,end:i64)->i64{
  if code==0{return 0;}if begin<0{return 0;}if end-begin!=79{return 0;}var p:*i8=code+begin;
  if p[0]!=0x48{return 0;}if (p[1]&255)!=0x8b{return 0;}if (p[2]&255)!=0x85{return 0;}
  if p[7]!=0x48{return 0;}if (p[8]&255)!=0x69{return 0;}if (p[9]&255)!=0xc0{return 0;}if jj_reo_rd64(p+10)&0xffffffff!=10{return 0;}if p[14]!=0x50{return 0;}
  if jj_reo_nop_match(p,15,24)==0{return 0;}
  if p[24]!=0x48{return 0;}if (p[25]&255)!=0x8b{return 0;}if (p[26]&255)!=0x85{return 0;}
  if p[31]!=0x48{return 0;}if (p[32]&255)!=0x8b{return 0;}if (p[33]&255)!=0x8d{return 0;}
  if p[38]!=0x48{return 0;}if p[39]!=0x01{return 0;}if (p[40]&255)!=0xc8{return 0;}if jj_reo_nop_match(p,41,43)==0{return 0;}
  if p[43]!=0x48{return 0;}if p[44]!=0x0f{return 0;}if (p[45]&255)!=0xb6{return 0;}if p[46]!=0x00{return 0;}if p[47]!=0x50{return 0;}if p[48]!=0x58{return 0;}
  if p[49]!=0x48{return 0;}if (p[50]&255)!=0x81{return 0;}if (p[51]&255)!=0xe8{return 0;}if (jj_reo_rd64(p+52)&0xffffffff)!=48{return 0;}if p[56]!=0x50{return 0;}
  if jj_reo_nop_match(p,57,65)==0{return 0;}if p[65]!=0x59{return 0;}if p[66]!=0x58{return 0;}if p[67]!=0x48{return 0;}if p[68]!=0x01{return 0;}if (p[69]&255)!=0xc8{return 0;}if jj_reo_nop_match(p,70,72)==0{return 0;}
  if p[72]!=0x48{return 0;}if (p[73]&255)!=0x89{return 0;}if (p[74]&255)!=0x85{return 0;}
  var acc:i64=jj_reo_affine_s32((p[3]&255)|((p[4]&255)<<8)|((p[5]&255)<<16)|((p[6]&255)<<24));
  var base:i64=jj_reo_affine_s32((p[27]&255)|((p[28]&255)<<8)|((p[29]&255)<<16)|((p[30]&255)<<24));
  var index:i64=jj_reo_affine_s32((p[34]&255)|((p[35]&255)<<8)|((p[36]&255)<<16)|((p[37]&255)<<24));
  var store:i64=jj_reo_affine_s32((p[75]&255)|((p[76]&255)<<8)|((p[77]&255)<<16)|((p[78]&255)<<24));
  if jj_reo_affine_disp_valid(acc)==0{return 0;}if jj_reo_affine_disp_valid(base)==0{return 0;}if jj_reo_affine_disp_valid(index)==0{return 0;}if store!=acc{return 0;}if acc==base{return 0;}if acc==index{return 0;}if base==index{return 0;}return 1;
}
fn jj_reo_try_affine_decimal(code:*i8,end:i64,program:*i8,history:*i64)->i64{
  if code==0{return 0-1;}if program==0{return 0-1;}if history==0{return 0-1;}if end<=0{return 0-1;}
  var ops:[11]i64;ops[0]=2;ops[1]=1;ops[2]=11;ops[3]=2;ops[4]=2;ops[5]=9;ops[6]=5;ops[7]=1;ops[8]=10;ops[9]=9;ops[10]=3;
  var machines:[11]i64;machines[0]=0;machines[1]=6;machines[2]=17;machines[3]=24;machines[4]=30;machines[5]=36;machines[6]=42;machines[7]=48;machines[8]=59;machines[9]=65;machines[10]=71;
  var begin:i64=jj_rc_affine_get(history,2);if begin<0{return 0;}var i:i64=0;while i<11{var at:i64=i*4;if jj_rc_affine_get(history,at)!=ops[i]{return 0;}if jj_rc_affine_get(history,at+1)<0{return 0;}if jj_rc_affine_get(history,at+2)!=begin+machines[i]{return 0;}if jj_rc_affine_get(history,at+3)!=0{return 0;}i=i+1;}
  if end-begin!=79{return 0;}var pc0:i64=jj_rc_affine_get(history,1);var pc1:i64=jj_rc_affine_get(history,5);var pc3:i64=jj_rc_affine_get(history,13);var pc4:i64=jj_rc_affine_get(history,17);var pc7:i64=jj_rc_affine_get(history,29);var pc10:i64=jj_rc_affine_get(history,41);
  if program[pc0]!=2{return 0;}if program[pc1]!=1{return 0;}if program[pc3]!=2{return 0;}if program[pc4]!=2{return 0;}if program[pc7]!=1{return 0;}if program[pc10]!=3{return 0;}
  var acc_slot:i64=(program[pc0+1]&255)|((program[pc0+2]&255)<<8);var base_slot:i64=(program[pc3+1]&255)|((program[pc3+2]&255)<<8);var index_slot:i64=(program[pc4+1]&255)|((program[pc4+2]&255)<<8);var store_slot:i64=(program[pc10+1]&255)|((program[pc10+2]&255)<<8);
  if acc_slot!=store_slot{return 0;}if acc_slot==base_slot{return 0;}if acc_slot==index_slot{return 0;}if base_slot==index_slot{return 0;}if jj_reo_rd64(program+pc1+1)!=10{return 0;}if jj_reo_rd64(program+pc7+1)!=48{return 0;}
  if jj_reo_affine_legacy_shape(code,begin,end)==0{return 0;}var p:*i8=code+begin;var acc:i64=(p[3]&255)|((p[4]&255)<<8)|((p[5]&255)<<16)|((p[6]&255)<<24);var base:i64=(p[27]&255)|((p[28]&255)<<8)|((p[29]&255)<<16)|((p[30]&255)<<24);var index:i64=(p[34]&255)|((p[35]&255)<<8)|((p[36]&255)<<16)|((p[37]&255)<<24);
  p[0]=0x48;p[1]=0x8b;p[2]=0x85;jj_reo_wr32(p+3,acc);p[7]=0x48;p[8]=0x69;p[9]=0xc0;jj_reo_wr32(p+10,10);
  p[14]=0x48;p[15]=0x8b;p[16]=0x8d;jj_reo_wr32(p+17,base);p[21]=0x48;p[22]=0x8b;p[23]=0x95;jj_reo_wr32(p+24,index);
  p[28]=0x0f;p[29]=0xb6;p[30]=0x0c;p[31]=0x11;p[32]=0x48;p[33]=0x83;p[34]=0xe9;p[35]=48;p[36]=0x48;p[37]=0x01;p[38]=0xc8;
  p[39]=0x48;p[40]=0x89;p[41]=0x85;jj_reo_wr32(p+42,acc);p[46]=0x0f;p[47]=0x1f;p[48]=0x44;p[49]=0;p[50]=0x53;if jj_reo_nop(p,51,79)==0{return 0-1;}return 1;
}
fn jj_reo_sign32(value:i64)->i64{var lo:i64=value&0xffffffff;var sx:i64=lo;if (lo&0x80000000)!=0{sx=lo|0xffffffff00000000;}if sx==value{return 1;}return 0;}
fn jj_reo_power2_shift(value:i64)->i64{if value<=0{return 0-1;}var shift:i64=0;var bit:i64=1;while shift<31{if value==bit{return shift;}bit=bit<<1;shift=shift+1;}return 0-1;}

// Return: 0 no rewrite, 1 immediate ALU, 2 immediate multiply/strength reduction,
// 3 immediate shift, 4 immediate comparison.
fn jj_reo_try_constant(code:*i8,previous:i64,current:i64,op:i64)->i64{
  if code==0{return 0;}if previous<0{return 0;}if current!=previous+11{return 0;}
  if (code[previous]&255)!=0x48{return 0;}if (code[previous+1]&255)!=0xb8{return 0;}if (code[previous+10]&255)!=0x50{return 0;}if (code[current]&255)!=0x59{return 0;}
  var imm:i64=jj_reo_rd64(code+previous+2);var lo:i64=imm&0xffffffff;
  if jj_reo_sign32(imm)!=0{
    var modrm:i64=0;if op==9{modrm=0xc0;}else{if op==10{modrm=0xe8;}else{if op==16{modrm=0xe0;}else{if op==17{modrm=0xc8;}else{if op==18{modrm=0xf0;}}}}}
    if modrm!=0{
      if (code[current+1]&255)!=0x58{return 0;}if (code[current+2]&255)!=0x48{return 0;}if (code[current+4]&255)!=0xc8{return 0;}if (code[current+5]&255)!=0x50{return 0;}
      // R719 live bounded identities. Keep a five-byte executable proof marker so
      // cold-tail compaction can remove the dead geometry without guessing.
      if imm==0{if op==9{code[previous]=0x58;code[previous+1]=0x50;if jj_reo_nop(code,previous+2,previous+12)==0{return 0;}code[previous+12]=0x0f;code[previous+13]=0x1f;code[previous+14]=0x44;code[previous+15]=0;code[previous+16]=0x51;return 1;}if op==10{code[previous]=0x58;code[previous+1]=0x50;if jj_reo_nop(code,previous+2,previous+12)==0{return 0;}code[previous+12]=0x0f;code[previous+13]=0x1f;code[previous+14]=0x44;code[previous+15]=0;code[previous+16]=0x51;return 1;}if op==17{code[previous]=0x58;code[previous+1]=0x50;if jj_reo_nop(code,previous+2,previous+12)==0{return 0;}code[previous+12]=0x0f;code[previous+13]=0x1f;code[previous+14]=0x44;code[previous+15]=0;code[previous+16]=0x51;return 1;}if op==18{code[previous]=0x58;code[previous+1]=0x50;if jj_reo_nop(code,previous+2,previous+12)==0{return 0;}code[previous+12]=0x0f;code[previous+13]=0x1f;code[previous+14]=0x44;code[previous+15]=0;code[previous+16]=0x51;return 1;}if op==16{code[previous]=0x58;code[previous+1]=0x31;code[previous+2]=0xc0;code[previous+3]=0x50;if jj_reo_nop(code,previous+4,previous+12)==0{return 0;}code[previous+12]=0x0f;code[previous+13]=0x1f;code[previous+14]=0x44;code[previous+15]=0;code[previous+16]=0x52;return 1;}}
      if imm==0xffffffffffffffff{if op==16{code[previous]=0x58;code[previous+1]=0x50;if jj_reo_nop(code,previous+2,previous+12)==0{return 0;}code[previous+12]=0x0f;code[previous+13]=0x1f;code[previous+14]=0x44;code[previous+15]=0;code[previous+16]=0x51;return 1;}}
      code[previous]=0x58;code[previous+1]=0x48;code[previous+2]=0x81;code[previous+3]=modrm;jj_reo_wr32(code+previous+4,lo);code[previous+8]=0x50;jj_reo_nop(code,previous+9,previous+17);return 1;
    }
    if op==11{
      if (code[current+1]&255)!=0x58{return 0;}if (code[current+2]&255)!=0x48{return 0;}if (code[current+3]&255)!=0x0f{return 0;}if (code[current+4]&255)!=0xaf{return 0;}if (code[current+5]&255)!=0xc1{return 0;}if (code[current+6]&255)!=0x50{return 0;}
      if imm==0{code[previous]=0x58;code[previous+1]=0x31;code[previous+2]=0xc0;code[previous+3]=0x50;jj_reo_nop(code,previous+4,previous+18);return 2;}
      if imm==1{code[previous]=0x58;code[previous+1]=0x50;jj_reo_nop(code,previous+2,previous+18);return 2;}
      var power_shift:i64=jj_reo_power2_shift(imm);if power_shift>0{code[previous]=0x58;code[previous+1]=0x48;code[previous+2]=0xc1;code[previous+3]=0xe0;code[previous+4]=power_shift;code[previous+5]=0x50;jj_reo_nop(code,previous+6,previous+18);return 2;}
      var lea_sib:i64=0;if imm==3{lea_sib=0x40;}else{if imm==5{lea_sib=0x80;}else{if imm==9{lea_sib=0xc0;}}}if lea_sib!=0{code[previous]=0x58;code[previous+1]=0x48;code[previous+2]=0x8d;code[previous+3]=0x04;code[previous+4]=lea_sib;code[previous+5]=0x50;jj_reo_nop(code,previous+6,previous+18);return 2;}
      code[previous]=0x58;code[previous+1]=0x48;code[previous+2]=0x69;code[previous+3]=0xc0;jj_reo_wr32(code+previous+4,lo);code[previous+8]=0x50;jj_reo_nop(code,previous+9,previous+18);return 2;
    }
    var setcc:i64=0;if op==19{setcc=0x94;}else{if op==20{setcc=0x95;}else{if op==21{setcc=0x9c;}else{if op==22{setcc=0x9e;}else{if op==23{setcc=0x9f;}else{if op==24{setcc=0x9d;}else{if op==40{setcc=0x92;}else{if op==41{setcc=0x96;}else{if op==42{setcc=0x97;}else{if op==43{setcc=0x93;}}}}}}}}}}
    if setcc!=0{
      if (code[current+1]&255)!=0x58{return 0;}if (code[current+2]&255)!=0x48{return 0;}if (code[current+3]&255)!=0x39{return 0;}if (code[current+4]&255)!=0xc8{return 0;}if (code[current+5]&255)!=0x0f{return 0;}if (code[current+6]&255)!=setcc{return 0;}if (code[current+7]&255)!=0xc0{return 0;}if (code[current+8]&255)!=0x48{return 0;}if (code[current+9]&255)!=0x0f{return 0;}if (code[current+10]&255)!=0xb6{return 0;}if (code[current+11]&255)!=0xc0{return 0;}if (code[current+12]&255)!=0x50{return 0;}
      code[previous]=0x58;code[previous+1]=0x48;code[previous+2]=0x81;code[previous+3]=0xf8;jj_reo_wr32(code+previous+4,lo);code[previous+8]=0x0f;code[previous+9]=setcc;code[previous+10]=0xc0;code[previous+11]=0x48;code[previous+12]=0x0f;code[previous+13]=0xb6;code[previous+14]=0xc0;code[previous+15]=0x50;jj_reo_nop(code,previous+16,previous+24);return 4;
    }
  }
  if imm>=0{if imm<64{
    var shift:i64=0;if op==14{shift=0xe0;}else{if op==15{shift=0xf8;}else{if op==37{shift=0xe8;}}}
    if shift!=0{
      if (code[current+1]&255)!=0x58{return 0;}if (code[current+2]&255)!=0x48{return 0;}if (code[current+3]&255)!=0x83{return 0;}if (code[current+4]&255)!=0xf9{return 0;}if (code[current+5]&255)!=0x40{return 0;}if (code[current+6]&255)!=0x0f{return 0;}if (code[current+7]&255)!=0x83{return 0;}if (code[current+12]&255)!=0x48{return 0;}if (code[current+13]&255)!=0xd3{return 0;}if (code[current+15]&255)!=0x50{return 0;}
      if op==14{if (code[current+14]&255)!=0xe0{return 0;}}else{if op==15{if (code[current+14]&255)!=0xf8{return 0;}}else{if (code[current+14]&255)!=0xe8{return 0;}}}
      code[previous]=0x58;code[previous+1]=0x48;code[previous+2]=0xc1;code[previous+3]=shift;code[previous+4]=imm;code[previous+5]=0x50;jj_reo_nop(code,previous+6,previous+27);return 3;
    }
  }}
  return 0;
}
fn jj_reo_code_hash(code:*i8,size:i64)->i64{if code==0{return 0;}if size<=0{return 0;}var h:i64=0x6a09e667f3bcc909;var i:i64=0;while i<size{h=(h<<7)|(h>>>57);h=h^(code[i]&255);h=h+0x9e3779b97f4a7c15;i=i+1;}return h;}


// memory reaction REO-M: fixed-geometry memory residency reactions.
fn jj_reom_binary(op:i64)->i64{
  if op>=9{if op<=24{return 1;}}
  if op==37{return 1;}if op>=40{if op<=43{return 1;}}
  return 0;
}
fn jj_reom_local_constant(code:*i8,local_at:i64,constant_at:i64)->i64{
  if code==0{return 0;}if local_at<0{return 0;}if constant_at!=local_at+6{return 0;}
  if (code[local_at]&255)!=0xff{return 0;}if (code[local_at+1]&255)!=0xb5{return 0;}if (code[constant_at]&255)!=0x58{return 0;}
  var d0:i64=code[local_at+2]&255;var d1:i64=code[local_at+3]&255;var d2:i64=code[local_at+4]&255;var d3:i64=code[local_at+5]&255;
  code[local_at]=0x48;code[local_at+1]=0x8b;code[local_at+2]=0x85;code[local_at+3]=d0;code[local_at+4]=d1;code[local_at+5]=d2;code[local_at+6]=d3;return 1;
}
fn jj_reom_two_locals(code:*i8,first_at:i64,second_at:i64,current_at:i64)->i64{
  if code==0{return 0;}if first_at<0{return 0;}if second_at!=first_at+6{return 0;}if current_at!=second_at+6{return 0;}
  if (code[first_at]&255)!=0xff{return 0;}if (code[first_at+1]&255)!=0xb5{return 0;}
  if (code[second_at]&255)!=0x48{return 0;}if (code[second_at+1]&255)!=0x8b{return 0;}if (code[second_at+2]&255)!=0x8d{return 0;}if (code[current_at+1]&255)!=0x58{return 0;}
  var d0:i64=code[first_at+2]&255;var d1:i64=code[first_at+3]&255;var d2:i64=code[first_at+4]&255;var d3:i64=code[first_at+5]&255;
  var same:i64=0;if d0==(code[second_at+3]&255){if d1==(code[second_at+4]&255){if d2==(code[second_at+5]&255){if d3==(code[second_at+6]&255){same=1;}}}}
  if same!=0{code[first_at]=0x48;code[first_at+1]=0x8b;code[first_at+2]=0x85;code[first_at+3]=d0;code[first_at+4]=d1;code[first_at+5]=d2;code[first_at+6]=d3;code[first_at+7]=0x48;code[first_at+8]=0x89;code[first_at+9]=0xc1;if jj_reo_nop(code,first_at+10,first_at+14)==0{return 0;}return 2;}
  var i:i64=6;while i>=0{code[second_at+1+i]=code[second_at+i];i=i-1;}code[first_at]=0x48;code[first_at+1]=0x8b;code[first_at+2]=0x85;code[first_at+3]=d0;code[first_at+4]=d1;code[first_at+5]=d2;code[first_at+6]=d3;return 1;
}

fn jj_reom_two_push_locals(code:*i8,first_at:i64,second_at:i64,current_at:i64)->i64{
  if code==0{return 0;}if first_at<0{return 0;}if second_at!=first_at+6{return 0;}if current_at!=second_at+6{return 0;}
  if (code[first_at]&255)!=0xff{return 0;}if (code[first_at+1]&255)!=0xb5{return 0;}if (code[second_at]&255)!=0xff{return 0;}if (code[second_at+1]&255)!=0xb5{return 0;}if (code[current_at]&255)!=0x59{return 0;}if (code[current_at+1]&255)!=0x58{return 0;}
  var a0:i64=code[first_at+2]&255;var a1:i64=code[first_at+3]&255;var a2:i64=code[first_at+4]&255;var a3:i64=code[first_at+5]&255;var b0:i64=code[second_at+2]&255;var b1:i64=code[second_at+3]&255;var b2:i64=code[second_at+4]&255;var b3:i64=code[second_at+5]&255;
  code[first_at]=0x48;code[first_at+1]=0x8b;code[first_at+2]=0x85;code[first_at+3]=a0;code[first_at+4]=a1;code[first_at+5]=a2;code[first_at+6]=a3;
  if a0==b0{if a1==b1{if a2==b2{if a3==b3{code[first_at+7]=0x48;code[first_at+8]=0x89;code[first_at+9]=0xc1;if jj_reo_nop(code,first_at+10,first_at+14)==0{return 0;}return 2;}}}}
  code[first_at+7]=0x48;code[first_at+8]=0x8b;code[first_at+9]=0x8d;code[first_at+10]=b0;code[first_at+11]=b1;code[first_at+12]=b2;code[first_at+13]=b3;return 1;
}
fn jj_reom_try_compacted(code:*i8,first_at:i64,second_at:i64,current_at:i64,classes:i64,targets:i64)->i64{
  if targets!=0{return 0;}var first_op:i64=classes&255;var second_op:i64=(classes>>>8)&255;var op:i64=(classes>>>16)&255;if first_op!=2{return 0;}if second_op!=2{return 0;}if jj_reom_binary(op)==0{return 0;}return jj_reom_two_push_locals(code,first_at,second_at,current_at);
}

fn jj_reom_try(code:*i8,first_at:i64,second_at:i64,current_at:i64,classes:i64,targets:i64)->i64{
  if targets!=0{return 0;}var first_op:i64=classes&255;var second_op:i64=(classes>>>8)&255;var op:i64=(classes>>>16)&255;var reo:i64=(classes>>>24)&255;var r2:i64=(classes>>>32)&255;
  if first_op!=2{return 0;}if second_op==2{if r2!=0x8d{return 0;}if jj_reom_binary(op)==0{return 0;}return jj_reom_two_locals(code,first_at,second_at,current_at);}
  if second_op==1{if reo<=0{return 0;}return jj_reom_local_constant(code,first_at,second_at);}return 0;
}
