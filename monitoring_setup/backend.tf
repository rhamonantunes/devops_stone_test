terraform {
  backend "s3" {
    bucket                  = "monitoring-terraformstate"
    region                  = "us-east-2"
    key                     = "terraform.tfstate"
    encrypt                 = true
  }
}
