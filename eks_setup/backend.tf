terraform {
  backend "s3" {
    bucket                  = "eks-terraformstate"
    region                  = "us-east-2"
    key                     = "terraform.tfstate"
    encrypt                 = true
  }
}
