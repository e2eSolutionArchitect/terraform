
resource "aws_codedeploy_app" "this" {
  compute_platform = var.compute_platform
  name             = "${var.project}-${var.prefix}-deploy-app"
  tags = merge(
    { "ResourceName" = "${var.project}-${var.prefix}-deploy-app" }, var.tags
  )
}

resource "aws_codedeploy_deployment_group" "this" {
  app_name               = aws_codedeploy_app.this.name
  deployment_group_name  = "${var.project}-${var.prefix}-deploy-grp"
  service_role_arn       = aws_iam_role.this.arn
  deployment_config_name = var.deployment_config_name
  #deployment_config_name = aws_codedeploy_deployment_config.this.id
  trigger_configuration {
    trigger_events     = var.trigger_events
    trigger_name       = var.trigger_name
    trigger_target_arn = aws_sns_topic.this.arn
  }

  blue_green_deployment_config {
    deployment_ready_option {
      action_on_time = "CONTINUE_DEPLOYMENT"
    }

    terminate_blue_instances_on_deployment_success {
      action                           = "TERMINATE"
      termination_wait_time_in_minutes = 5
    }
  }

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }

  deployment_style {
    deployment_option = "WITH_TRAFFIC_CONTROL"
    deployment_type   = "BLUE_GREEN" #"IN_PLACE"
  }

  alarm_configuration {
    alarms  = var.alarms
    enabled = true
  }
}

resource "aws_sns_topic" "this" {
  name = "${var.project}-${var.prefix}-sns-topic"
}


# resource "aws_codedeploy_deployment_config" "this" {
#   deployment_config_name = "${var.cd_app_name}-deployment-config"
#   compute_platform       = "Lambda"
#     traffic_routing_config {
#     type = "TimeBasedLinear"

#     time_based_linear {
#       interval   = 10
#       percentage = 10
#     }
#   }
# }

