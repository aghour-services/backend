include environment.env
build:
	docker-compose build

dev:
	docker-compose up

console:
	rails console

sidekiq:
	bundle exec sidekiq

bash:
	docker-compose exec backend bash

stop:
	docker-compose stop

down:
	docker-compose down