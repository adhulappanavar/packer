resource "aws_key_pair" "mykey" {
  key_name = "mykey"
  public_key = "${file("${var.PATH_TO_PUBLIC_KEY}")}"
}


resource "aws_instance" "example" {
  ami = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"
  key_name = "${aws_key_pair.mykey.key_name}"
  

  # Our Security group to allow HTTP and SSH access
  security_groups = ["${aws_security_group.default.name}"]



  connection {
    user = "${var.INSTANCE_USERNAME}"
    private_key = "${file("${var.PATH_TO_PRIVATE_KEY}")}"
  }
}

resource "aws_eip_association" "eip_assoc" {
  instance_id = "${aws_instance.example.id}"
  allocation_id = "eipalloc-2c86bd13"
}
