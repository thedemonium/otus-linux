Привет!<br>

1. Самый простой скрипт watchdog_mc.sh порождает дочерний процес mc в цикле while.<br>
   Первая строка запускает mc и ожидает его окончания. <br>
   until – будет выполняться до тех пор, пока условие не станет истинным, <br>
   Если статус выхода равен 0, это означает, что процесс завершился нормально. В этом случае мы не перезапускаем его. <br>
   Если состояние выхода не равно 0 то процесс перезапустится через секунду.<br>

2. Последний скрипт который писал для работы:<br>
   Другим скриптом по крону раз в день и каждый час создаётся снепшот контейнера в репликой postgres.<br>
   Скрипт pg_snap_create без параметров выводит список доступных снепшотов и проверяет список IP из пула на предмет занятости. <br>
   Полученные даты и свободные IP можно использовать в качестве параметров.<br>
   Пример параметров для скрипта: pg_snap_create hourly-2019-01-15-07-00 192.168.2.42<br>
   После проверки на правильный ввод выполняется функция create_replica()<br>
   Создаётся клон контейнера lxc за выбранную дату. <br>
   В настройки контейнера передается IP адрес. В полученном контейнере изменяется роль postgres с реплики на мастер для дальнейших экспериментов с базой.<br>

3. pg_snap_remove удаляет созданный ранее тестовый контейнер. Запуск без параметров показывает уже созданные ранее контейнеры и IP адреса им назначенные.<br>
   Пример параметра: pg_snap_remove hourly-2019-01-15-07-00<br>

Скрипты не претендуют на эталонные ;) Но свою задачу они выполняют.<br>