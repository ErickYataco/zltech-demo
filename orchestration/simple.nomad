job "example" {
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
  }
}
