{
  "detail-type": [
    "AWS API Call via CloudTrail"
  ],
  "source": [
    "aws.ecr"
  ],
  "detail": {
    "eventSource": [
      "ecr.amazonaws.com"
    ],
    "eventName": [
      "PutImage"
    ],
    "responseElements": {
      "image": {
        "repositoryName": [
          "${repository}"
        ],
        "imageId": {
          "imageTag": [
            "${release_tag}"
          ]
        }
      }
    }
  }
}
