IMAGE_NAME=maxh1981/rpi-influxdb

STAGING=_staging
STAGING_FILES=\
	${STAGING}/Dockerfile

.PHONY: all
all: build

.PHONY: build
build: ${STAGING_FILES}
	docker build -t ${IMAGE_NAME} --no-cache --pull ${STAGING}

.PHONY: push
push:
	docker push ${IMAGE_NAME}

	$(eval TAG=$(shell docker run --rm maxh1981/rpi-influxdb dpkg-query --showformat='$${Version}' --show influxdb))
	docker tag ${IMAGE_NAME} ${IMAGE_NAME}:${TAG}
	docker push ${IMAGE_NAME}:${TAG}

.PHONY: clean
clean:
	docker rmi ${IMAGE_NAME} || true
	rm -rf ${STAGING}

${STAGING}/Dockerfile: Dockerfile
	mkdir -p $(dir $@)
	cp $< $@
