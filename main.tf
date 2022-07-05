provider google{}
provider tls{}

resource "tls_private_key" "example" {
  algorithm   = "RSA"
}

resource "tls_cert_request" "example" {
  key_algorithm   = "RSA"
  private_key_pem = tls_private_key.example.private_key_pem

  subject {
    common_name  = "example.com"
    organization = "ACME Examples, Inc"
  }
}

resource "google_privateca_ca_pool" "default" {
  name = "my-ca-pool-05"
  location = "us-central1"
  tier = "ENTERPRISE"
  project = "modular-scout-345114"
  publishing_options {
    publish_ca_cert = true
    publish_crl = true
  }
  labels = {
    foo = "bar"
  }
  issuance_policy {
    baseline_values {
      ca_options {
        is_ca = false
      }
      key_usage {
        base_key_usage {
          digital_signature = true
          key_encipherment = true
        }
        extended_key_usage {
          server_auth = true
        }
      }
    }
  }
}

resource "google_privateca_certificate_authority" "test-ca5" {
  certificate_authority_id = "my-authority5"
  location = "us-central1"
  project = "modular-scout-345114"
  pool = google_privateca_ca_pool.default.name
  deletion_protection = false
  gcs_bucket = data.google_storage_bucket.default.name
  config {
    subject_config {
      subject {
        country_code = "us"
        organization = "google"
        organizational_unit = "enterprise"
        locality = "mountain view"
        province = "california"
        street_address = "1600 amphitheatre parkway"
        postal_code = "94109"
        common_name = "my-certificate-authority"
      }
    }
    x509_config {
      ca_options {
        is_ca = true
      }
      key_usage {
        base_key_usage {
          cert_sign = true
          crl_sign = true
        }
        extended_key_usage {
          server_auth = true
        }
      }
    }
  }
  type = "SELF_SIGNED"
  key_spec {
    algorithm = "RSA_PSS_2048_SHA256"
    //cloud_kms_key_version = data.google_kms_crypto_key_version.crypto_key_version.name
  }
}

resource "google_privateca_certificate" "default" {
  pool = google_privateca_ca_pool.default.name
  certificate_authority = google_privateca_certificate_authority.test-ca5.certificate_authority_id
  project = "modular-scout-345114"
  location = "us-central1"
  lifetime = "860s"
  name = "my-certificate"
  pem_csr = tls_cert_request.example.cert_request_pem
}

data "google_storage_bucket" "default" {
  name          = "bucket-ca-007"
}
