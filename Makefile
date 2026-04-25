SHELL := /bin/bash

.PHONY: bootstrap cluster addons smoke up down reset status demo demo-clean verify stop checklist \
	helm-lab helm-upgrade-rollback helm-clean \
	lab-day1 lab-day2 lab-day3 lab-day4 lab-day5 lab-day6 lab-day7 lab-trouble

bootstrap:
	./scripts/00-bootstrap-macos.sh

cluster:
	./scripts/10-create-cluster.sh

addons:
	./scripts/20-install-core-addons.sh

smoke:
	./scripts/30-smoke-test.sh

up: bootstrap cluster addons smoke
	@echo "[OK] Base environment is ready."

demo:
	./scripts/40-deploy-learning-app.sh

demo-clean:
	./scripts/41-clean-learning-app.sh

verify:
	kubectl get nodes
	kubectl get pod -A
	kubectl get ingress -A

status:
	colima status || true
	kubectl config current-context || true
	kubectl get nodes || true

down:
	./scripts/90-delete-cluster.sh

reset: down cluster addons smoke
	@echo "[OK] Cluster has been rebuilt."

stop:
	colima stop

start:
	colima start

checklist:
	@cat docs/learning-checklist-7days.zh-CN.md

helm-lab:
	./scripts/50-helm-lab.sh

helm-upgrade-rollback:
	./scripts/51-helm-upgrade-rollback.sh

helm-clean:
	./scripts/52-helm-clean.sh

lab-day1:
	./labs/day1/run.sh

lab-day2:
	./labs/day2/run.sh

lab-day3:
	./labs/day3/run.sh

lab-day4:
	./labs/day4/run.sh

lab-day5:
	./labs/day5/run.sh

lab-day6:
	./labs/day6/run.sh

lab-day7:
	./labs/day7/run.sh

lab-trouble:
	./labs/troubleshooting/run.sh
