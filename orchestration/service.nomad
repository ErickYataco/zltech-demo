job "example-service" {
  type = "service"
  datacenters = ["dc1"]

  group "group1" {
    task "task1" {
      driver = "docker"

      config {
        image = "redis:3.2"

        port_map {
          db = 6379
        }
      }

      resources {
        cpu    = 500
        memory = 256

        network {
          mbits = 10

          port "db" {}
        }
      }
    }

    task "task2" {
      driver = "docker"

      config {
        image = "nginx:latest"

        port_map {
          http = 80
        }
      }

      resources {
        cpu    = 500
        memory = 256

        network {
          mbits = 10

          port "http" {}
        }
      }
    }
  }
}
