# RUN the project
1. Na raiz desse projeto rode o comando:
```bash
colcon build --packages-select cpp_pubsub
```

2. Após a build sem erros, abra DOIS novos terminais e em cada um deles rode:
```bash
. install/setup.bash
```

3. Em um dos dois novos terminais abertos, inicialize o talker:
```bash
ros2 run cpp_pubsub talker
```

4. No terminal restante, inicialize o listener:
```bash
ros2 run cpp_pubsub listener
```