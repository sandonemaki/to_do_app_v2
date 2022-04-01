.PHONY: up
up:
	bundle exec rails s -b 0.0.0.0

.PHONY: kill-server-and-start-server-as-daemon
kill-server-and-start-server-as-daemon:
	kill `cat tmp/pids/server.pid` || echo ok
	bundle exec rails s -b 0.0.0.0 -d

.PHONY: release-for-aws
release-for-aws:
	ssh -i ${SECRET_KEY_PATH_V2} ${USER_NAME_V2}@${HOST_V2} "bash -c 'cd to_do_app_v2 && git pull && make kill-server-and-start-server-as-daemon'"

