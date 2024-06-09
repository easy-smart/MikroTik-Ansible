# Ansible



## Build ansible docker container

```powershell
docker build -t ansible_mikrotik .
```



## Run ansible docker container

```powershell
docker run -it --rm -v .\ansible:/ansible --publish 22:22 --name ansible_mikrotik ansible_mikrotik
```



