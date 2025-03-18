NAME = inception

all:
	@printf "Start containers\n"
	@sudo docker-compose -f ./srcs/docker-compose.yml up -d

build:
	@printf "Build images before starting containers\n"
	@docker-compose -f ./srcs/docker-compose.yml up -d --build

down:
	@printf "Stop containers\n"
	@sudo docker-compose -f ./srcs/docker-compose.yml down

re: down
	@printf "Restart containers\n"
	@sudo docker-compose -f ./srcs/docker-compose.yml up -d --build

clean: down
	@printf "Remove unused networks, containers, images, volumes\n"
	@sudo docker system prune -a

fclean: down
	@printf "Remove all containers, volumes, networks and images\n"
	@docker ps -qa | xargs -r docker stop # Only stop if there are containers
	@sudo docker system prune --all --force --volumes
	@sudo docker network prune --force
	@sudo docker volume prune --force

.PHONY : all build down re clean fclean
