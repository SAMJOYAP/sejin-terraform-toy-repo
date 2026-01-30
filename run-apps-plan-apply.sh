#!/usr/bin/env bash
set -euo pipefail
terraform -chdir="/Users/sej/Desktop/INFRA/aws-ksy/modules/apps/root" init
terraform -chdir="/Users/sej/Desktop/INFRA/aws-ksy/modules/apps/root" plan
terraform -chdir="/Users/sej/Desktop/INFRA/aws-ksy/modules/apps/root" apply
