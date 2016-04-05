#!/bin/dash

: ${MASTERDIR:="./masterdir"}
: ${HOSTDIR:="./hostdir"}
: ${CACHEDIR:="${HOSTDIR}/repocache"}
: ${CONFDIR:="${HOSTDIR}/xbps.d"}


: ${BASE_PACKAGES:="base-files xbps musl dhclient dracut-network"}
: ${ARCH:=x86_64-musl}
: ${REPOSITORIES:=--repository=http://muslrepo.voidlinux.eu/current" "--repository=http://repo.voidlinux.eu/current}

: ${XBPS_INSTALL_CMD:=$(command -v xbps-install 2>/dev/null)}
[ -z "${XBPS_INSTALL_CMD}" ] && exit 1

_xbps_install() {
  echo "${XBPS_INSTALL_CMD}"
  XBPS_ARCH="$ARCH" ${XBPS_INSTALL_CMD} \
    -C "${CONFDIR}" \
    -c "${CACHEDIR}" \
    -r "${MASTERDIR}" \
    ${REPOSITORIES} \
    $@
}

bootstrap() {
  mkdir -pv \
    "${HOSTDIR}"/{repocache,xbps.d} \
    "${MASTERDIR}"/{dev,proc,sys,hostdir,var/db/xbps/keys}
  cp -v keys/*.plist "${MASTERDIR}/var/db/xbps/keys"
  _xbps_install "-Sy" "${BASE_PACKAGES}"
}

update() {
  :
}

lskernel() {
  :
}

clean() {
  rm -rfv "${HOSTDIR}" "${MASTERDIR}"
}

: ${CMD:="$1"} ; shift
case "${CMD}" in
  bootstrap) bootstrap $@ ;;
  clean) clean $@ ;;
  update) update $@ ;;
  lskernel) lskernel $@ ;;
esac
