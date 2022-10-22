#!/bin/bash 

  

NAMESPACE=`kubectl get secret -A -o wide | grep tms-auth-proxy-secret | awk '{print $1}'` 

RSSO_FQDN=`kubectl get configmap helix-on-prem-config -o 'jsonpath={.data.infra_config}' -n $NAMESPACE | grep -vE '^#' | grep ^LB_HOST | cut -f 2 -d '='` 

TMS_FQDN=`kubectl get configmap helix-on-prem-config -o 'jsonpath={.data.infra_config}' -n $NAMESPACE | grep -vE '^#' | grep TMS_LB_HOST | cut -f 2 -d '='` 

CLIENT_ID=`kubectl -n $NAMESPACE get secret tms-auth-proxy-secret --template={{.data.clientid}} | base64 --decode` 

CLIENT_SECRET=`kubectl -n $NAMESPACE get secret tms-auth-proxy-secret --template={{.data.clientsecret}} -n $NAMESPACE| base64 --decode` 

 

echo appurl: https://$TMS_FQDN 

echo clientid: $CLIENT_ID 

echo clientsecret: $CLIENT_SECRET 

echo enableauth: "true" 

echo rssourl: https://$RSSO_FQDN 

echo -e "copy above and create config file....\nDefault RSSO credentials are admin/bmcAdm1n1#"