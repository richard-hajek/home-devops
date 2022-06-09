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
	cd proxmox && ./send.sh

bootstrap:
	cd docker && ./build.sh
	cd proxmox && ./deployment/erase.sh archlinux-registry.tar.gz || true
	cd proxmox && ./deployment/boostrap.sh
	cd terraform && bash destroy.sh proxmox_lxc.registry
	cd terraform && bash apply.sh proxmox_lxc.registry

deploy:
	cd docker && ./build.sh
	cd docker && ./send.sh
	cd proxmox && ./send.sh
	cd terraform && bash reapply.sh
	sleep 10
	cd ansible && ansible managed -a 'sudo reboot'

terraform:
	cd terraform && bash apply.sh
	cd ansible && ansible managed -a 'sudo reboot'

destroy:
	cd terraform && bash destroy.sh

reboot:
	cd ansible && ansible managed -a 'sudo reboot'

test-audio:
	ssh proxmox.lan mplayer "Stella\ Jang\ Villain.mp3"

refresh-pulse:
	ssh proxmox.lan systemctl --user restart pulseaudio
