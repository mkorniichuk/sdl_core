image_name := developer_agl:build
sdl_core := ~/sdl/sdl_core_dev
user_id := $(shell id -u $$USER)

build:
	@docker build -t $(image_name) .
run:
	@docker run --rm -it \
		-e LOCAL_USER_ID=$(user_id) \
		-v $(sdl_core):/home/developer/sdl \
		$(image_name) build