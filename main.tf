terraform {
        backend "s3"{
        bucket      = "remotetfstate"
        key         = "terraform/terraform.tfstate"
        region      = "ap-south-1"
        encrypt     = false
        }
}
