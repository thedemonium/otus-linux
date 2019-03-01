
## Попасть в систему без пароля несколькими способами

Попробовал первый способ через init=/bin/sh <br>
![](1.1.png?raw=true) <br>
Перемоентировал / в rw <br>
![](1.2.png?raw=true) <br>
![](1.3.png?raw=true) <br>
НО... после презагрузки не смог войти под новым паролем<br>
<br>
Попробовал второй способ через  rd.break <br>
![](2.1.png?raw=true) <br>
![](2.2.png?raw=true) <br>
Перемоентировал / в rw <br>
Сменил пароль<br>
Войти не смог<br>
<br>
Способ через rw init=/sysroot/bin/sh <br>
![](3.1.png?raw=true) <br>
![](3.1.png?raw=true) <br>
Результат тот же. По какойто причине не сохраняется изменение пароля.<br>

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
