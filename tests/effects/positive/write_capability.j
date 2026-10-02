fn clear_first(data:*i64)->i64
capability data;
reads none;
writes data;
{
  data[0] = 0;
  return 0;
}

fn j_main(argc:i64, argv:*i64)->i64 {
  return 0;
}
