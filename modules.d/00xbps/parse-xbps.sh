#!/bin/sh

# set xbps.d config options with rd.xbps.[OPTION]=
# add xbps-install params with rd.xbps-install.[OPTION][=[|true|false|*]]

[ -d /etc/xbps.d ] || mkdir -p /etc/xbps.d

_parse_xbps_conf_cmdline() {
  for key in \
      architecture \
      bestmatching \
      cachedir \
      include \
      preserve \
      repository \
      rootdir \
      syslog \
      virtualpkg; do
      for val in $(getargs "xbps.$key" "rd.xbps.$key" | tr -s ',' ' '); do
        printf '%s=%s\n' "$key" "$val"
      done
  done
}

_parse_xbps_install_option() {
    while true; do
        opt="$1" ; shift
        case "${opt:=empty}" in
            empty) break ;;
            automatic|debug|force|ignore-conf-repos|memory-sync|dry-run|sync|unpack-only|update|verbose|yes)
                case "$1" in
                    false|no|0) ;;
                esac \
                    && printf '--%s ' "${opt}" >&3
                break
                ;;
            config|repository|rootdir)
                IFS=':' args="$*"
                IFS=',' ; for arg in "$args"; do
                    printf '--%s %s ' "${opt}" "$arg" >&3
                done
                break
                ;;
            *)
                # exec 3>&- 3>> "/tmp/xbps-install.${opt%%:*}"
                exec 3>&- 3>&1
                ;;
        esac
    done
}

_parse_xbps_install() {
    # TODO: trunacate files: this is probably not necessary
    for f in /tmp/xbps-install*; do printf '' >| "$f"; done

    # exec 3>&- 3>>/tmp/xbps-install
    exec 3>&- 3>&1

    for args in $(getargs "xbps-install" "rd.xbps-install"); do
        echo "args\n$args"
        # IFS=':' set -- $args ; _parse_opt $@
        IFS=':' _parse_xbps_install_option $args
    done

    exec 3>&-
}

_parse_xbps_conf_cmdline > /etc/xbps.d/00-cmdline.conf
_parse_xbps_install

return 0
