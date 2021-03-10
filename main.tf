#Providing the provider name and asking an input for the region name to create resources into specific location

provider "aws" {
  region = var.region_name
}

#Creating resource for KMS-key to encrypt the bucket.

resource "aws_kms_key" "key" {
    description = var.kms_key_description
    deletion_window_in_days = var.kms_deletion_days
}
#CReating an alias for KMS-key

resource "aws_kms_alias" "kms_key_alias" {
    name = "alias/${lower(var.kms_key_alias)}"
    target_key_id = aws_kms_key.key.key_id
}

#Creating resource for s3 bucket with lifecycle rule.

resource "aws_s3_bucket" "s3bucket" {
    bucket = var.name_s3_bucket
    acl = "private"
    server_side_encryption_configuration {
        rule {
            apply_server_side_encryption_by_default {
                kms_master_key_id = aws_kms_key.key.key_id
                sse_algorithm     = "aws:kms"
            }
        }
    }

    versioning {
        enabled = true
    }

    lifecycle_rule {
        id = "myrule"
        enabled = "true"
        prefix = "myrule/"

        transition {
            
            
            days = var.no_of_days_standard_IA
            storage_class = "STANDARD_IA"
        }
        
        transition {
            
            days = var.no_of_days_glacier
            storage_class = "GLACIER"
    
        }

    

    

    }
}