# sejin-terraform-toy-repo

## 🧭 프로젝트 개요

이 프로젝트는 Terraform으로 AWS 상에 EKS 기반 애플리케이션 플랫폼을 구성한다. 네트워크(VPC), EKS 클러스터, 필수 애드온(ALB Ingress 등), 애플리케이션(Frontend/Backend)과 Postgres DB까지 인프라와 워크로드를 일관된 방식으로 배포한다. 외부 트래픽은 ALB Ingress를 통해 `/`는 Frontend, `/api`는 Backend로 라우팅되며, Backend는 Postgres와 연결된다. DB는 StatefulSet과 EBS(PVC)를 사용해 데이터 영속성을 보장한다.

### 🧱 아키텍처 요약

- Public Subnet에 ALB가 생성되어 외부 트래픽을 수신
- Private Subnet의 EKS 노드/파드로 트래픽 전달 (Ingress → Service → Pod)
- `/`는 Frontend, `/api`는 Backend로 라우팅
- Postgres는 StatefulSet + PVC(EBS gp2)로 영속화
- Backend는 `POSTGRES_HOST=postgres`로 DB에 연결

## 🧩 Modules 역할/책임

- `modules/network`: VPC, 서브넷, 라우팅 등 네트워크 베이스 구성
- `modules/cluster`: EKS 클러스터 및 노드 그룹 구성
- `modules/addons`: EKS 애드온(예: AWS Load Balancer Controller 등) 설치
- `modules/apps`: 애플리케이션(Frontend/Backend) 및 DB(Postgres) 배포 리소스
- `modules/observability`: 모니터링/로깅 스택 구성
- `modules/dns`: Route53 Hosted Zone 및 ACM 인증서(선택) 구성
- `modules/ecr`: ECR 리포지토리 생성 및 관리

## 🛠️ Scripts

- `run-all-modules.sh`: 전체 모듈을 순서대로 `init/apply` 실행
- `run-all-modules-plan-apply.sh`: 전체 모듈을 순서대로 `init/plan/apply` 실행
- `run-network-plan-apply.sh`: 네트워크 모듈 `init/plan/apply` 실행
- `run-cluster-plan-apply.sh`: 클러스터 모듈 `init/plan/apply` 실행
- `run-addons-plan-apply.sh`: 애드온 모듈 `init/plan/apply` 실행
- `run-observability-plan-apply.sh`: 관측성 모듈 `init/plan/apply` 실행
- `run-apps-plan-apply.sh`: 앱 모듈 `init/plan/apply` 실행
