# Install Velero
wget https://github.com/vmware-tanzu/velero/releases/download/v1.14.1/velero-v1.14.1-linux-amd64.tar.gz
tar -zxvf velero-v1.14.1-linux-amd64.tar.gz
sudo mv velero-v1.14.1-linux-amd64/velero /usr/local/bin/

# Run script for scheduling backups at 3am from staging and prod
./velero-cron.sh

# Test commands
velero backup create --from-schedule petclinic-prod
velero get backups
# check S3 bucket

# To restore from backup
velero restore create --from-backup petclinic-prod-

# Reference documentation
https://velero.io/docs/v1.14/backup-reference/