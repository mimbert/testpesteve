all: build push

build:
	docker build --network=host -t m1mbert/testpesteve .

push:
	docker push m1mbert/testpesteve

run:
	docker run -dti --net=host m1mbert/testpesteve:latest
	ssh -Xp 2222 root@localhost

patch:
	for F in *.py ; do sed -ie "s/    main()/    import datetime\n    print(datetime.datetime.isoformat(datetime.datetime.today()) + ': $$F start')\n    main()\n    print(datetime.datetime.isoformat(datetime.datetime.today()) + ': $$F end')/" $$F; done

retrieve:
	scp -P 2222 root@localhost:*.py root@localhost:*.grc .
