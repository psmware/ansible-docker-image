FROM python:3.7-alpine3.10

LABEL author="Pat McLean" \
      maintainer="Pat McLean<pat@psmware.ie>"

ARG USERNAME=coder
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# copy a simple bashrc into homedir from root
COPY .bashrc /root/
COPY requirements /root
RUN ls -l /root

# Python, Ansible and dependencies
RUN echo "===> Adding Python runtime and other packages..."  && \
    apk update \
    && apk add zsh \
    libffi-dev \
    libxml2 \ 
    libxml2-dev \ 
    libxslt \ 
    libxslt-dev \ 
    build-base \ 
    figlet \
    gnupg \
    linux-headers \
    sshpass \
    openssh-client \
    openssl-dev \
    rsync \
    openssl \
    git \
    bash \
    p7zip \
    iptables \
    ca-certificates \
    wget \
    sudo\
    curl \
    busybox \
    busybox-extras \
    && echo "===> Installing Python Packages tools... " \
    && python -m pip install --upgrade pip\
    && python -m pip install --upgrade -r /root/requirements.txt \
    && echo "===> Cleaning up package list..." \
    && rm -rf /var/cache/apk/* \
    && rm -fR /root/*.txt \
    && echo "===> Creating development user and group..." \
    # Configure default group for $USERNAME
    && addgroup --gid $USER_GID $USERNAME \
    # Configure default $USERNAME
    && adduser -s /bin/zsh --uid $USER_UID --ingroup $USERNAME --disabled-password --home /home/$USERNAME $USERNAME \
    # Setup Sudo Access and default ansible folder
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME \
    && mkdir /app \
    && chown -fR $USERNAME.$USERNAME /app
# Setup User Environment
USER ${USERNAME}
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
COPY .zshrc  /home/$USERNAME/
USER root
RUN chown -fR $USERNAME:$USERNAME /home/$USERNAME \
    && echo  "ansible version          : $(ansible --version) \n" \
          "ansible-playbook version : $(ansible-playbook --version) \n" \
          "user                     : $(whoami) \n" \
VOLUME [ "/root", "/app" ]
#
# default command: display Ansible version
CMD [ "sh", "-c", "cd /app; exec zsh -i" ]


