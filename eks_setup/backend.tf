terraform {
  backend "s3" {
    bucket                  = "eks-terraform-state"
    region                  = "us-east-2"
    key                     = "terraform.tfstate"
    encrypt                 = true
  }
}
