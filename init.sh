#!/bin/bash

functions_path="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"

for function_file in $functions_path/functions.d/*.sh; do
  source "${function_file}"
done

function ssh_helpers_help {
cat << EOF
functions

   ssh_forward
   ssh_check_connection
   ssh_open_connection
   ssh_close_connection
   ssh_close_all

EOF
}

ssh_helpers_help
