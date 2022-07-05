mock "tfplan/v2" {
  module {
    //source = "mock-selfsign-cryptocreate/mock-tfplan-v2.sentinel"
    source = "mock2/mock-tfplan-v2.sentinel"
  }
}
module "tfplan-functions" {
    source = "./tfplan-functions.sentinel"
}
