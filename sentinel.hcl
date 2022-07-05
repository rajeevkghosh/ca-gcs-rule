mock "tfplan/v2" {
  module {
    //source = "mock-selfsign-cryptocreate/mock-tfplan-v2.sentinel"
    source = "mock5/mock-tfplan-v2.sentinel"
  }
}
module "tfplan-functions" {
    source = "./tfplan-functions.sentinel"
}

module "tfstate-functions" {
    source = "./tfstate-functions.sentinel"
}

mock "tfstate/v2" {
  module {
    source = "mock5/mock-tfstate-v2.sentinel"
  }
}
