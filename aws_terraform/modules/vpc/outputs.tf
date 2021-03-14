locals {
  subnet_id_map = {
    public = {
      ap-northeast-1a = aws_subnet.pub_1a.id
      ap-northeast-1c = aws_subnet.pub_1c.id
    }
    private = {
      ap-northeast-1a = aws_subnet.pri_1a.id
      ap-northeast-1c = aws_subnet.pri_1c.id
    }
  }
}

output "subnet_id" {
	value       = local.subnet_id_map
  description = "Output id of the created subnet."
}

output "vpc_id" {
  value       = aws_vpc.main.id
  description = "Output id of the created vpc."
}