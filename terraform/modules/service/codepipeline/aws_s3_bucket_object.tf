resource "aws_s3_bucket_object" "app_imagedefinitions" {
  bucket = var.s3_bucket
  key    = basename(data.archive_file.app_imagedefinitions.output_path)
  source = data.archive_file.app_imagedefinitions.output_path
  etag   = data.archive_file.app_imagedefinitions.output_md5
}

resource "aws_s3_bucket_object" "worker_imagedefinitions" {
  bucket = var.s3_bucket
  key    = basename(data.archive_file.worker_imagedefinitions.output_path)
  source = data.archive_file.worker_imagedefinitions.output_path
  etag   = data.archive_file.worker_imagedefinitions.output_md5
}

resource "aws_s3_bucket_object" "parser_imagedefinitions" {
  bucket = var.s3_bucket
  key    = basename(data.archive_file.parser_imagedefinitions.output_path)
  source = data.archive_file.parser_imagedefinitions.output_path
  etag   = data.archive_file.parser_imagedefinitions.output_md5
}
