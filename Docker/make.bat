cd /d "%~dp0"
mkdir logs
mkdir tests
docker build . --tag bug-free-bug
docker run -it -p 127.0.0.1:6080:6080/tcp -v "%cd%\logs":/root/logs -v "%cd%\tests":/root/workdir/tests bug-free-bug
