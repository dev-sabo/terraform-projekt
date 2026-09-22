resource "aws_s3_bucket" "profile_pictures" {
  bucket = "${var.project_name}-${var.environment}-profile-pictures"
}

# Erzwingt die serverseitige AES-256 Verschlüsselung
resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket = aws_s3_bucket.profile_pictures.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Blockiert öffentlichen Zugriff (Bilder werden vom Backend-Container geladen)
resource "aws_s3_bucket_public_access_block" "block_public" {
  bucket                  = aws_s3_bucket.profile_pictures.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}