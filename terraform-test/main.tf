resource "local_file" "test" {
  content  = "Hallo Terraform!"
  filename = "hello.txt"
}