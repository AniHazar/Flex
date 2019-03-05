deployConfigFile=PROP_DEPLOY_CONFIG_FILE
app=PROP_APP
registry=PROP_REGISTRY
namespace=PROP_NAMESPACE
env=PROP_ENV
apiEndPoint=PROP_API_END_POINT
cluster=PROP_CLUSTER
tag=$(date +'%d%b')${BUILD_NUMBER}
TAG=${registry}/${namespace}/${app}-${env}:${tag}

echo Deploy Config file=$deployConfigFile
echo app=$app
echo registry=$registry
echo namespace=$namespace
echo cluster=$cluster
echo env=$env
echo tag=$tag
echo TAG=$TAG
echo api end point=$apiEndPoint

/usr/local/ibmcloud/bin/ibmcloud login -a $apiEndPoint -apikey EY_DEV_FRANKFURT_CLUSTER_APIKEY
eval `/usr/local/ibmcloud/bin/ibmcloud cs cluster-config --export $cluster`

#/usr/local/ibmcloud/bin/ibmcloud cr login && docker push $TAG

#kubectl replace -f $deployConfigFile --validate=false
#kubectl delete -f $deployConfigFile
#kubectl create -f $deployConfigFile

kubectl get pod
kubectl get deployment
