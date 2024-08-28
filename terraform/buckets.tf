# resource "aws_s3_bucket" "my_bucket" {
#   bucket = "petclinic-helm-charts-datascientest"

#   tags = {
#     Name        = "petclinic-helm-charts-datascientest"
#     Environment = "Staging"
#   }
# }

# output "bucket_name" {
#   value = aws_s3_bucket.my_bucket.bucket
# }