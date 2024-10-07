# Using base images already created
FROM ros:humble

RUN apt-get update && apt-get install -y \
    nano \
    python3-argcomplete \
    && rm -rf /var/lib/apt/lists/*

# Copia os arquivos da pasta config para uma pasta chamada site config na raiz do container
# COPY config/ /site_config/

#  se usarmos o copy, sempre vamos ter que buildar a imagem e isso leva tempo, visto que as imagens de uso do ros e px4 vem com muitas coisas

ARG USERNAME=ros
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Create a non-root user
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && mkdir /home/$USERNAME/.config \
    && chown $USER_UID:$USER_GID /home/$USERNAME/.config


# USER ros -> vc pode usar essa sentenca para realizar coisas em build time como o usuario ros ao inves de root, e se quiser trocar pro root, é só fazer USER root.

# Set up sudo
RUN apt-get update \
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME \
    && rm -rf /var/lib/apt/lists/*

# RUN sudo colcon --log-base /dev/null list

# COPY source /home/${USERNAME}/source
COPY entrypoint.sh /entrypoint.sh
COPY bashrc /home/${USERNAME}/.bashrc

ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]
CMD ["bash"]