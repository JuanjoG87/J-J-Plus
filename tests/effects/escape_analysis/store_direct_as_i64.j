fn bad(data:*i64, out:*i64)->i64
capability data, out;
reads none;
writes out;
{
  out[0] = data as i64;
  return 0;
}
fn j_main(argc:i64,argv:*i64)->i64{return 0;}
