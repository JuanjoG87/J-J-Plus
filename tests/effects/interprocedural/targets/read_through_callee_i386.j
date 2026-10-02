// jj_target: i386
fn leaf(data:*i64)->i64
capability data;
reads data;
writes none;
{
  return data[0];
}

fn wrapper(data:*i64)->i64
capability data;
reads data;
writes none;
{
  return leaf(data);
}
