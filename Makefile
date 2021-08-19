PHONY: all build push run

all: build push

build:
	docker build --network=host -t m1mbert/testpesteve .

push:
	docker push m1mbert/testpesteve

run:
	docker run -dti --net=host m1mbert/testpesteve:latest
	ssh -Xp 2222 root@localhost
