// Typed TargetProfile authority shared by lowering, allocation, object writers,
// linkers and runtimes. The layout is host-independent and all logical offsets
// remain 64-bit even when the target pointer and usize widths are 32-bit.
fn jj_tp_zero(profile:*i64,slots:i64)->i64{
 if profile==0{return 0;}if slots!=32{return 0;}var i:i64=0;while i<slots{profile[i]=0;i=i+1;}return 1;
}
fn jj_tp_architecture(kind:i64)->i64{if kind==5{return 1;}if kind==6{return 2;}if kind==7{return 3;}if kind==8{return 4;}if kind==9{return 5;}if kind==10{return 6;}return 0;}
fn jj_tp_pointer_bits(kind:i64)->i64{if kind==5{return 64;}if kind==6{return 64;}if kind==7{return 32;}if kind==8{return 32;}if kind==9{return 64;}if kind==10{return 32;}return 0;}
fn jj_tp_word_bits(kind:i64)->i64{return jj_tp_pointer_bits(kind);}
fn jj_tp_integer_register_bits(kind:i64)->i64{return jj_tp_pointer_bits(kind);}
fn jj_tp_elf_class(kind:i64)->i64{if kind==5{return 2;}if kind==6{return 2;}if kind==7{return 1;}if kind==8{return 1;}if kind==9{return 2;}if kind==10{return 1;}return 0;}
fn jj_tp_elf_machine(kind:i64)->i64{if kind==5{return 62;}if kind==6{return 183;}if kind==7{return 40;}if kind==8{return 3;}if kind==9{return 243;}if kind==10{return 243;}return 0;}
fn jj_tp_abi(kind:i64)->i64{if kind==5{return 1;}if kind==6{return 2;}if kind==7{return 3;}if kind==8{return 4;}if kind==9{return 5;}if kind==10{return 6;}return 0;}
fn jj_tp_stack_alignment(kind:i64)->i64{if kind==5{return 16;}if kind==6{return 16;}if kind==7{return 8;}if kind==8{return 4;}if kind==9{return 16;}if kind==10{return 16;}return 0;}
fn jj_tp_call_alignment(kind:i64)->i64{return jj_tp_stack_alignment(kind);}
fn jj_tp_red_zone(kind:i64)->i64{if kind==5{return 128;}if kind>=6{if kind<=10{return 0;}}return 0-1;}
fn jj_tp_unaligned(kind:i64)->i64{if kind==5{return 1;}if kind==6{return 1;}if kind==7{return 0;}if kind==8{return 1;}if kind==9{return 0;}if kind==10{return 0;}return 0;}
fn jj_tp_native_u64(kind:i64)->i64{if kind==5{return 1;}if kind==6{return 1;}if kind==7{return 0;}if kind==8{return 0;}if kind==9{return 1;}if kind==10{return 0;}return 0;}
fn jj_tp_simd(kind:i64)->i64{if kind==5{return 1;}if kind==6{return 1;}if kind==7{return 0;}if kind==8{return 0;}if kind==9{return 0;}if kind==10{return 0;}return 0;}
fn jj_tp_atomic_width(kind:i64)->i64{if kind==5{return 64;}if kind==6{return 64;}if kind==7{return 32;}if kind==8{return 32;}if kind==9{return 0;}if kind==10{return 0;}return 0;}
fn jj_tp_feature_mask(kind:i64)->i64{if kind==5{return 0x1f;}if kind==6{return 0x0f;}if kind==7{return 0x03;}if kind==8{return 0x01;}if kind==9{return 0x03;}if kind==10{return 0x03;}return 0;}
fn jj_tp_freestanding(kind:i64)->i64{if kind==5{return 0;}if kind>=6{if kind<=10{return 1;}}return 0;}
fn jj_tp_hosted(kind:i64)->i64{if kind==5{return 1;}if kind>=6{if kind<=10{return 0;}}return 0;}
fn jj_tp_register_units(kind:i64)->i64{if kind==5{return 4;}if kind==6{return 7;}if kind==7{return 6;}if kind==8{return 4;}if kind==9{return 8;}if kind==10{return 8;}return 0;}
fn jj_tp_caller_mask(kind:i64)->i64{if kind==5{return 0x0f;}if kind==6{return 0x7f;}if kind==7{return 0x0f;}if kind==8{return 0x08;}if kind==9{return 0xff;}if kind==10{return 0xff;}return 0;}
fn jj_tp_callee_mask(kind:i64)->i64{if kind==5{return 0;}if kind==6{return 0;}if kind==7{return 0x30;}if kind==8{return 0x07;}if kind==9{return 0;}if kind==10{return 0;}return 0;}
fn jj_tp_seal(profile:*i64,slots:i64)->i64{
 if profile==0{return 0;}if slots!=32{return 0;}var h:i64=0x4a4a5450524f4634;var i:i64=0;while i<31{h=((h<<9)|(h>>>55))^profile[i]^(i*0x9e3779b1);i=i+1;}return h;
}
fn jj_target_profile_build(kind:i64,profile:*i64,slots:i64)->i64{
 if kind<5{return 0;}if kind>10{return 0;}if jj_tp_zero(profile,slots)==0{return 0;}
 profile[0]=0x4a4a5450524f4634;profile[1]=4;profile[2]=kind;profile[3]=jj_tp_architecture(kind);
 profile[4]=jj_tp_pointer_bits(kind);profile[5]=jj_tp_word_bits(kind);profile[6]=jj_tp_integer_register_bits(kind);profile[7]=1;
 profile[8]=jj_tp_elf_class(kind);profile[9]=jj_tp_elf_machine(kind);profile[10]=1;profile[11]=jj_tp_abi(kind);
 profile[12]=jj_tp_stack_alignment(kind);profile[13]=jj_tp_call_alignment(kind);profile[14]=jj_tp_red_zone(kind);profile[15]=jj_tp_unaligned(kind);
 profile[16]=jj_tp_native_u64(kind);profile[17]=jj_tp_simd(kind);profile[18]=jj_tp_atomic_width(kind);profile[19]=jj_tp_feature_mask(kind);
 profile[20]=jj_tp_freestanding(kind);profile[21]=jj_tp_hosted(kind);profile[22]=jj_tp_register_units(kind);profile[23]=jj_tp_caller_mask(kind);profile[24]=jj_tp_callee_mask(kind);
 profile[25]=8;profile[26]=64;profile[27]=64;profile[28]=64;profile[29]=32;profile[30]=0x4a4a4c4f47494331;
 profile[31]=jj_tp_seal(profile,slots);if profile[31]==0{jj_tp_zero(profile,slots);return 0;}return 1;
}
fn jj_target_profile_validate(profile:*i64,slots:i64)->i64{
 if profile==0{return 0;}if slots!=32{return 0;}if profile[0]!=0x4a4a5450524f4634{return 0;}if profile[1]!=4{return 0;}var kind:i64=profile[2];if kind<5{return 0;}if kind>10{return 0;}
 if profile[3]!=jj_tp_architecture(kind){return 0;}if profile[4]!=jj_tp_pointer_bits(kind){return 0;}if profile[5]!=jj_tp_word_bits(kind){return 0;}if profile[6]!=jj_tp_integer_register_bits(kind){return 0;}if profile[7]!=1{return 0;}
 if profile[8]!=jj_tp_elf_class(kind){return 0;}if profile[9]!=jj_tp_elf_machine(kind){return 0;}if profile[10]!=1{return 0;}if profile[11]!=jj_tp_abi(kind){return 0;}
 if profile[12]!=jj_tp_stack_alignment(kind){return 0;}if profile[13]!=jj_tp_call_alignment(kind){return 0;}if profile[14]!=jj_tp_red_zone(kind){return 0;}if profile[15]!=jj_tp_unaligned(kind){return 0;}
 if profile[16]!=jj_tp_native_u64(kind){return 0;}if profile[17]!=jj_tp_simd(kind){return 0;}if profile[18]!=jj_tp_atomic_width(kind){return 0;}if profile[19]!=jj_tp_feature_mask(kind){return 0;}
 if profile[20]!=jj_tp_freestanding(kind){return 0;}if profile[21]!=jj_tp_hosted(kind){return 0;}if profile[20]+profile[21]!=1{return 0;}if profile[22]!=jj_tp_register_units(kind){return 0;}if profile[23]!=jj_tp_caller_mask(kind){return 0;}if profile[24]!=jj_tp_callee_mask(kind){return 0;}
 if profile[25]!=8{return 0;}if profile[26]!=64{return 0;}if profile[27]!=64{return 0;}if profile[28]!=64{return 0;}if profile[29]!=32{return 0;}if profile[30]!=0x4a4a4c4f47494331{return 0;}
 if profile[31]==0{return 0;}if profile[31]!=jj_tp_seal(profile,slots){return 0;}return 1;
}
fn jj_target_profile_field(profile:*i64,slots:i64,field:i64)->i64{if jj_target_profile_validate(profile,slots)==0{return 0-1;}if field<2{return 0-1;}if field>30{return 0-1;}return profile[field];}
fn jj_target_profile_value_parts(profile:*i64,slots:i64,bits:i64)->i64{if jj_target_profile_validate(profile,slots)==0{return 0;}if bits<=0{return 0;}if bits>64{return 0;}var width:i64=profile[6];return (bits+width-1)/width;}
fn jj_target_profile_align(profile:*i64,slots:i64,value:i64)->i64{if jj_target_profile_validate(profile,slots)==0{return 0-1;}if value<0{return 0-1;}var a:i64=profile[12];if value>0x7fffffffffffffff-(a-1){return 0-1;}return ((value+a-1)/a)*a;}
fn jj_target_profile_resource_contract(profile:*i64,slots:i64,out:*i64,out_slots:i64)->i64{
 if jj_target_profile_validate(profile,slots)==0{return 0;}if out==0{return 0;}if out_slots!=8{return 0;}var i:i64=0;while i<8{out[i]=0;i=i+1;}
 out[0]=256;out[1]=256;out[2]=256;out[3]=1;out[4]=0;out[5]=1;out[6]=1;out[7]=(out as i64)^profile[31]^0x4a4a545052455331;return 1;
}
