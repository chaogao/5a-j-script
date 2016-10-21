SERVER_ROOT=/home/gaochao/env

#PRO_ROOT=${WORKSPACE}

WORKSPACE_ROOT=/home/gaochao/.jenkins/workspace

app=$1

case $app in
  "task"|"user")
    echo "deploying ${app}"
    PRO_ROOT=${WORKSPACE_ROOT}/5a-${app}
    ;;
  *)
    echo "only can deploy task or user app"
    exit;
    ;;
esac

if [ ! -e $PRO_ROOT ]; then
  echo "loaction app is error: ${PRO_ROOT}"
  exit 1
fi

echo $PRO_ROOT

# copy app jianguo style
if [ -e ${PRO_ROOT}/app ]; then
  cp -r ${PRO_ROOT}/apps/* ${SERVER_ROOT}/apps/
  cp -r ${PRO_ROOT}/webroot/${app}/* ${SERVER_ROOT}/webroot/${app}/
else
# huangpeng style
  echo "huangpeng"
  mkdir -p ${SERVER_ROOT}/apps/${app}/
  mkdir -p ${SERVER_ROOT}/webroot/${app}/
  mkdir -p ${SERVER_ROOT}/conf/${app}/
  cp -r ${PRO_ROOT}/application/* ${SERVER_ROOT}/apps/${app}/
  cp -r ${PRO_ROOT}/index.php ${SERVER_ROOT}/webroot/${app}/
  cp -r ${PRO_ROOT}/conf/* ${SERVER_ROOT}/conf/${app}/
fi


# restart php
echo "restart php ..."
sh ${SERVER_ROOT}/bin/controll restart php-fpm
echo "restart nginx"
sh ${SERVER_ROOT}/bin/controll restart nginx

echo "deploy success ${app}"
