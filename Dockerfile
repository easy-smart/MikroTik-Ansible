FROM python:3-alpine

VOLUME [ "/sys/fs/cgroup" ]
WORKDIR /ansible
EXPOSE 22

RUN python3 -m pip install ansible paramiko
RUN apk update && apk upgrade

RUN mkdir -p /root/.ssh \
  && chmod 0700 /root/.ssh \
  && echo "$ssh_pub_key" > /root/.ssh/authorized_keys \
  && apk add --no-cache openrc openssh \
  && ssh-keygen -A \
  && echo -e "PasswordAuthentication no" >> /etc/ssh/sshd_config \
  && mkdir -p /run/openrc \
  && touch /run/openrc/softlevel

ENV ANSIBLE_GATHERING smart
ENV ANSIBLE_HOST_KEY_CHECKING false
ENV ANSIBLE_RETRY_FILES_ENABLED false
ENV ANSIBLE_ROLES_PATH /ansible/roles
ENV ANSIBLE_SSH_PIPELINING True
ENV ANSIBLE_CONFIG /ansible/ansible.cfg

COPY rootfs /

ENTRYPOINT ["sh", "-c", "rc-status; rc-service sshd start; sh"]
