#!/usr/bin/env bash
set -euo pipefail
terraform -chdir="/Users/sej/Desktop/INFRA/aws-ksy/modules/cluster/root" init
terraform -chdir="/Users/sej/Desktop/INFRA/aws-ksy/modules/cluster/root" plan
terraform -chdir="/Users/sej/Desktop/INFRA/aws-ksy/modules/cluster/root" apply
