NAME=andriyg/dbtricks

build:
	docker build -t $(NAME) \
		--build-arg http_proxy=$(http_proxy) \
		--build-arg https_proxy=$(http_proxy) \
		--build-arg no_proxy=$(no_proxy) \
		.

