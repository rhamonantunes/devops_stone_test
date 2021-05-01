#
# EKS Worker Nodes Resources
#  * IAM role allowing Kubernetes actions to access other AWS services
#  * EKS Node Group to launch worker nodes
#

resource "aws_iam_role" "stone-node" {
  name = "tf-node-iam-role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "stone-node-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.stone-node.name
}

resource "aws_iam_role_policy_attachment" "stone-node-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.stone-node.name
}

resource "aws_iam_role_policy_attachment" "stone-node-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.stone-node.name
}

resource "aws_eks_node_group" "eks_node" {
  cluster_name    = aws_eks_cluster.stone.name
  instance_types  = ["t3.xlarge"]
  node_group_name = "stone_01"
  node_role_arn   = aws_iam_role.stone-node.arn
  subnet_ids = aws_subnet.stone[*].id

  scaling_config {
    desired_size = 5
    max_size     = 8
    min_size     = 3
  }

  depends_on = [
    aws_iam_role_policy_attachment.stone-node-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.stone-node-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.stone-node-AmazonEC2ContainerRegistryReadOnly,
  ]
}