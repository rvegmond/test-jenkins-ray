provider "aws" {
  region  = "eu-central-1"
}

terraform {
  backend "s3" {
    bucket = "gc-tst-tfstate-us-east-1"
    key    = "cross-account-test/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
    alias   = "prd" 
    profile = "goingcloud"
    region  = "us-east-1"
}

resource "aws_acm_certificate" "cert" {
    domain_name       = "test-host.tzadaah.com"
    # subject_alternative_names = [
    #     "test-host.tst.a-random-domain.com"
    # ]
    validation_method = "DNS"
}

# data "aws_route53_zone" "tst-zone" {
#     name         = "tst.a-random-domain.com."
#     private_zone = false
# }

data "aws_route53_zone" "prd-zone" {
    provider     = aws.prd
    name         = "tzadaah.com."
    private_zone = false
}

# resource "aws_route53_record" "tst-cert_validation" {
#     name        = "${aws_acm_certificate.cert.domain_validation_options.1.resource_record_name}"
#     type        = "${aws_acm_certificate.cert.domain_validation_options.1.resource_record_type}"
#     zone_id     = "${data.aws_route53_zone.tst-zone.id}"
#     records     = ["${aws_acm_certificate.cert.domain_validation_options.1.resource_record_value}"]
#     ttl         = 60
# }

resource "aws_route53_record" "prd-cert_validation" {
    provider    = aws.prd
    name        = "${aws_acm_certificate.cert.domain_validation_options.0.resource_record_name}"
    type        = "${aws_acm_certificate.cert.domain_validation_options.0.resource_record_type}"
    zone_id     = "${data.aws_route53_zone.prd-zone.id}"
    records     = ["${aws_acm_certificate.cert.domain_validation_options.0.resource_record_value}"]
    ttl         = 60
}

resource "aws_acm_certificate_validation" "cert" {
  certificate_arn         = "${aws_acm_certificate.cert.arn}"
  validation_record_fqdns = [
    #   "${aws_route53_record.tst-cert_validation.fqdn}",
      "${aws_route53_record.prd-cert_validation.fqdn}"
    ]
}