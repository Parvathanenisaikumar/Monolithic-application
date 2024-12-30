resource "aws_s3_bucket" "bucket" {
bucket = "sai.monolithic.project"
}

resource "aws_s3_bucket_ownership_controls" "control" {
bucket = aws_s3_bucket.bucket.id

rule {
object_ownership = "BucketOwnerPreferred"
}
}
resource "aws_s3_bucket_acl" "acl" {
depends_on = [aws_s3_bucket_ownership_controls.control]
bucket = aws_s3_bucket.bucket.id
acl = "private"
}

resource "aws_s3_bucket_versioning" "backup" {
bucket = aws_s3_bucket.bucket.id
versioning_configuration {
status = "Enabled"
}
}

