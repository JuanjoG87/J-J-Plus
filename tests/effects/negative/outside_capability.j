fn bad(a:*i64, b:*i64)->i64
capability a;
reads b;
writes none;
{
  return b[0];
}
