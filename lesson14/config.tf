provider "aws" {
  region     = "us-east-2"
  access_key = "AKIAJFMNORTDLUI6K4HA"
  secret_key = "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"
}

resource "aws_key_pair" "ec2key" {
  key_name = "publicKey1"
  public_key = "${file("/root/.ssh/id_rsa.pub")}"
}

resource "aws_instance" "web" {
  ami           = "ami-0d03add87774b12c5"
  instance_type = "t2.micro"
  security_groups = [ "openAllPorts" ]
  key_name = "${aws_key_pair.ec2key.key_name}"

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get -y update",
      "sudo apt-get -y install nginx",
    ]
  }

  connection {
    type     = "ssh"
    user     = "ubuntu"
    private_key = "${file("/root/.ssh/id_rsa")}"
    agent = false
  }

  provisioner "file" {
    source      = "index.nginx-debian.html"
    destination = "/tmp/index.nginx-debian.html"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo mv /tmp/index.nginx-debian.html /var/www/html/index.nginx-debian.html",
    ]
  }


}
