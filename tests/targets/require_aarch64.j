// jj_target: aarch64
fn guarded(value:i64)->i64{
  require value!=0 else return 7;
  return 9;
}
