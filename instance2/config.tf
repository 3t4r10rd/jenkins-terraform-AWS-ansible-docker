terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

#Acces to AWS
provider "aws" {
  region     = "eu-west-1"
  access_key = "${file("~/access")}"
  secret_key = "${file("~/secret")}"

}

resource "aws_instance" "aws2" {
  ami           = "ami-08edbb0e85d6a0a07"
  instance_type = "t2.micro"
#Public key for SSH connection
  key_name = "test-key6"

  connection {
      type     = "ssh"
      user     = "ubuntu"
      host     = "${aws_instance.aws2.public_ip}"
#Private key for SSH
      private_key = "${file("~/.ssh/id_rsa")}"
  }
#Copy test file to instance
  provisioner "file" {
    source      = "./dockerrun.yml"
#To tmp directory, because without root priveleges
    destination = "/tmp/dockerrun.yml"
  }
#Commands on instance
  provisioner "remote-exec" {
    inline = [
      "sudo apt  update",
      "sudo apt install ansible -y",
      "sudo ansible-playbook /tmp/dockerrun.yml"
    ]
  }
}


#Public key for SSH connection
resource "aws_key_pair" "deployer" {
  key_name = "test-key6"
  public_key = "${file("~/.ssh/id_rsa.pub")}"
}
