project_name = "eks-platform"
environment  = "dev"
aws_region   = "us-east-1"

# ---- Network ----
# create_vpc = true  -> Terraform creates the VPC (uses vpc_cidr / availability_zones).
# create_vpc = false -> reuses an existing VPC (fill in existing_*; the subnets
#                       MUST be tagged kubernetes.io/role/elb | internal-elb
#                       and kubernetes.io/cluster/<cluster> = shared).
create_vpc         = true
vpc_cidr           = "10.0.0.0/16"
availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
single_nat_gateway = true

# Only when create_vpc = false:
# existing_vpc_id             = "vpc-0abc123..."
# existing_private_subnet_ids = ["subnet-aaa", "subnet-bbb", "subnet-ccc"]
# existing_public_subnet_ids  = ["subnet-ddd", "subnet-eee", "subnet-fff"]

# EKS
# compute_mode: "fargate" | "ec2_managed" | "ec2_karpenter"
#   Switching Fargate <-> EC2 = change ONLY this line + terraform apply.
compute_mode              = "fargate"
eks_cluster_version       = "1.30"
eks_node_instance_types   = ["t3.large"] # ec2_* modes only
eks_node_desired_size     = 3            # ec2_* modes only
eks_node_min_size         = 2
eks_node_max_size         = 6
eks_node_disk_size        = 50
fargate_namespaces        = ["default", "fargate-workloads"]
fargate_system_namespaces = ["kube-system"]

# Helm — Core
argocd_chart_version = "7.3.4"
cilium_chart_version = "1.16.5"

# Karpenter
karpenter_version               = "1.0.5"
karpenter_use_spot              = true
karpenter_nodepool_cpu_limit    = "100"
karpenter_nodepool_memory_limit = "400Gi"

# Platform Add-ons — Chart Versions
metrics_server_chart_version   = "3.12.1"
vpa_chart_version              = "4.5.0"
external_dns_chart_version     = "1.14.5"
cert_manager_chart_version     = "1.15.1"
falco_chart_version            = "4.7.0"
prometheus_stack_chart_version = "61.7.0"

# External-DNS
domain_filters = [] # ["example.com", "sub.example.com"]

# Cert-Manager
letsencrypt_email = "" # "you@example.com"

# Falco
falco_webui_enabled = true

# Prometheus / Grafana
prometheus_retention    = "15d"
prometheus_storage_size = "50Gi"
