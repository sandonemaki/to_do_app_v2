.PHONY: up
up:
	bundle exec rails s -b 0.0.0.0

.PHONY: kill-server-and-start-server-as-daemon
kill-server-and-start-server-as-daemon:
	kill `cat tmp/pids/server.pid` || echo ok
	bundle exec rails s -b 0.0.0.0 -d

.PHONY: pull-from-github
pull-from-github:
	git pull

