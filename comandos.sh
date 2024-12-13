# criar network
docker network create app-network

# subir o LB
docker run -d -p 80:80 --name loadbalancer --network app-network -v ./default.conf:/etc/nginx/conf.d/default.conf nginx:alpine	

# subir os nos dentro da minha pasta da app
docker run -d -p 80 --name react-app-1 --network app-network -v ./dist:/usr/share/nginx/html -v ./nginx.conf:/etc/nginx/nginx.conf -v ./aplicacao.conf:/etc/nginx/conf.d/default.conf nginx:alpine
docker run -d -p 80 --name react-app-2 --network app-network -v ./dist:/usr/share/nginx/html -v ./nginx.conf:/etc/nginx/nginx.conf -v ./aplicacao.conf:/etc/nginx/conf.d/default.conf nginx:alpine
docker run -d -p 80 --name react-app-3 --network app-network -v ./dist:/usr/share/nginx/html -v ./nginx.conf:/etc/nginx/nginx.conf -v ./aplicacao.conf:/etc/nginx/conf.d/default.conf nginx:alpine
docker run -d -p 80 --name react-app-4 --network app-network -v ./dist:/usr/share/nginx/html -v ./nginx.conf:/etc/nginx/nginx.conf -v ./aplicacao.conf:/etc/nginx/conf.d/default.conf nginx:alpine
docker run -d -p 80 --name react-app-5 --network app-network -v ./dist:/usr/share/nginx/html -v ./nginx.conf:/etc/nginx/nginx.conf -v ./aplicacao.conf:/etc/nginx/conf.d/default.conf nginx:alpine
