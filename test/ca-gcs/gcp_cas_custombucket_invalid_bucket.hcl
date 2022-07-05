module "tfplan-functions" {
  source = "../../tfplan-functions.sentinel"
}

module "tfstate-functions" {
    source = "../../tfstate-functions.sentinel"
}

mock "tfplan/v2" {
  module {
    source = "mock-tfplan-v2-custombucket-invalid-bucket.sentinel"
  }
}
mock "tfstate/v2" {
  module {
    source = "mock-tfstate-v2-custombucket-invalid-bucket.sentinel"
  }
}

test {
  rules = {
    main = false
  }
}