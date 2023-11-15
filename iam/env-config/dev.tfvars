################################################################################
# COMMON VARIABLES
################################################################################
enviroment = "dev"

project = "terraform-iam"

aws-region = "ap-northeast-1"

################################################################################
# USER GROUP VARIABLES
################################################################################

user-group-list = [
  "app_develop",
  "infra_develop",
  "NonGrid_develop",
  "operators",
  "SD_ADMIN"
]

group-config-root-foler = "env-config/group-config"

################################################################################
# ROLES VARIABLES
################################################################################

roles-list = [
  "RL-SD-NDEV2-BTS-BAT",
  "RL-SD-NDEV2-COM-BST",
  "RL-SD-NDEV2-COM-ECS-TASKRUN",
  "RL-SD-NDEV2-DTD0-TO-INTEGRATION-DEV0",
  "RL-SD-NDEV2-DTD2-TO-INTEGRATION1-DEV0",
  "RL-SD-NDEV2-EC2-RUN-COMMAND",
  "RL-SD-NDEV2-ECS-AUTOSCALEROLE",
  "RL-SD-NDEV2-ECS-INSTANCEROLE",
  "RL-SD-NDEV2-ELS-ECS-SERVICEROLE",
  "RL-SD-NDEV2-ELS-LAMBDA-BEA",
  "RL-SD-NDEV2-FRW-CODEDEPLOY",
  "RL-SD-NDEV2-MNG-CWL-S3",
  "RL-SD-NDEV2-MNG-JKS",
  "RL-SD-NDEV2-MNG-SNQ",
  "RL-SD-NDEV2-MNG-SSM",
  "RL-SD-NDEV2-MNG-TFM",
  "RL-SD-NDEV2-MNG",
  "RL-SD-NDEV2-SSM-ASSUME-SETUP",
  "RL-SD-NDEV2-SSM-EXE-ECF",
  "RL-SD-NDEV2-SSM-EXE",
  "RL-SD-NDEV2-SSM-INSTANCE-SETUP",
  "RL-SD-NDEV2-SSO-RESERVED",
  "RL-SD-NDEV2-ZBX-RDS",
  "RL-SD-NDEV20-BST-BAT",
  "RL-SD-NDEV20-ELS-ECS-MNG",
  "RL-SD-NDEV21-BST-BAT",
  "RL-SD-NDEV21-ELS-ECS-MNG",
]

roles-config-root-foler = "env-config/role-config"