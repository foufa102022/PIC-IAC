terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.0"
    }
  }
}

provider "docker" {}

resource "docker_image" "resume_img" {
  name         = "chetouiiftikhar/resume-img:latest"
  keep_locally = false
}

resource "docker_container" "resume_container" {
  image = docker_image.resume_img.name
  name  = "resume_container"
  ports {
    internal = 80
    external = 8001
  }
  restart = "unless-stopped"  # Politique de redémarrage
}
