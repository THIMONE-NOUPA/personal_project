
# # main.tf

# Fournisseur AWS
provider "aws" {
  region = var.region
}

# Rôle IAM pour le cluster EKS
resource "aws_iam_role" "thim_cluster_role" {
  name = "thim-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Principal = {
          Service = "eks.amazonaws.com"
        },
        Effect = "Allow"
      },
    ]
  })
}

# Attachement des politiques gérées pour le rôle EKS
resource "aws_iam_role_policy_attachment" "thim_cluster_policy" {
  role       = aws_iam_role.thim_cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role_policy_attachment" "thim_service_policy" {
  role       = aws_iam_role.thim_cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
}

# Cluster EKS
resource "aws_eks_cluster" "eks" {
  name     = var.cluster_name
  role_arn = aws_iam_role.thim_cluster_role.arn

  vpc_config {
    subnet_ids = [
      data.aws_subnet.spring_public_subnet.id,
      data.aws_subnet.spring_public_subnet_2.id # Ajouter un second sous-réseau public dans une autre AZ
    ]
  }

  depends_on = [
    aws_iam_role_policy_attachment.thim_cluster_policy,
    aws_iam_role_policy_attachment.thim_service_policy
  ]
}

# Rôle IAM pour les groupes de nœuds
resource "aws_iam_role" "thim_node_role" {
  name = "thim-node-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Effect = "Allow"
      },
    ]
  })
}

# Attachement des politiques gérées pour le rôle des nœuds
resource "aws_iam_role_policy_attachment" "thim_worker_node_policy" {
  role       = aws_iam_role.thim_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "thim_cni_policy" {
  role       = aws_iam_role.thim_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_iam_role_policy_attachment" "ec2_container_registry_read_only" {
  role       = aws_iam_role.thim_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

# Groupe de nœuds géré par EKS
resource "aws_eks_node_group" "eks_nodes" {
  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = var.node_group_name
  node_role_arn   = aws_iam_role.thim_node_role.arn
  subnet_ids      = [data.aws_subnet.spring_private_subnet_2.id] # Node group dans le private subnet

  scaling_config {
    desired_size = var.desired_nodes
    max_size     = var.max_nodes
    min_size     = var.min_nodes
  }

  instance_types = [var.instance_type]

  depends_on = [
    aws_iam_role_policy_attachment.thim_worker_node_policy,
    aws_iam_role_policy_attachment.thim_cni_policy,
    aws_iam_role_policy_attachment.ec2_container_registry_read_only
  ]
}