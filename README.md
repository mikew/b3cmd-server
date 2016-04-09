# b3cmd-server

> **TODO** Better documentation is coming

## docker-compose

```yaml
b3cmd:
  image: mikewhy/b3cmd-server
  ports:
    - "2224:22"
  environment:
    - B3CMD_HOST_PWD=${PWD}/persistent/b3cmd/projects
    - B3CMD_VIRTUAL_HOST_TEMPLATE=%(project_host_name)s.example.com
    - B3CMD_GIT_TEMPLATE=git@git.example.com:%(namespace)s/%(project_name)s.git
  volumes:
    - ./persistent/b3cmd/data:/home/b3cmd/data
    - ./persistent/b3cmd/projects:${PWD}/persistent/b3cmd/projects
    - /var/run/docker.sock:/var/run/docker.sock:ro

nginxgen:
  image: mikewhy/docker-gen-letsencrypt
  environment:
    - LETSENCRYPT_EMAIL=you@gmail.com
    - NGINX_CONTAINER=b3cmdserver_nginx_1
  volumes:
    - /var/run/docker.sock:/var/run/docker.sock:ro
  volumes_from:
    - nginxdata

nginx:
  image: nginx:latest
  ports:
    - "80:80"
    - "443:443"
  volumes:
    - ./persistent/nginx/logs:/var/log/nginx
  volumes_from:
    - nginxdata

nginxdata:
  image: alpine
  command: "true"
  volumes:
    - ./persistent/nginx/conf.d:/etc/nginx/conf.d
    - ./persistent/nginx/vhost.d:/etc/nginx/vhost.d
    - ./persistent/nginx/certs:/etc/nginx/certs
    - ./persistent/nginx/htpasswd:/etc/nginx/htpasswd
    - ./persistent/nginx/html:/usr/share/nginx/html
```
