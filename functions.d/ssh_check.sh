#!/bin/bash

function ssh_check_connection {
  [[ -z $1 ]] && { echo "Usage: ssh_check_connection <host>"; return 1; }

  local host="${1}"

  echo "Checking ${host} connection"

  if ssh -S "$HOME/.ssh/%C" -O check "${host}" 2>/dev/null; then
    echo "    connected"
    return 0
  else
    echo "    closed"
    return 1
  fi

  return 1
}

