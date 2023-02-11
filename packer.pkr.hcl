
locals { timestamp = regex_replace(timestamp(), "[- TZ:]", "") }

source "amazon-ebs" "Packer_maven" {
  ami_name      = "packer_maven"
  instance_type = "t2.micro"
  region        = "ap-south-1"
  source_ami    = "ami-0e07dcaca348a0e68"
  ssh_username  = "ec2-user"
}

build {
  sources = ["source.amazon-ebs.Packer_maven"]

  provisioner "shell" {
    inline = ["sudo yum update -y", "sudo yum install ansible-core -y"]
  }
  provisioner "ansible-local" {
    playbook_file = "maven-install.yaml"
  }
}