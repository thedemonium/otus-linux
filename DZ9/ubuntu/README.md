Подготовить стенд на Vagrant как минимум с одним сервером. На этом сервере используя Ansible необходимо развернуть nginx со следующими условиями:
- необходимо использовать модуль yum/apt<br>
  apt модуль используется

- конфигурационные файлы должны быть взяты из шаблона jinja2 с перемененными<br>
  файил создаётся на основе шаблона provisioning/roles/nginx/templates/http/default.conf.j2  

- после установки nginx должен быть в режиме enabled в systemd<br>
  роль systemd

- должен быть использован notify для старта nginx после установки<br>
  provisioning/roles/nginx/handlers/main.yml

- сайт должен слушать на нестандартном порту - 8080, для этого использовать переменные в Ansible<br>
  nginx_http_template_enable: true  задаёт что нужно использовать default.conf.j2<br>
  далее передаётся параметр порта

- Сделать все это с использованием Ansible роли<br>
  роль nginx (https://github.com/nginxinc/ansible-role-nginx)



