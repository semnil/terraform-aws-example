# terraform-aws-example
Webアプリケーション開発を想定したAWSリソースのTerraform習作

## 構成
* AWSアカウントエイリアス
* AWSアカウントパスワードポリシー
* AWS SecurityHub
* AWS GuardDuty
* AWS Config
* AWS CloudTrail
* AWS ResourceGroup
* ...and more

## 階層

```
terraform/                        # IaC
├── environments                  # 環境別
│   └── dev                       # development
│       └── modules               # dev用module
│   └── stg                       # staging
│       └── modules               # stg用module
│   └── prd                       # production
│       └── modules               # prd用module
├── global                        # AWSアカウント共通リソース
│   └── modules                   # 共通リソース用module
└── modules                       # 汎用module
    └── service                   # service用module
```

## 動かすのに必要なもの

* Terraform 0.12.28

## セットアップ手順

~/.aws/credentials

```sh
[terraform-aws-iac]
region = ap-northeast-1
aws_access_key_id = AWS_ACCESS_KEY_ID
aws_secret_access_key = AWS_SECRET_ACCESS_KEY
```

### global

```sh
cd terraform/global
terraform init
```

### dev

```sh
cd terraform/environments/dev
terraform init
```

## 実行方法

### global

```sh
cd terraform/global
terraform plan
terraform apply
```

### dev

```sh
cd terraform/environments/dev
terraform plan
terraform apply
```

## コードフォーマット

```sh
terraform fmt
```

### ドライラン

```sh
terraform fmt -check
echo $? # 0:差分なし or 3:差分あり
```

### 差分出力

```sh
terraform fmt -diff -check # -checkを付けないとフォーマットされるので注意
```

### 再帰的にフォーマット

```sh
cd terraform
terraform fmt -recursive
```

## バリデーション

```sh
terraform validate
```
