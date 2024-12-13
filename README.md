# Configuração do Nginx com Load Balancer

## 1. Configuração do Nginx como Load Balancer

## 1.1 Configuração do arquivo `default.conf`

# Definindo os nós da aplicação (upstream)
upstream react-app {
    server react-app-1:80;
    server react-app-2:80;
    server react-app-3:80;
    server react-app-4:80;
    server react-app-5:80;
}

# Definindo onde o log será escrito e armazenado
access_log /var/log/nginx/nginx-access.log;

# Definindo o caminho do upstream para redirecionar entre os nós
proxy_pass http://react-app;

# Configurando o cabeçalho X-Real-IP para exibir o IP da maquina que está acessando
proxy_set_header X-Real-IP $remote_addr;

## 1.2 Configuração do arquivo `nginx.conf`

# Definindo o formato do log
log_format main '$http_x_real_ip - $remote_user [$time_local] "$request" '
                 '$status $body_bytes_sent "$http_referer" '
                 '"$http_user_agent" "$http_x_forwarded_for"';

# Definindo o caminho para o log de acesso
access_log /var/log/nginx/nginx-access.log main;

## 2. Subdino os containers com docker

## 2.1 - Criando netwrok:
docker network create app-network

## 2.2 Subindo o Load Balancer:
docker run -d -p 80:80 --name loadbalancer --network app-network -v ./default.conf:/etc/nginx/conf.d/default.conf nginx:alpine	

# -d: Roda o container em segundo plano
# -p 80:80: Mapeia a porta 80 do contêiner para a porta 80 do host
# --name: Define o nome do meu container
# --netowrok app-network: Conecta o container a rede
# -v: Monta o arquivo default.conf para o diretório informado dentro do conteiner


## 2.3 Subindo cada nó:
docker run -d -p 80 --name react-app-1 --network app-network -v ./dist:/usr/share/nginx/html -v ./nginx.conf:/etc/nginx/nginx.conf -v ./aplicacao.conf:/etc/nginx/conf.d/default.conf nginx:alpine

# -d: Roda o container em segundo plano
# -p 80:80: Mapeia a porta 80 do contêiner para a porta 80 do host
# --name: Define o nome do meu container
# --netowrok app-network: Conecta o container a rede
# -v ./dist:/usr/share/nginx/html: Monta o arquivo de build da aplicação para o diretório informado dentro do conteiner
# -v ./nginx.conf:/etc/nginx/nginx.conf: Monta o arquivo de configuração do Nginx.
# -v ./aplicacao.conf:/etc/nginx/conf.d/default.conf: Monta o arquivo de configuração da aplicação.