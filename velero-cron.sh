velero schedule create petclinic-prod --schedule="0 3 * * *" --include-namespaces=prod
velero schedule create petclinic-staging --schedule="0 3 * * *" --include-namespaces=staging