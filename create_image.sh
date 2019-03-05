deployConfigFile=PROP_DEPLOY_CONFIG_FILE
app=PROP_APP
replicas=PROP_REPLICAS
registry=PROP_REGISTRY
namespace=PROP_NAMESPACE
env=PROP_ENV
apiEndPoint=PROP_API_END_POINT
tag=$(date +'%d%b')${BUILD_NUMBER}
TAG=${registry}/${namespace}/${app}-${env}:${tag}

echo Deploy Config file=$deployConfigFile
echo app=$app
echo replicas=$replicas
echo registry=$registry
echo namespace=$namespace
echo env=$env
echo tag=$tag
echo TAG=$TAG
echo api end point=$apiEndPoint

sed -i 's/APP_NAME/'${app}'/g' $deployConfigFile
sed -i 's/REPLICAS/'${replicas}'/' $deployConfigFile
sed -i 's/REGISTRY/'${registry}'/' $deployConfigFile
sed -i 's/NAMESPACE/'${namespace}'/' $deployConfigFile
sed -i 's/ENV/'${env}'/' $deployConfigFile
sed -i 's/TAG/'${tag}'/' $deployConfigFile
#cat $deployConfigFile

docker build -t $app .
docker tag $app $TAG

