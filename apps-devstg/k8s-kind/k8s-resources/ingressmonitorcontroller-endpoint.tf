#------------------------------------------------------------------------------
# IngressMonitorController - Static Endpoint
#------------------------------------------------------------------------------
resource "helm_release" "ingressmonitorcontroller-endpoint" {
  count      = var.enable_ingressmonitorcontroller ? 1 : 0
  name       = "ingress-monitor-controller-endpoint"
  repository = "https://binbashar.github.io/helm-charts/"
  chart      = "ingress-monitor-controller-endpoint"
  version    = "0.1.0"
  values     = [file("chart-values/ingress-monitor-controller-endpoint.yaml")]
  depends_on = [helm_release.ingressmonitorcontroller]
}

#------------------------------------------------------------------------------
# IngressMonitorController - Ingress Endpoint
#------------------------------------------------------------------------------
resource "helm_release" "kubernetes_dashboard_imc_endpoint" {
  count      = var.enable_ingressmonitorcontroller ? 1 : 0
  name       = "kubernetes-dashboard"
  repository = "http://192.168.0.37:8879/charts"
  chart      = "ingress-monitor-controller-endpoint"
  version    = "0.1.1"
  values = [
    templatefile("chart-values/ingress-monitor-controller-ingress-endpoint.yaml",
      {
        name        = "kubernetes-dashboard",
        namespace   = "monitoring",
        ingressName = "kubernetes_dashboard"
      }
    )
  ]
  depends_on = [helm_release.ingressmonitorcontroller, helm_release.kubernetes_dashboard]
}
