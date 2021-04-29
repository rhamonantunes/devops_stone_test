terraform {
  backend "s3" {
    bucket                  = "monitoring-terraformtfstate"
    region                  = "us-east-2"
    key                     = "terraform.tfstate"
    encrypt                 = true
  }
}
