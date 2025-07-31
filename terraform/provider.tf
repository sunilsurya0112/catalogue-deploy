terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 2.49.0" # AWS provider version, not terraform version
    }
  }

  backend "s3" {
    bucket         = "dev-remote-state-22" #bucket name
    key            = "catalogue"           #file name in bucket
    region         = "us-east-1"
    dynamodb_table = "dev-remotestate-locking" #dynamodb table name
  }
}

provider "aws" {
  region = "us-east-1"
}