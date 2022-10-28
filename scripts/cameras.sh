#!/bin/sh

readonly WEBCONTROL_PORT="8080"
readonly CAMERA_1="10.0.1.1"
readonly CAMERA_2="10.0.1.2"
readonly CAMERA_3="10.0.1.3"

err() {
  echo "[$(date -u +'%Y-%m-%dT%H:%M:%S%:z')]: $*" >&2
}

main() {
  url="detection/status"
  case "$1" in
    "capture"|"c") url="detection/snapshot" ;;
    "pause"|"p") url="detection/pause" ;;
    "start"|"s") url="detection/start" ;;
    "status"|"") url="detection/status" ;;
    *) err "unrecognized command: $1"; exit 1
  esac

  curl --digest --user "${MOTION_USER}:${MOTION_PASSWORD}" \
       "https://${CAMERA_1}:${WEBCONTROL_PORT}/0/${url}"
  curl --digest --user "${MOTION_USER}:${MOTION_PASSWORD}" \
       "https://${CAMERA_2}:${WEBCONTROL_PORT}/0/${url}"
  curl --digest --user "${MOTION_USER}:${MOTION_PASSWORD}" \
       "https://${CAMERA_3}:${WEBCONTROL_PORT}/0/${url}"
}

main "$@"
