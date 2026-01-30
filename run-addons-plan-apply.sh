#!/usr/bin/env bash
set -euo pipefail
terraform -chdir="/Users/sej/Desktop/INFRA/aws-ksy/modules/addons/root" init
terraform -chdir="/Users/sej/Desktop/INFRA/aws-ksy/modules/addons/root" plan
terraform -chdir="/Users/sej/Desktop/INFRA/aws-ksy/modules/addons/root" apply
