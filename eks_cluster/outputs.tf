# # outputs.tf

output "cluster_id" {
  description = "EKS Cluster ID"
  value       = aws_eks_cluster.eks.id
}

output "cluster_endpoint" {
  description = "EKS Cluster endpoint"
  value       = aws_eks_cluster.eks.endpoint
}

output "cluster_certificate_authority" {
  description = "EKS Cluster certificate authority data"
  value       = aws_eks_cluster.eks.certificate_authority[0].data
}

output "node_group_name" {
  description = "EKS Node Group name"
  value       = aws_eks_node_group.eks_nodes.node_group_name
}
