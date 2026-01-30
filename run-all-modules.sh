#!/usr/bin/env bash
set -euo pipefail

ROOT="/Users/sej/Desktop/INFRA/aws-ksy/modules"

run() {
  local dir="$1"
  echo "==> ${dir}"
  terraform -chdir="${dir}" init
  terraform -chdir="${dir}" plan
  terraform -chdir="${dir}" apply
}

run "${ROOT}/network/root"
run "${ROOT}/cluster/root"
run "${ROOT}/addons/root"
run "${ROOT}/observability/root"
run "${ROOT}/apps/root"
