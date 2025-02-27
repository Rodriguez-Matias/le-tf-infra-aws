#------------------------------------------------------------------------------
# ArgoCD: GitOps + CI/CD
#------------------------------------------------------------------------------
resource "helm_release" "argocd" {
  count      = var.enable_cicd ? 1 : 0
  name       = "argocd"
  namespace  = kubernetes_namespace.argocd.id
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "4.5.7"
  values     = [file("chart-values/argo-cd.yaml")]
}
