#!/bin/bash

functions_path="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"

for function_file in $functions_path/functions.d/*.sh; do
  source "${function_file}"
done
