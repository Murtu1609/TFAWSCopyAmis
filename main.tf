


data "aws_ami_ids" "ami_ids" {
owners = [var.account]
}


data "aws_ami" "ami" {
for_each = {for object in data.aws_ami_ids.ami_ids.ids : object => object}
 
  owners = [var.account]
  filter{
  name = "image-id"
  values = [each.value]
}
}

resource "aws_ami_copy" "amicopy" {
  provider = aws.dest
  for_each = {for object in data.aws_ami_ids.ami_ids.ids : object => object}

  name              = data.aws_ami.ami[each.key].name
  description = data.aws_ami.ami[each.key].description
  source_ami_id     = each.key
  source_ami_region = var.source_region

  tags = data.aws_ami.ami[each.key].tags

  timeouts{
    create = "120m"
    update = "120m"
    delete = "120m"
  }

}


