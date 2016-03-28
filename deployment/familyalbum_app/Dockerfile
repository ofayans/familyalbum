FROM fedora:latest
RUN dnf install -y python3 python3-devel postgresql-devel git openssh-server \ 
tar vim python3-pip gcc python3-pillow redhat-rpm-config iproute telnet \
postgresql iputils nginx libjpeg-turbo zlib-devel
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key
RUN sed -ir 's/.*ssh_host_ecdsa_key//' /etc/ssh/sshd_config
ADD .ssh /root/.ssh
ADD step2.sh /root/step2.sh
RUN chmod 755 /root/step2.sh
RUN chmod 600 /root/.ssh/ -R
ADD .vim /root/.vim
ADD .vimrc /root/.vimrc
ADD nginx.conf /etc/nginx/nginx.conf
WORKDIR /root
RUN git config --global user.email "ofajans@gmail.com"
RUN git config --global user.name "Oleg Fayans"
RUN git clone git@github.com:ofayans/familyalbum.git
WORKDIR /root/familyalbum
VOLUME /data
RUN pip3 install --upgrade pip
RUN pip3 install -r requirements.txt
# Now fix a bug in flask_thumbnails
RUN sed -ri "s/width, height =/img_url = re.sub('^\/', '', img_url)\n        width, height =/" __init__.py
RUN sed -ri "s/import errno/import errno\nimport re/" __init__.py
ADD sourceme /root/sourceme
ADD dbconnect.sh /root/dbconnect.sh
RUN chmod 755 /root/dbconnect.sh
EXPOSE 22 80
CMD /root/step2.sh
