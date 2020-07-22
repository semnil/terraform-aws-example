data "archive_file" "app_imagedefinitions" {
  type = "zip"
  source {
    content = templatefile("${path.module}/aws_codepipeline_imagedefinitions/imagedefinitions.json.tpl",
      {
        container_name = "${var.prefix}-app"
        repository_url = var.app_repository_url
        release_tag    = var.release_tag
      }
    )
    filename = "imagedefinitions.json"
  }
  output_path = "${path.module}/aws_codepipeline_imagedefinitions/app_imagedefinitions.json.zip"
}

data "archive_file" "worker_imagedefinitions" {
  type = "zip"
  source {
    content = templatefile("${path.module}/aws_codepipeline_imagedefinitions/imagedefinitions.json.tpl",
      {
        container_name = "${var.prefix}-worker"
        repository_url = var.app_repository_url
        release_tag    = var.release_tag
      }
    )
    filename = "imagedefinitions.json"
  }
  output_path = "${path.module}/aws_codepipeline_imagedefinitions/worker_imagedefinitions.json.zip"
}

data "archive_file" "parser_imagedefinitions" {
  type = "zip"
  source {
    content = templatefile("${path.module}/aws_codepipeline_imagedefinitions/imagedefinitions.json.tpl",
      {
        container_name = "${var.prefix}-parser"
        repository_url = var.parser_repository_url
        release_tag    = var.release_tag
      }
    )
    filename = "imagedefinitions.json"
  }
  output_path = "${path.module}/aws_codepipeline_imagedefinitions/parser_imagedefinitions.json.zip"
}
