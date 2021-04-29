terraform {
  backend "s3" {
    bucket                  = "eks-terraformtfstate"
    region                  = "us-east-2"
    key                     = "terraform.tfstate"
    encrypt                 = true
  }
}
