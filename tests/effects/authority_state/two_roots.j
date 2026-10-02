fn observe(a:*i64, b:*i64)->i64
capability a, b;
reads none;
writes none;
{
  return 0;
}

fn j_main(argc:i64, argv:*i64)->i64 {
  return observe(argv, argv);
}
