FROM python:latest

LABEL MAINTAINER="Nischal"

WORKDIR /home/app

COPY . /home/app/


RUN pip install -r requirements.txt 

EXPOSE  80

CMD [ "python", "main.py" ]

