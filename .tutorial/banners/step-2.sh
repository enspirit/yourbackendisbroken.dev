# Check wether or not we have a docker volume mounted
HAS_VOLUME_MOUNTED=false
if [ "$DOCKER_ENV" == 1 ]; then
  df -h | grep /ybib > /dev/null 2>&1
  if [ $? == 0 ]; then
    HAS_VOLUME_MOUNTED=true
  fi;
fi

cat <<-EOF
███████╗████████╗███████╗██████╗       ██████╗
██╔════╝╚══██╔══╝██╔════╝██╔══██╗      ╚════██╗
███████╗   ██║   █████╗  ██████╔╝█████╗ █████╔╝
╚════██║   ██║   ██╔══╝  ██╔═══╝ ╚════╝██╔═══╝
███████║   ██║   ███████╗██║           ███████╗
╚══════╝   ╚═╝   ╚══════╝╚═╝           ╚══════╝

EOF

if [ "$HAS_VOLUME_MOUNTED" == true ]; then
cat <<-EOF
Reminder: You will find the source code used in this tutorial
in $YBIB_PWD.

EOF
fi
