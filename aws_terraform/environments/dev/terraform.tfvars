# VPC #
vpc_cidr_block = "10.0.0.0/16"

# subnet #
subnet_cidr_block = {
  public = {
    ap-northeast-1a = "10.0.10.0/24"
    ap-northeast-1c = "10.0.11.0/24"
  }
  private = {
    ap-northeast-1a = "10.0.20.0/24"
    ap-northeast-1c = "10.0.21.0/24"
  }
}

# EC2 #
ec2_conf = {
  ami_id = ""
  instance_type = "t2.micro"
}
ec2_private_ip = {
  public = {
    ap-northeast-1a = "10.0.10.10"
    ap-northeast-1c = "10.0.11.10"
  }
}
ec2_key_name = ""

# RDS #
rds_conf = {
  parameter_group = {
    family    = "mysql8.0"
    parameter = [
      { 
        name  = "character_set_server"
        val   = "utf8"
      },
      {
        name  = "character_set_client"
        val   = "utf8"
      }
    ]
  }
  option_group = {
    engine_name           = "mysql"
    major_engine_version  = "8.0"
  }
  rds = {
    engine          = "mysql"
    engine_version  = "8.0"
    instance_class  = "db.t2.micro"
  }
}

rds_user_conf = {
  username = "root"
  password = "password"
}