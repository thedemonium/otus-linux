### LDAP

1. Установить FreeIPA <br>
   <code>
   Сервер: ipaserver [10.0.1.1]<br>
   Домен: nightlight.local<br>
   Дополнительно устанавливается компанент DNS сервер<br>
   Пользователь: admin \ q1w2e3r4t5<br>
   </code>
   
   
2. Написать playbook для конфигурации клиента<br>
   <code>
   Клиент: ipaclient [10.0.1.10]<br>
   Домен: nightlight.local<br>
   В качестве dns сервера указан ipaserver.nightlight.local [10.0.1.1]<br>
   <br>
   После выполенния vagrant можно залогиниться под уз admin:<br>
   Last login: Tue Mar 12 11:44:40 2019 from 10.0.2.2<br>
   vagrant@ipaclient:~$ su - admin<br>
   Password: <br>
   Creating directory '/home/admin'.<br>
   admin@ipaclient:~$ <br>
   </code>

3. Настроить авторизацию по ssh-ключам<br>

