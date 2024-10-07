docker image ls
docker image pull ros:humble
docker image rm image_name
docker ps: containers rodando
docker ps -a: containers existentes mas nao rodando no momento

// O run do docker roda um comando em um container e quando esse comando termina de
ser executado o container fecha, isso é interessante para deploiar direto no robo
docker run --name <container_name> <container_image>

// Mas para desenvolvimento, pra mexer dentro do container acessamos terminais
(-it: interactive TTY)
docker run -it ros humble
docker container stop container_name
docker container start -i noma_container -> para iniciar um container que está parado

docker container rm container_name
docker container prune: deleta todos os containers exceto os que estiverem rodando no momento

Abrir vário terminais pra mecher num mesmo container:
docker exec -it container_name /bin/bash
/bin/bash abre um novo terminal, executa um terminal dentro do container

Mas podemos executar comandos dentro do container sem necessariamente abrir um terminal:
docker exec -it container_name ls

// DOCKERFILE COMMANDS
// -t nome_da_imagem diretorio_dockerfile
docker image build -t my_image .

O Docker por padrao é executado por meio de usuário root combinado com o comando sudo (sudo docker ...), no entando, caso queira usar seu user atual no docker basta seguir o tutorial:
https://docs.docker.com/engine/install/linux-postinstall/#:~:text=If%20you%20don't%20want,members%20of%20the%20docker%20group.

Se receber um erro do tipo:
```
=> ERROR [internal] load metadata for docker.io/library/ubuntu:18.04                                                                                                            
------
 > [internal] load metadata for docker.io/library/ubuntu:18.04:
------
failed to solve with frontend dockerfile.v0: failed to create LLB definition: rpc error: code = Unknown desc = error getting credentials - err: exec: "docker-credential-desktop.exe": executable file not found in $PATH, out: ``
Makefile:26: recipe for target 'build-local' failed
make: *** [build-local] Error 1
```

Basta abrir o arquivo de configuracao do docker com seu editor de preferencia e renomear o item credsStore to credStore e salvar. Voce tambem pode simplesmente apagar a linha com o credsTore do arquivo e salvar.
```
sudo nano ~/.docker/config.json
# apaga a linha correspondente a credsTore
# salva o arquivo
```

// BIND MOUNTS VS VOLUMES
PWD pega o diretorio atual : nome do diretorio que quero dentro do container
docker run -it -v $PWD/source:/my_source image_name

// nao podemos editar o arquivo do lado de fora porque o aqrquivo foi criado como root dentro do container
docker build -t ros_humble_light .

// running as a new user
docker run -it --user ros -v $PWD/source:/my_source ros_humble_light
Tanto suyanne como ros tem o uid=1000, entao dentro do container os arquivos criados pertencem ao ros, mas fora, pertencem a suyanne

// NETWORKS
--network=host -> para compartilhar a rede com o host da maquina
--ipc=host -> para compartilhar memoria compartilhada
docker run -it \
    --user ros \
    --network=host \
    --ipc=host \
    -v $PWD/source:/my_source ros_humble_light \
    ros2 topic list #podemos passar argumentos adicionais para rodar direto no entrypoint

// ENTRYPOINT
sets up ou run time environment


// GRAPHICS
Um container que tenha permissao para acessar x
xhost + # permissao a todos os users
xhost +local: # permissao a todos os users locais
xhost +local:root # permissao a um user especifico
xhost -local:root # rode com - para desfazer as permissoes dadas
Só se aplica a essa sessao de login!!!

docker run -it \
    --name ros \
    --user ros \
    --network=host \
    --ipc=host \
    -v $PWD/source:/my_source \
    -v /tmp/.X11-unix:/tmp/.X11-unix:rw --env=DISPLAY \
    ros_humble_light

// TIMEZONE
https://youtu.be/RbP5cARP-SM?list=PLunhqkrRNRhaqt0UfFxxC_oj7jscss2qe&t=1286

// ARGUMENT COMPLETION