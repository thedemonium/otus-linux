## LDAP

### HINT! Для нормальной работы kerberos неоходимо указать ntp-сервер в ipaclient/provisioning/group_vars/ipaclient.yml и ipaserver/provisioning/group_vars/ipaserver.yml

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
![](ipaclient.png?raw=true) <br>
![](web.png?raw=true) <br>

3. Настроить авторизацию по ssh-ключам
Не хватает времени осилить. Для реализации нужно добавить ключ пользователя на ipaserver. <br>
На стороне ipaclient в sshd_config нужно добавить:<br>
```
PubkeyAuthentication yes
UsePAM yes
AuthorizedKeysCommand /usr/bin/sss_ssh_authorizedkeys
AuthenticationMethods publickey,password
```