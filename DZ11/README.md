### LDAP

1. Установить FreeIPA
```
Сервер: ipaserver [10.0.1.1]
Домен: nightlight.local
Дополнительно устанавливается компанент DNS сервер
Пользователь: admin \ q1w2e3r4t5
```
2. Написать playbook для конфигурации клиента

```
Клиент: ipaclient [10.0.1.10]
Домен: nightlight.local
В качестве dns сервера указан ipaserver.nightlight.local [10.0.1.1]

После выполенния vagrant можно залогиниться под уз admin:
Last login: Tue Mar 12 11:44:40 2019 from 10.0.2.2
vagrant@ipaclient:~$ su - admin
Password: 
Creating directory '/home/admin'.
admin@ipaclient:~$ 
```
3. Настроить авторизацию по ssh-ключам