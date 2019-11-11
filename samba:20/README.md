#### Comprovacions:

LOCALMENT:
```
[root@samba docker]# smbclient -U pere //localhost/pere
Enter MYGROUP\pere's password: 
Try "help" to get a list of possible commands.
smb: \> ls
  .                                   D        0  Mon Nov 11 11:05:55 2019
  ..                                  D        0  Mon Nov 11 11:05:55 2019
  README.md                           N        2  Mon Nov 11 11:05:55 2019

```


FORA:

```
mount -t cifs -o guest //172.24.0.4/documentation /mnt
[root@192 ~]# mount -t cifs
//172.24.0.4/documentation on /mnt type cifs (rw,relatime,vers=default,sec=none,cache=strict,domain=,uid=0,noforceuid,gid=0,noforcegid,addr=172.24.0.4,file_mode=0755,dir_mode=0755,nounix,serverino,mapposix,rsize=1048576,wsize=1048576,echo_interval=60,actimeo=1)
````


