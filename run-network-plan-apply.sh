#!/usr/bin/env bash
set -euo pipefail
terraform -chdir="/Users/sej/Desktop/INFRA/aws-ksy/modules/network/root" init
terraform -chdir="/Users/sej/Desktop/INFRA/aws-ksy/modules/network/root" plan
terraform -chdir="/Users/sej/Desktop/INFRA/aws-ksy/modules/network/root" apply
