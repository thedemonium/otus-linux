
## Cервис который мониторит лог раз в 30 сек:

Создал файлы unitов <br>
Создал файл переменных <br>
Создал файл скрипта поиска и записи в логгер<br>
Запустил timer <br>
![](watchlog1.png?raw=true) <br>

Всё отрабатывает и слово находит. 
НО! Не раз в 30 сек а раз в минуту!? Почему?
![](watchlog2.png?raw=true) <br>

Я явно выставил 120сек - логгер сработал через 3 минуты..<br>
![](watchlog3.png?raw=true) <br>
<br>
> Как так?<br>

## установить spawn-fcgi и переписать init-скрипт на unit-файл:
(Решил попробовать сделать на ubuntu)
- Установил пакеты
~~~~
  apt install spawn-fcgi php php-cgi
~~~~

- Создал файл /etc/default/spawn-fcgi 
~~~~
  SOCKET=/var/run/php-fcgi.sock
  OPTIONS="-u www-data -g www-data -s $SOCKET -S -M 0600 -C 32 -F 1 -- /usr/bin/php-cgi"
~~~~

- Создал файл /etc/systemd/system/spawn-fcgi.service
~~~~
  [Unit]
  Description=Spawn-fcgi startup service by Otus
  After=network.target
  [Service]
  Type=simple
  PIDFile=/var/run/spawn-fcgi.pid
  EnvironmentFile=/etc/default/spawn-fcgi
  ExecStart=/usr/bin/spawn-fcgi -n $OPTIONS
  KillMode=process
  [Install]
  WantedBy=multi-user.target
~~~~

- Стартовал spawn-fcgi юнит
~~~~
  root@ubuntu-bionic:~# systemctl status spawn-fcgi
  ● spawn-fcgi.service - Spawn-fcgi startup service by Otus
   Loaded: loaded (/etc/systemd/system/spawn-fcgi.service; enabled; vendor preset: enabled)
   Active: active (running) since Mon 2019-03-04 13:52:45 UTC; 32min ago
   Main PID: 1546 (php-cgi)
    Tasks: 33 (limit: 1149)
   CGroup: /system.slice/spawn-fcgi.service
           ├─1546 /usr/bin/php-cgi
           ├─1639 /usr/bin/php-cgi
           ├─1640 /usr/bin/php-cgi
           ├─1641 /usr/bin/php-cgi
           ├─1642 /usr/bin/php-cgi
           ├─1643 /usr/bin/php-cgi
           ├─1644 /usr/bin/php-cgi
           ├─1645 /usr/bin/php-cgi
           ├─1646 /usr/bin/php-cgi
           ├─1647 /usr/bin/php-cgi
           ├─1648 /usr/bin/php-cgi
           ├─1649 /usr/bin/php-cgi
           ├─1650 /usr/bin/php-cgi
           ├─1651 /usr/bin/php-cgi
           ├─1652 /usr/bin/php-cgi
           ├─1653 /usr/bin/php-cgi
           ├─1654 /usr/bin/php-cgi
           ├─1655 /usr/bin/php-cgi
           ├─1656 /usr/bin/php-cgi
           ├─1657 /usr/bin/php-cgi
~~~~

## дополнить юнит-файл apache httpd возможностьб запустить несколько инстансов сервера с разными конфигами

- Удалил apache2
~~~~
  apt remove apache2 --purge
~~~~

- Установил lighttpd
~~~~
  apt install lighttpd
~~~~

- Создал файлы окружения
~~~~
  cat /etc/default/lighttpd-1
  OPTIONS=/etc/lighttpd/lighttpd-1.conf

  cat /etc/default/lighttpd-2
  OPTIONS=/etc/lighttpd/lighttpd-2.conf
~~~~

- Скопировал файл дефолтных настроек и поменял порты lighttpd-1.conf - 81, lighttpd-2.conf - 82
~~~~
  cp /etc/lighttpd/lighttpd.conf /etc/lighttpd/lighttpd-1.conf
  cp /etc/lighttpd/lighttpd.conf /etc/lighttpd/lighttpd-2.conf
~~~~

- Добавил @ в имя файла юнита lighttpd.service (без этого не стартовал юнит)
~~~~
  mv /lib/systemd/system/lighttpd.service /lib/systemd/system/lighttpd@.service
~~~~

- Добавил переменную в файла юнита /lib/systemd/system/lighttpd@.service
~~~~
  [Unit]
  Description=Lighttpd Daemon %I
  After=network.target

  [Service]
  Type=simple
  EnvironmentFile=/etc/default/lighttpd-%I
  ExecStart=/usr/sbin/lighttpd -D -f $OPTIONS
  Restart=on-failure

  [Install]
  WantedBy=multi-user.target
~~~~

- Перечитал конфигурацию systemd
~~~~
  systemctl daemon-reload
~~~~

- Запустил оба юнита
~~~~
  systemctl start lighttpd@2
  systemctl start lighttpd@1
~~~~

- Проверил
~~~~
  root@ubuntu-bionic:~# systemctl status lighttpd@1
  ● lighttpd@1.service - Lighttpd Daemon 1
   Loaded: loaded (/lib/systemd/system/lighttpd@.service; disabled; vendor preset: enabled)
   Active: active (running) since Mon 2019-03-04 14:15:15 UTC; 19min ago
   Main PID: 5796 (lighttpd)
    Tasks: 1 (limit: 1149)
   CGroup: /system.slice/system-lighttpd.slice/lighttpd@1.service
           └─5796 /usr/sbin/lighttpd -D -f /etc/lighttpd/lighttpd-1.conf

  Mar 04 14:15:15 ubuntu-bionic systemd[1]: Started Lighttpd Daemon 1.
  root@ubuntu-bionic:~# systemctl status lighttpd@2
  ● lighttpd@2.service - Lighttpd Daemon 2
   Loaded: loaded (/lib/systemd/system/lighttpd@.service; disabled; vendor preset: enabled)
   Active: active (running) since Mon 2019-03-04 14:15:14 UTC; 19min ago
   Main PID: 5750 (lighttpd)
    Tasks: 1 (limit: 1149)
   CGroup: /system.slice/system-lighttpd.slice/lighttpd@2.service
           └─5750 /usr/sbin/lighttpd -D -f /etc/lighttpd/lighttpd-2.conf

  Mar 04 14:15:14 ubuntu-bionic systemd[1]: Started Lighttpd Daemon 2.
  root@ubuntu-bionic:~# lsof -i
  COMMAND    PID            USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
  systemd-n 1384 systemd-network   19u  IPv4  14264      0t0  UDP ubuntu-bionic:bootpc 
  systemd-r 1406 systemd-resolve   12u  IPv4  15385      0t0  UDP localhost:domain 
  systemd-r 1406 systemd-resolve   13u  IPv4  15386      0t0  TCP localhost:domain (LISTEN)
  sshd      1684            root    3u  IPv4  18273      0t0  TCP *:ssh (LISTEN)
  sshd      1684            root    4u  IPv6  18275      0t0  TCP *:ssh (LISTEN)
  sshd      1975            root    3u  IPv4  19377      0t0  TCP ubuntu-bionic:ssh->_gateway:56274 (ESTABLISHED)
  sshd      2145         vagrant    3u  IPv4  19377      0t0  TCP ubuntu-bionic:ssh->_gateway:56274 (ESTABLISHED)
  lighttpd  5750        www-data    4u  IPv4  24151      0t0  TCP *:82 (LISTEN)
  lighttpd  5796        www-data    4u  IPv4  22953      0t0  TCP *:81 (LISTEN)
  ~~~~