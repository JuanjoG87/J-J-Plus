// jj_target: i386
// Exact IA-32 runtime helpers for signed i64 division and remainder.
// The semantic backend lowers CIR / and % to these ordinary J/J+ functions.
fn jj_i386_i64_div_fault()->i64{
  var invalid:*i8=0 as *i8;
  invalid[0]=1;
  return 0;
}

fn jj_i386_u64_divmod(n:u64,d:u64,want_remainder:i64)->u64{
  if d==(0 as u64){jj_i386_i64_div_fault();return 0 as u64;}
  var quotient:u64=0 as u64;
  var remainder:u64=0 as u64;
  var bit:i64=63;
  while bit>=0{
    var carry:u64=remainder>>>63;
    remainder=(remainder<<1)|((n>>>bit)&(1 as u64));
    if carry!=(0 as u64){
      remainder=remainder-d;
      quotient=quotient|((1 as u64)<<bit);
    }else{
      if remainder>=d{
        remainder=remainder-d;
        quotient=quotient|((1 as u64)<<bit);
      }
    }
    bit=bit-1;
  }
  if want_remainder!=0{return remainder;}
  return quotient;
}

fn jj_i386_i64_sdiv(a:i64,b:i64)->i64{
  if b==0{return jj_i386_i64_div_fault();}
  if a==(0x8000000000000000 as i64){if b==(0xffffffffffffffff as i64){return jj_i386_i64_div_fault();}}
  var ua:u64=a as u64;
  var ub:u64=b as u64;
  var a_negative:i64=0;
  var b_negative:i64=0;
  if a<0{a_negative=1;ua=(0 as u64)-ua;}
  if b<0{b_negative=1;ub=(0 as u64)-ub;}
  var quotient:u64=jj_i386_u64_divmod(ua,ub,0);
  if a_negative!=b_negative{quotient=(0 as u64)-quotient;}
  return quotient as i64;
}

fn jj_i386_i64_smod(a:i64,b:i64)->i64{
  if b==0{return jj_i386_i64_div_fault();}
  if a==(0x8000000000000000 as i64){if b==(0xffffffffffffffff as i64){return jj_i386_i64_div_fault();}}
  var ua:u64=a as u64;
  var ub:u64=b as u64;
  var a_negative:i64=0;
  if a<0{a_negative=1;ua=(0 as u64)-ua;}
  if b<0{ub=(0 as u64)-ub;}
  var remainder:u64=jj_i386_u64_divmod(ua,ub,1);
  if a_negative!=0{remainder=(0 as u64)-remainder;}
  return remainder as i64;
}
