resource "aws_instance" "this" {
  ami           = var.ami
  instance_type = var.instance_type //"t2.micro"
  cpu_options {
    core_count = var.cpu_core_count
    threads_per_core = var.cpu_threads_per_core
  }
  user_data = <<EOF
#!/bin/bash
sudo yum update -y
sudo yum install -y git
git clone https://github.com/Homebrew/brew ~/.linuxbrew/Homebrew
mkdir ~/.linuxbrew/bin
ln -s ../Homebrew/bin/brew ~/.linuxbrew/bin
eval $(~/.linuxbrew/bin/brew shellenv)
EOF
}