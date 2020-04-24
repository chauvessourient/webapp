#!/bin/bash
set -e

command="$@"

case $1 in
	prod-webservice)
		echo "Running production mode ..."
		command="uwsgi --ini /code/uwsgi.ini"
		;;
	prod-worker)
		echo "Running production mode ..."
        command="celery -A manager.conf worker --loglevel=info"
		;;		
	dev-webservice)
		echo "Running dev mode ...!"
        command="python manage.py runserver 0.0.0.0:8000"
		;;
	dev-worker)
		echo "Running dev mode ...!"
        command="celery -A manager.conf worker --loglevel=debug"
		;;		
	migrate)
		echo "Running dev mode ...!"
        command="python manage.py migrate"
        ;;        
	test)
		echo "Running tests mode ..."
        command="python manage.py test"
		;;
	manage)
		echo "Running manage mode ..."
        command="python manage.py ${@:2}"
		;;
esac

exec $command 