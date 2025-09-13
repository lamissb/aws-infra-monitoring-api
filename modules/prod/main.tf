module "root" {
  source        = "../../"  # Pointing to root module
  servers       = 1
  environment   = "prod"
  ami_id        = "ami-053a45fff0a704a47"
  instance_type = "t2.micro"
  key_name      = "prod-key"
}

