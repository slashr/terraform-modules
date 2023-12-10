resource "kubernetes_namespace" "external-dns" {
  metadata {
    name = "external-dns"
  }
}

resource "helm_release" "external-dns" {
  name       = "external-dns"
  namespace  = "external-dns"
  repository = "https://kubernetes-sigs.github.io/external-dns/"
  chart      = "external-dns"
  version    = "1.13.1"

  values = [templatefile("${path.module}/values.yaml",{})]

  depends_on = [
    resource.kubernetes_namespace.external-dns
  ]
}

