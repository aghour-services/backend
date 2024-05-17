include environment.env
build:
	docker compose build

up:
	docker compose up

restart:
	docker compose restart
	
logs:
	docker compose logs -f backend

deploy:
	docker compose up -d

console:
	docker compose exec backend rails console

sidekiq:
	docker compose exec sidekiq

bash:
	docker compose exec backend bash

stop:
	docker compose stop

down:
	docker compose down