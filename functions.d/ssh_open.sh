#!/bin/bash

function ssh_open_connection {
  [[ -z $1 ]] && { echo "Usage: ssh_open_connection <host>"; return 1; }

  local host="${1}"
  local timeout="${SSH_TIMEOUT-28800}"


  echo "Opening connection to ${host}"
  if ! ssh_check_connection "${host}" >/dev/null; then
    echo ""
    if ssh -S "$HOME/.ssh/%C" -M -f "${host}" "sleep ${timeout}" 2>/dev/null; then
      if ssh_check_connection "${host}" >/dev/null; then
        echo "    opened"
        return 0
      else
        echo "    opened but failed check?"
        return 1
      fi
    else
      echo "    failed"
      return 1
    fi
  else
    echo "    already opened"
    return 0
  fi
  
  return 1
}
