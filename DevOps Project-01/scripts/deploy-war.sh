#!/bin/bash
set -e

# Parse arguments
while [[ "$#" -gt 0 ]]; do
  case $1 in
    --host) HOST="$2"; shift ;;
    --user) USER="$2"; shift ;;
    --key) KEY="$2"; shift ;;
    --war) WAR_PATH="$2"; shift ;;
    *) echo "Unknown parameter passed: $1"; exit 1 ;;
  esac
  shift
done

# Validate inputs
if [[ -z "$HOST" || -z "$USER" || -z "$KEY" || -z "$WAR_PATH" ]]; then
  echo "Usage: deploy-war.sh --host <EC2_HOST> --user <EC2_USER> --key <SSH_KEY_PATH> --war <WAR_FILE_PATH>"
  exit 1
fi

WAR_FILE=$(basename "$WAR_PATH")
REMOTE_TMP="/home/$USER/$WAR_FILE"
TOMCAT_WEBAPPS="/opt/tomcat/webapps"

# echo "[INFO] Copying WAR to EC2 instance..."
# scp -i "$KEY" -o StrictHostKeyChecking=no "$WAR_PATH" "$USER@$HOST:$REMOTE_TMP"

BASTION_HOST="${BASTION_HOST:44.204.60.120}"   # replace with GitHub secret or hardcoded for test
BASTION_USER="${BASTION_USER:-$USER}"             # same user usually

echo "[INFO] Copying WAR to private app server through bastion..."
scp -i "$KEY" -o ProxyJump="$BASTION_USER@$BASTION_HOST" -o StrictHostKeyChecking=no "$WAR_PATH" "$USER@$HOST:$REMOTE_TMP"

# echo "[INFO] Deploying WAR on EC2..."
# ssh -i "$KEY" -o StrictHostKeyChecking=no "$USER@$HOST" << EOF
#   sudo mv "$REMOTE_TMP" "$TOMCAT_WEBAPPS/"
#   sudo chown tomcat:tomcat "$TOMCAT_WEBAPPS/$WAR_FILE"
#   sudo systemctl restart tomcat
# EOF

echo "[INFO] Deploying WAR on app server through bastion..."
ssh -i "$KEY" -o ProxyJump="$BASTION_USER@$BASTION_HOST" -o StrictHostKeyChecking=no "$USER@$HOST" << EOF
  sudo mv "$REMOTE_TMP" "$TOMCAT_WEBAPPS/"
  sudo chown tomcat:tomcat "$TOMCAT_WEBAPPS/$WAR_FILE"
  sudo systemctl restart tomcat
EOF


echo "[INFO] Deployment completed successfully."
