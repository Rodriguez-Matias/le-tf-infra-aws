locals {
  tags = {
    Terraform           = "true"
    Environment         = var.environment
    ProtectFromDeletion = "true"
  }
}

locals {
  # Data source definitions
  #

  # shared
  shared-vpcs = {
    shared-base = {
      region  = var.region
      profile = "${var.project}-shared-devops"
      bucket  = "${var.project}-shared-terraform-backend"
      key     = "shared/network/terraform.tfstate"
    }
  }

  # network
  network-vpcs = {
    network-base = {
      region  = var.region
      profile = "${var.project}-network-devops"
      bucket  = "${var.project}-network-terraform-backend"
      key     = "network/network/terraform.tfstate"
    }
  }

  # apps-devstg
  apps-devstg-vpcs = {
    apps-devstg-base = {
      region  = var.region
      profile = "${var.project}-apps-devstg-devops"
      bucket  = "${var.project}-apps-devstg-terraform-backend"
      key     = "apps-devstg/network/terraform.tfstate"
    }
    apps-devstg-k8s-eks = {
      region  = var.region
      profile = "${var.project}-apps-devstg-devops"
      bucket  = "${var.project}-apps-devstg-terraform-backend"
      key     = "apps-devstg/k8s-eks/network/terraform.tfstate"
    }
    apps-devstg-eks-demoapps = {
      region  = var.region
      profile = "${var.project}-apps-devstg-devops"
      bucket  = "${var.project}-apps-devstg-terraform-backend"
      key     = "apps-devstg/k8s-eks-demoapps/network/terraform.tfstate"
    }
  }

  # apps-prd
  apps-prd-vpcs = {
    apps-prd-base = {
      region  = var.region
      profile = "${var.project}-apps-prd-devops"
      bucket  = "${var.project}-apps-prd-terraform-backend"
      key     = "apps-prd/network/terraform.tfstate"
    }
    #apps-prd-k8s-eks = {
    #  region  = var.region
    # profile = "${var.project}-apps-prd-devops"
    #  bucket  = "${var.project}-apps-prd-terraform-backend"
    # key     = "apps-prd/k8s-eks/network/terraform.tfstate"
    #}
  }

  #
  # Secondary region
  #

  # shared-dr
  shared-dr-vpcs = {
    shared-base-dr = {
      region  = var.region
      profile = "${var.project}-shared-devops"
      bucket  = "${var.project}-shared-terraform-backend"
      key     = "shared/network-dr/terraform.tfstate"
    }
  }

  # network-dr
  network-dr-vpcs = {
    network-base-dr = {
      region  = var.region
      profile = "${var.project}-network-devops"
      bucket  = "${var.project}-network-terraform-backend"
      key     = "network/network-dr/terraform.tfstate"
    }
  }

  # apps-devstg-dr
  apps-devstg-dr-vpcs = {
    apps-devstg-k8s-eks-dr = {
      region  = var.region
      profile = "${var.project}-apps-devstg-devops"
      bucket  = "${var.project}-apps-devstg-terraform-backend"
      key     = "apps-devstg/k8s-eks-dr/network/terraform.tfstate"
    }
  }

  # apps-prd-dr
  apps-prd-dr-vpcs = {}


  datasources-vpcs = merge(
    data.terraform_remote_state.network-vpcs, # network
    #data.terraform_remote_state.shared-vpcs,  # shared
    #data.terraform_remote_state.apps-devstg-vpcs, # apps-devstg-vpcs
    data.terraform_remote_state.apps-prd-vpcs, # apps-prd-vpcs
  )
}
