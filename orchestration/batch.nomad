job "example-batch" {
  type = "batch"
  datacenters = ["dc1"]

  periodic {
    cron             = "0 * * * *"
    prohibit_overlap = true
    time_zone        = "UTC"
  }

  group "group1" {
    task "task1" {
      driver = "docker"

      config {
        image = "alpine:latest"
        command = "/bin/sh"
        args = ["-c", "echo 'Hello, Nomad!'"]
      }

      resources {
        cpu    = 100
        memory = 50
      }
    }
  }
}
