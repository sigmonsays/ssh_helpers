#!/bin/bash

function ssh_forward {
  [[ -z $2 ]] && { echo "Usage: ssh_forward <host> <remote port> [<local port>]"; return 1; }  
  
  local host="${1}"
  local remote_port="${2}"
  local local_port="${3-$2}"
  local remote_host="${4-localhost}"
  
  echo "requesting forward of ${local_port} to ${remote_host}:${remote_port} via ${host}"
  if ssh_check_connection "${host}" >/dev/null; then
    if ssh -L "${local_port}:${remote_host}:${remote_port}" -S "$HOME/.ssh/%C" -O forward "${host}" 2>/dev/null; then
      echo "    forwarded"
      return 0
    else
      echo "    failed"
      return 1
    fi
  else
    echo "    host not connected"
    return 1
  fi
  
  return 1
}
  
