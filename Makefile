.PHONY: build terraform destroy terraform-hard deploy send

ensure-env:
	@echo "systemctl start docker"
	@bash -c 'systemctl start docker > /dev/null || echo "Failed to start Docker"'
	@bash -c 'docker run hello-world > /dev/null || echo "Failed to test Docker"'
	@bash -c 'terraform -v > /dev/null || echo "Failed to find terraform"'

build:
	cd docker && ./build.sh

send:
	cd docker && ./send.sh

deploy:
	cd docker && ./send.sh
	cd terraform && bash reapply.sh
	sleep 10
	cd ansible && ansible managed -a 'sudo reboot'

terraform:
	cd terraform && bash apply.sh

destroy:
	cd terraform && bash destroy.sh

terraform-hard:
	cd terraform && bash reapply.sh
