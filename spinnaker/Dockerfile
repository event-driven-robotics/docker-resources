FROM ubuntu:16.04

RUN apt update
RUN apt install -y python2.7
RUN apt install -y python-pip
RUN pip install --upgrade pip
RUN pip install 'sPyNNaker8==1!4.0.0'
RUN pip install matplotlib
RUN python -m spynnaker8.setup-pynn
