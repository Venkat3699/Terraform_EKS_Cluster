
provider "aws" {
    region = "ap-south-1"
}

terraform {
    backend "s3" {
        bucket         = "ravindra-6367"
        key            = "s3/terraform.tfstate"   # Partion key should be LockID
        region         = "ap-south-1"
        dynamodb_table = "ravindra-6367"
    }
}