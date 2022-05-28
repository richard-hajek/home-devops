.PHONY: build terraform destroy terraform-hard deploy send

ensure-env:
	@echo "systemctl start docker"
	@bash -c 'systemctl start docker > /dev/null || echo "Failed to start Docker"'
	@bash -c 'docker run hello-world > /dev/null || echo "Failed to test Docker"'
	@bash -c 'terraform -v > /dev/null || echo "Failed to find terraform"'

build:
	cd docker && ./build.sh

send:
	cd proxmox && ./send.sh

deploy:
	cd docker && ./build.sh
	cd proxmox && ./deployment/erase.sh
	cd proxmox && ./send.sh
	cd terraform && bash reapply.sh
	sleep 10
	cd ansible && ansible managed -a 'sudo reboot'

deploy-test:
	cd docker && ./build.sh
	cd proxmox && ./deployment/erase.sh archlinux-docker.tar.gz
	cd proxmox && ./send.sh archlinux-docker
	cd terraform && bash destroy.sh proxmox_lxc.docker
	cd terraform && bash apply.sh
	sleep 5
	cd ansible && ansible docker.lan -a 'sudo reboot'

terraform:
	cd terraform && bash apply.sh
	cd ansible && ansible managed -a 'sudo reboot'

destroy:
	cd terraform && bash destroy.sh

terraform-hard:
	cd terraform && bash reapply.sh

terraform-hard-test:
	cd terraform && bash destroy.sh proxmox_lxc.docker
	cd terraform && bash apply.sh

reboot:
	cd ansible && ansible managed -a 'sudo reboot'
