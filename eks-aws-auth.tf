##############################################
# Dados do cluster e da conta
##############################################
data "aws_caller_identity" "current" {}

data "aws_eks_cluster" "carstore" {
  name = "carstore-eks"
}

##############################################
# ConfigMap aws-auth (para conceder acesso ao usuário)
##############################################
locals {
  aws_auth_configmap = <<YAML
apiVersion: v1
kind: ConfigMap
metadata:
  name: aws-auth
  namespace: kube-system
data:
  mapUsers: |
    - userarn: arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/FabricioSousa
      username: FabricioSousa
      groups:
        - system:masters
    - userarn: arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/GitHubActionsRole
      username: GitHubActions
      groups:
        - system:masters
YAML
}

resource "kubernetes_config_map" "aws_auth" {
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  data = {
    mapUsers = yamldecode(local.aws_auth_configmap).data.mapUsers
  }

  depends_on = [data.aws_eks_cluster.carstore]
}
