.PHONY: all

all:
	shellcheck entrypoint.sh
	mkdir -p logs tests
	docker build . --tag bug-free-bug
	(sleep 10; open "http://127.0.0.1:6080/vnc.html?autoconnect=true")&
	docker run -it -p 127.0.0.1:6080:6080/tcp -v "$(PWD)/logs":/root/logs -v "$(PWD)/tests":/root/workdir/tests bug-free-bug
