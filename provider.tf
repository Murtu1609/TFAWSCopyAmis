provider "aws" {
  alias = "dest"
  region                  = var.dest_region
  access_key = var.access_key
  secret_key = var.secret_key

  
}

provider "aws" {
  region                  = var.source_region
  access_key = var.access_key
  secret_key = var.secret_key

  
}