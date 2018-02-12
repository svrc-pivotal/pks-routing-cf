KUBERNETES_API_HOSTNAME=tcp.your.cf.domain
KUBERNETES_API_PORT=your-tcp-router-port-for-k8s
KUBERENTES_MASTER_IP=your-master-ip-address
CF_SYSTEM_DOMAIN=your-cf-system-domain
TCP_EMITTER_SECRET=your-tcp-emitter-uaa-secret
PKS_API_ANNOUNCE_APP_NAME=pks-api-announce

cd api-announce && cf push --no-start
cf set-env $PKS_API_ANNOUNCE_APP_NAME BACKEND_PORT 8443
cf set-env $PKS_API_ANNOUNCE_APP_NAME BACKEND_IP $KUBERNETES_MASTER_IP
cf set-env $PKS_API_ANNOUNCE_APP_NAME KUBO_PORT $KUBERNETES_API_PORT
cf set-env $PKS_API_ANNOUNCE_APP_NAME CLOUD_FOUNDRY_API_URL https://api.$CF_SYSTEM_DOMAIN
cf set-env $PKS_API_ANNOUNCE_APP_NAME UAA_API_URL https://uaa.$CF_SYSTEM_DOMAIN
cf set-env $PKS_API_ANNOUNCE_APP_NAME UAA_CLIENT_ID tcp_emitter
cf set-env $PKS_API_ANNOUNCE_APP_NAME UAA_CLIENT_SECRET $TCP_EMITTER_SECRET

cf start $PKS_API_ANNOUNCE_APP_NAME
 
#cd ../route-sync && cf push --no-start
