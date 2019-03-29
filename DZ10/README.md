## PAM
1. Запретить всем пользователям, кроме группы admin логин в выходные и праздничные дни: <br>
1) Для включения проверки времени раскомментировал: <br> 
![](pam_login.png?raw=true) <br>
<br>
2) Добавил правило - все кто не в группе admin входят кроме выходных дней (как добавить празничные даты не сообразил) <br>
![](pam_time.png?raw=true) <br>
<br>
2. Дать конкретному пользователю права рута <br>
1) Создал обычного пользователя noroot
2) В файле  /etc/security/capability.conf добавил строку: <br>

```
cap_sys_admin noroot 
```

![](capability.png?raw=true) <br>
3) В файле /etc/pam.d/login добавил проверку:  <br>
``` 
auth  required  pam_cap.so 
```

![](login.png?raw=true) <br>
4) После входа пользователь наделяется права админа: <br>
![](capsh.png?raw=true) <br>
