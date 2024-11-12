# # # variables.tf

# variable "region" {
#   description = "AWS region"
#   type        = string
#   default     = "us-east-1"
# }

# variable "cluster_name" {
#   description = "EKS Cluster name"
#   type        = string
#   default     = "thim-eks"
# }

# # variable "subnet_ids" {
# #   description = "List of subnet IDs for the EKS cluster"
# #   type        = list(string)
# # }
# variable "spring_public_subnet_2" {
#   description = "ID du sous-réseau privé"
#   type        = string
# }

# variable "spring_private_subnet_2" {
#   description = "ID du sous-réseau privé"
#   type        = string
# }


# variable "node_group_name" {
#   description = "EKS Node Group name"
#   type        = string
#   default     = "thim-node-group"
# }

# variable "instance_type" {
#   description = "EC2 instance type for the worker nodes"
#   type        = string
#   default     = "t3.medium"
# }

# variable "desired_nodes" {
#   description = "Desired number of worker nodes"
#   type        = number
#   default     = 2
# }

# variable "max_nodes" {
#   description = "Maximum number of worker nodes"
#   type        = number
#   default     = 3
# }

# variable "min_nodes" {
#   description = "Minimum number of worker nodes"
#   type        = number
#   default     = 1
# }
