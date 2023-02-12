all: build

IMAGE_TAG=aapanel:6.0-local
PERSISTENCE_ROOT=/docker/aapanel/data

build:
	docker build -t $(IMAGE_TAG) .

run-shell:
	docker run -it \
	-p "8888:8888" -p "7800:7800" -p "80:80" -p "888:888" -p "443:443" \
	-v "${PERSISTENCE_ROOT}/server:/www/server" -v "${PERSISTENCE_ROOT}/backup:/www/backup" \
	-v "${PERSISTENCE_ROOT}/wwwroot:/www/wwwroot" -v "${PERSISTENCE_ROOT}/logs:/www/wwwlogs" \
	$(IMAGE_TAG) shell

mrproper:
	rm -rf $(PERSISTENCE_ROOT)/*
