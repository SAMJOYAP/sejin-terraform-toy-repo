output "nodejs_repo_url" {
  value = aws_ecr_repository.nodejs.repository_url
}

output "react_repo_url" {
  value = aws_ecr_repository.react.repository_url
}
