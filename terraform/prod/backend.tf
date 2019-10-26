terraform {
  backend "gcs" {
    bucket = "demshin-otus"
    prefix = "tfstate/prod"
  }
}
