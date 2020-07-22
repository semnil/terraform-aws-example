locals {
  approval_app_config = var.approval_app ? {
    configuration = {
      CustomData         = "Approval Deploy ${var.prefix}-app"
      ExternalEntityLink = "https://github.com/rs-works/terraform-aws-example"
    }
  } : {}

  approval_parser_config = var.approval_parser ? {
    configuration = {
      CustomData         = "Approval Deploy ${var.prefix}-parser"
      ExternalEntityLink = "https://github.com/rs-works/terraform-aws-example"
    }
  } : {}
}

resource "aws_codepipeline" "app" {
  name     = "${var.prefix}-app-${var.environment}"
  role_arn = var.role_arn

  stage {
    name = "Source"

    action {
      name             = "${var.app_repository_name}-${var.release_tag}"
      category         = "Source"
      owner            = "AWS"
      provider         = "ECR"
      version          = 1
      output_artifacts = ["SourceArtifact"]

      configuration = {
        RepositoryName = var.app_repository_name
        ImageTag       = var.release_tag
      }
    }
    action {
      name             = "${var.prefix}-app-${var.environment}"
      category         = "Source"
      output_artifacts = ["${var.prefix}-app"]
      owner            = "AWS"
      provider         = "S3"
      version          = 1

      configuration = {
        PollForSourceChanges = false
        S3Bucket             = var.s3_bucket
        S3ObjectKey          = aws_s3_bucket_object.app_imagedefinitions.key
      }
    }
    action {
      name             = "${var.prefix}-worker-${var.environment}"
      category         = "Source"
      output_artifacts = ["${var.prefix}-worker"]
      owner            = "AWS"
      provider         = "S3"
      version          = 1

      configuration = {
        PollForSourceChanges = false
        S3Bucket             = var.s3_bucket
        S3ObjectKey          = aws_s3_bucket_object.worker_imagedefinitions.key
      }
    }
  }

  dynamic "stage" {
    for_each = local.approval_app_config

    content {
      name = "Approval"

      action {
        name          = "Approval"
        category      = "Approval"
        owner         = "AWS"
        provider      = "Manual"
        version       = 1
        configuration = stage.value
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name            = "${var.prefix}-worker-${var.environment}"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "ECS"
      version         = 1
      input_artifacts = ["${var.prefix}-worker"]
      run_order       = 1

      configuration = {
        ClusterName = var.cluster_name
        ServiceName = var.worker_service_name
      }
    }
    action {
      name            = "${var.prefix}-app-${var.environment}"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "ECS"
      version         = 1
      input_artifacts = ["${var.prefix}-app"]
      run_order       = 2

      configuration = {
        ClusterName = var.cluster_name
        ServiceName = var.app_service_name
      }
    }
  }

  artifact_store {
    location = var.s3_bucket
    type     = "S3"

    encryption_key {
      id   = var.kms_key_arn
      type = "KMS"
    }
  }

  tags = {
    Environment = var.environment
  }
}

resource "aws_codepipeline" "parser" {
  name     = "${var.prefix}-parser-${var.environment}"
  role_arn = var.role_arn

  stage {
    name = "Source"

    action {
      name             = "${var.parser_repository_name}-${var.release_tag}"
      category         = "Source"
      owner            = "AWS"
      provider         = "ECR"
      version          = 1
      output_artifacts = ["SourceArtifact"]

      configuration = {
        RepositoryName = var.parser_repository_name
        ImageTag       = var.release_tag
      }
    }
    action {
      name             = "${var.prefix}-parser-${var.environment}"
      category         = "Source"
      output_artifacts = ["${var.prefix}-parser"]
      owner            = "AWS"
      provider         = "S3"
      version          = 1

      configuration = {
        PollForSourceChanges = false
        S3Bucket             = var.s3_bucket
        S3ObjectKey          = aws_s3_bucket_object.parser_imagedefinitions.key
      }
    }
  }

  dynamic "stage" {
    for_each = local.approval_parser_config

    content {
      name = "Approval"

      action {
        name          = "Approval"
        category      = "Approval"
        owner         = "AWS"
        provider      = "Manual"
        version       = 1
        configuration = stage.value
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name            = "${var.prefix}-parser-${var.environment}"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "ECS"
      version         = 1
      input_artifacts = ["${var.prefix}-parser"]

      configuration = {
        ClusterName = var.cluster_name
        ServiceName = var.parser_service_name
      }
    }
  }

  artifact_store {
    location = var.s3_bucket
    type     = "S3"

    encryption_key {
      id   = var.kms_key_arn
      type = "KMS"
    }
  }

  tags = {
    Environment = var.environment
  }
}
