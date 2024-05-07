terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 2.70.0"
    }
  }
}

variable "region" {
  default = "us-east-2"
}

provider "aws" {
  region = var.region
}