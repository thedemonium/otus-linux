# Данный Vagrantfile создаёт виртуальную машину и устанавливает ubuntu xenial. 
Внутри виртуальной машины создаётся zfs zpool: syspool 
На датасет syspool/ROOT/ubuntu переносится корень. На все диски утанавливается загрузчик.
После первого выполениня нужно удалить из конфигурации виртуальной машины первый диски: ubuntu-xenial-16.04-cloudimg.vmdk и ubuntu-xenial-16.04-cloudimg-configdrive.vmdk
(в конфигурации остаются только диски с пуллом zfs: sata1-sata4)


