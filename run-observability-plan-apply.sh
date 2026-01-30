#!/usr/bin/env bash
set -euo pipefail
terraform -chdir="/Users/sej/Desktop/INFRA/aws-ksy/modules/observability/root" init
terraform -chdir="/Users/sej/Desktop/INFRA/aws-ksy/modules/observability/root" plan
terraform -chdir="/Users/sej/Desktop/INFRA/aws-ksy/modules/observability/root" apply
