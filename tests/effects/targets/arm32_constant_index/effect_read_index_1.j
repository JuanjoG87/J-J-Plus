// jj_target: arm32
fn jj_probe(data:*i64)->i64
capability data;
reads data;
writes none;
{
  return data[1];
}
