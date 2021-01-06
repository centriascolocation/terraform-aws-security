variable "aws_config_configuration_recorder_id" {
  description = "Configuration of config recorder resource"
  default     = ""
  type        = string
}
variable "config_rules" {
  type        = map(any)
  description = "A list of config rules"
  default = {
    root_account_mfa_enabled = {
      name = "root-account-mfa-enabled"
      source = {
        owner             = "AWS"
        source_identifier = "ROOT_ACCOUNT_MFA_ENABLED"
      }
      scope = {
        compliance_resource_types = ["AWS::S3::Bucket"]
      }
    }
    root_account_mfa_enabled = {
      name = "root-account-mfa-enabled"
      source = {
        owner             = "AWS"
        source_identifier = "ROOT_ACCOUNT_MFA_ENABLED"
      }
      scope = {
        compliance_resource_types = []
      }
    }
    incoming_ssh_disabled = {
      name = "incoming-ssh-disabled"
      source = {
        owner             = "AWS"
        source_identifier = "INCOMING_SSH_DISABLED"
      }
      scope = {
        compliance_resource_types = ["AWS::EC2::SecurityGroup"]
      }
    }
    cloud_trail_enabled = {
      name = "cloud-trail-enabled"
      source = {
        owner             = "AWS"
        source_identifier = "CLOUD_TRAIL_ENABLED"
      }
      scope = {
        compliance_resource_types = []
      }
    }
    EC2_SECURITY_GROUP_ATTACHED_TO_ENI = {
      name = "EC2-SECURITY-GROUP-ATTACHED-TO-ENI"
      source = {
        owner             = "AWS"
        source_identifier = "EC2_SECURITY_GROUP_ATTACHED_TO_ENI"
      }
      scope = {
        compliance_resource_types = ["AWS::EC2::SecurityGroup"]
      }
    }
    IAM_ROOT_ACCESS_KEY_CHECK = {
      name = "IAM-ROOT-ACCESS-KEY-CHECK"
      source = {
        owner             = "AWS"
        source_identifier = "IAM_ROOT_ACCESS_KEY_CHECK"
      }
      scope = {
        compliance_resource_types = []
      }
    }
    MFA_ENABLED_FOR_IAM_CONSOLE_ACCESS = {
      name = "MFA_ENABLED_FOR_IAM_CONSOLE_ACCESS"
      source = {
        owner             = "AWS"
        source_identifier = "MFA_ENABLED_FOR_IAM_CONSOLE_ACCESS"
      }
      scope = {
        compliance_resource_types = []
      }
    }
  }
}
