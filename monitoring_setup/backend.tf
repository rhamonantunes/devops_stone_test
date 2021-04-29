terraform {
  backend "s3" {
    bucket                  = "monitoring-terraform-state"
    region                  = "us-east-2"
    key                     = "terraform.tfstate"
    encrypt                 = true
  }
}
