5A_SERVER_ROOT=/home/gaochao/env

#PRO_ROOT=${WORKSPACE}

PRO_ROOT=/home/gaochao/.jenkins/workspace/5a-task

app=$1

case $app in
  "task"|"user")
    echo "deploying ${app}"
    ;;
  *)
    echo "only can deploy task or user app"
    exit;
    ;;
esac

# copy app
cp -r ${PRO_ROOT}/app/ ${5A_SERVER_ROOT}/app/

# copy webroot
cp -r ${PRO_ROOT}/webroot/ ${5A_SERVER_ROOT}/webroot/${app}/