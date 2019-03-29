## PAM
1. Запретить всем пользователям, кроме группы admin логин в выходные и праздничные дни: <br>
Для включения проверки времени раскомментировал в файле /etc/pam.d/login : <br> 

![](pam_login.png?raw=true)

<br>
Добавил правило - все кто не в группе admin входят кроме выходных дней (как добавить празничные даты не сообразил) <br>

![](pam_time.png?raw=true) 

<br>
2. Дать конкретному пользователю права рута <br>
Создал обычного пользователя noroot <br>
В файле  /etc/security/capability.conf добавил строку: <br>

```
cap_sys_admin noroot 
```

![](capability.png?raw=true)
<br>
В файле /etc/pam.d/login добавил проверку:  <br>
``` 
auth  required  pam_cap.so 
```

![](login.png?raw=true) 
<br>
После входа пользователь наделяется права админа: <br>
![](capsh.png?raw=true)
