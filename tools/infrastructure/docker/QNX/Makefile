image_name := developer_qnx:build
sdl_core := ~/sdl/sdl_core_dev
sdk_dir := /opt/qnx700
user_id := $(shell id -u $$USER)

build:
	@docker build -t $(image_name) .
run:
	@docker run --rm -it \
		-e LOCAL_USER_ID=$(user_id) \
		-v $(sdl_core):/home/developer/sdl \
		-v $(sdk_dir):/opt/qnx700 \
		$(image_name) build