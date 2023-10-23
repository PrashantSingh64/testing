provider "alicloud" {
  access_key = "LTAI5t6jen4QXx2UFBFEigGJ"
  secret_key = "eexR6CvzcN7lCmdelclUd6HxAMr5OF"
  region     = "cn-beijing"
}

resource "random_uuid" "cpu" {}

# Define the resources to monitor
resource "alicloud_cms_group_metric_rule" "CPU_Rul" {
  group_id    = "173445410"
  rule_id     = random_uuid.cpu.id
  category    = "ecs"
  namespace   = "acs_ecs_dashboard"
  metric_name = "cpu_total"
  period      = "60"

  group_metric_rule_name = "CPU_Usage1"
  contact_groups         = "ECS-test1"
  escalations {
    warn {
      comparison_operator = "GreaterThanOrEqualToThreshold"
      statistics          = "Average"
      threshold           = "80"
      times               = 3
    }
  }
}
resource "random_uuid" "Disk" {}
resource "alicloud_cms_group_metric_rule" "Disk" {
  group_id    = "173445410"
  rule_id     = random_uuid.Disk.id
  category    = "ecs"
  namespace   = "acs_ecs_dashboard"
  metric_name = "diskusage_total"
  period      = "60"

  group_metric_rule_name = "High_Disk_Usage"
  contact_groups         = "ECS-test1"
  escalations {
    warn {
      comparison_operator = "GreaterThanOrEqualToThreshold"
      statistics          = "Average"
      threshold           = "85"
      times               = 3
    }
  }
}
resource "random_uuid" "Memory" {}
resource "alicloud_cms_group_metric_rule" "Memory" {
  group_id    = "173445410"
  rule_id     = random_uuid.Memory.id
  category    = "ecs"
  namespace   = "acs_ecs_dashboard"
  metric_name = "memoryusage_total"
  period      = "60"

  group_metric_rule_name = "High_Memory_Usage"
  contact_groups         = "ECS-test1"
  escalations {
    warn {
      comparison_operator = "GreaterThanOrEqualToThreshold"
      statistics          = "Average"
      threshold           = "80"
      times               = 3
    }
  }
}
resource "alicloud_cms_alarm_contact" "alertcontact" {
  alarm_contact_name = "ECS-monitor"
  describe           = "For Test"
  channels_mail      = "Prashant.Singh@genmills.com"
  lang               = "en"
}
resource "alicloud_cms_alarm_contact_group" "alertgroup" {
  alarm_contact_group_name = "ECS-test1"
  contacts                 = [alicloud_cms_alarm_contact.alertcontact.alarm_contact_name]
}