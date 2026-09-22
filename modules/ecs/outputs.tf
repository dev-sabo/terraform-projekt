output "cluster_name" {
  description = "Name des ECS Clusters"
  value       = aws_ecs_cluster.main.name
}