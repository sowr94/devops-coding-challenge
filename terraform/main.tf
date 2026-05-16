resource "kubernetes_namespace" "crewmeister" {
  metadata {
    name = var.namespace
  }
}

resource "kubernetes_deployment" "app" {

  metadata {
    name      = "crewmeister-app"
    namespace = kubernetes_namespace.crewmeister.metadata[0].name

    labels = {
      app = "crewmeister-app"
    }
  }

  spec {

    replicas = 1

    selector {
      match_labels = {
        app = "crewmeister-app"
      }
    }

    template {

      metadata {
        labels = {
          app = "crewmeister-app"
        }
      }

      spec {

        container {

          image = "devops-coding-challenge-app:latest"
          name  = "crewmeister-app"

          port {
            container_port = 8080
          }

          env {
            name  = "SPRING_DATASOURCE_URL"
            value = "jdbc:mysql://mysql:3306/challenge?createDatabaseIfNotExist=true"
          }

          env {
            name  = "SPRING_DATASOURCE_USERNAME"
            value = "root"
          }

          env {
            name  = "SPRING_DATASOURCE_PASSWORD"
            value = "dev"
          }
        }
      }
    }
  }
}