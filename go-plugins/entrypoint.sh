#!/usr/bin/env bash
set -ex

case $1 in
	"cleanup")
		# cleanup all plugins
		rm /tmp/go-plugins/*.so
		;;
	"bash")
		bash
		;;
	"")
		# see https://docs.konghq.com/gateway-oss/2.2.x/go/

		# build go-pluginserver
		cp /go/bin/go-pluginserver /tmp/go-plugins/
		#go build github.com/Kong/go-pluginserver -o /tmp/go-plugins/

		# build all plugins
		for mod_path in $(find -name "go.mod"); do
			mod_dir=$(dirname ${mod_path})
			mod=$(basename ${mod_dir});

			echo ${mod}...
			(
				cd ${mod_dir};
				go get -v -u ./...
				go test
				go build -buildmode plugin -o /tmp/go-plugins/
			)
		done
		;;
esac
