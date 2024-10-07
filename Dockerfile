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

# Set up sudo
RUN apt-get update \
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME \
    && rm -rf /var/lib/apt/lists/*

# Setup Micro XRCE-DDS Agent & Client
# Setup the Agent
# USER root
RUN git clone https://github.com/eProsima/Micro-XRCE-DDS-Agent.git \
    && cd Micro-XRCE-DDS-Agent \
    && mkdir build \
    && cd build \
    && cmake .. \
    && make \
    && make install

# Install PX4
RUN apt-get update \
&& apt-get install -y wget

RUN git clone https://github.com/PX4/PX4-Autopilot.git --recursive \
    && bash ./PX4-Autopilot/Tools/setup/ubuntu.sh \
    && cd PX4-Autopilot \
    && make px4_sitl \
    && sudo ldconfig /usr/local/lib/

RUN sudo rm -r /PX4-Autopilot/Tools/simulation/gz \
    && chown -R $USER_UID:$USER_GID /PX4-Autopilot/build
COPY source/gz /PX4-Autopilot/Tools/simulation/gz

# && cp -r /arena_cbr_2024/gz /PX4-Autopilot/Tools/simulation/gz \
# COPY /my_source/arena_cbr_2024/gz /PX4-Autopilot/Tools/simulation/gz \
#     && chown -R $USER_UID:$USER_GID /PX4-Autopilot/build
# USER ros
COPY entrypoint.sh /entrypoint.sh
COPY bashrc /home/${USERNAME}/.bashrc

ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]
CMD ["bash"]

