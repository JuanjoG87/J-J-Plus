fn bad(data:*i64, out:*i64)->i64
capability data, out;
reads none;
writes out;
{
  var alias:*i64 = data;
  out[0] = alias as i64;
  return 0;
}
fn j_main(argc:i64,argv:*i64)->i64{return 0;}
