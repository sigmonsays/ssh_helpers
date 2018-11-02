#!/bin/bash

function ssh_close_connection {
  [[ -z $1 ]] && { echo "Usage: ssh_open_connection <host>"; return 1; }

  local host="${1}"

  echo "closing connection to ${host}"
  if ssh_check_connection "${host}" >/dev/null; then
    if ssh -S "$HOME/.ssh/%C" -O exit "${host}" 2>/dev/null; then
      if ! ssh_check_connection "${host}" >/dev/null; then
        echo "    closed"
        return 0
      else
        echo "    sent close command but still open"
        return 1
      fi
    else
      echo "    failed to close"
      return 1
    fi
  else
    echo "    already closed"
    return 0
  fi
  
  return 1
}

function ssh_close_all {
  for ssh_file in $HOME/.ssh/*; do
    if [[ "$(file -b $ssh_file)" == "socket" ]]; then
      sockets_command="$(ps -o cmd= $(lsof -tU "${ssh_file}"))"
      if [[ $sockets_command =~ ssh ]]; then
        echo "closing '${sockets_command}' via ${ssh_file}"
        ssh -S $ssh_file -O exit closesocket
      fi
    fi
  done
}
