
## Попасть в систему без пароля несколькими способами

Попробовал первый способ через init=/bin/sh <br>
![](1.1.png?raw=true) <br>
Перемонтировал / в rw <br>
![](1.2.png?raw=true) <br>
![](1.3.png?raw=true) <br>
НО... после перезагрузки не смог войти под новым паролем<br>
<br>
Попробовал второй способ через  rd.break <br>
![](2.1.png?raw=true) <br>
![](2.2.png?raw=true) <br>
Перемонтировал / в rw <br>
Сменил пароль<br>
Войти не смог<br>
<br>
Способ через rw init=/sysroot/bin/sh <br>
![](3.1.png?raw=true) <br>
![](3.1.png?raw=true) <br>
Попробовал создать нового пользователя test и задал ему новый пароль.<br>
Результат тот же. По какой то причине не сохраняется изменение пароля.<br>

## Установить систему с LVM, после чего переименовать VG

![](vg_renamed.png?raw=true) <br>
Получилось.<br>

## Добавить модуль в initrd

![](init_module.png?raw=true) <br>
<br>
Создал папку /usr/lib/dracut/modules.d/01test <br>
Скачал туда скрипты module-setup.sh test.sh (сделал их исполняемыми) <br>
Собрал новый init: mkinitrd -f -v /boot/initramfs-$(uname -r).img $(uname -r) <br>
Убрал опции rghb и quiet в файле /etc/default/grub далее сгенерил меню grub2-mkconfig -o /boot/grub2/grub.cfg <br>
Перезагрузился. <br>
<br>
Паузы 10 сек нет. Пингвина не видно ;( <br>
Что то не так...
<br>
<br>
** UPDATE **<br>
пропустил момент с touch /.autorelabel (перед перезагрузкой нужно создать файл .autorelabel для SELinux)<br>
повторил способы смены пароля - получилось<br>
** UPDATE 18 Mar 2019 **<br>
Добавил в Vagrantfile порядок своих действий

```
dracut -f -v
centos: *** Including module: test ***
```
Модуль находит.<br>

```
[vagrant@centos ~]$ sudo  lsinitrd -m /boot/initramfs-$(uname -r).img | grep test
test
```
Модуль есть в initramfs <br>
Попробовал другой имидж.<br>
Попробовал обновиться через yum update.<br>
В результате всёравно не вижу пингвина. Но задержка при загрузке в несколько сек появляется.<br>
Пробовал файл module-setup.sh переименовать в module_setup.sh (как он назван по ссылке) но тогда dracut не находит новый модуль...<br>
Уже думаю ... с этим пингвином! ;) Он как суслик... скорее всего есть но мы его не видим!<br>
