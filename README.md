# Ansible





## Build

```powershell
docker build -t ansible_mikrotik .
```







```powershell
docker run -it --rm -v .\ansible:/ansible --publish 22:22 --name ansible_mikrotik ansible_mikrotik
```

