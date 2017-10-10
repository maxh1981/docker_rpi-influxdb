IMAGE_NAME=maxh1981/rpi-influxdb

STAGING=_staging
STAGING_FILES=\
	${STAGING}/Dockerfile

.PHONY: all
all: build

.PHONY: build
build: ${STAGING_FILES}
	docker build -t ${IMAGE_NAME} --no-cache --pull ${STAGING}

${STAGING}/Dockerfile: Dockerfile
	mkdir -p $(dir $@)
	cp $< $@
