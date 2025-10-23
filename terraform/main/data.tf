data "terraform_remote_state" "image" {
  backend = "pg"

  config = {
    schema_name = "terraform_remote_state_image"
  }
}