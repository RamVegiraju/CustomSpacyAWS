FROM python:3.8
#FROM ubuntu:latest



#RUN apt-get install -y libzmq3-dev python3-pip
#RUN apt-get clean
#RUN pip3 install --upgrade pip

#RUN apt-get install python3 \   apt-get install python3-pip 


#Virtual Environemnt
ENV VIRTUAL_ENV=/opt/venv
RUN python3 -m venv $VIRTUAL_ENV


RUN apt-get -y update && apt-get install -y --no-install-recommends \
         wget \
         python3 \
         nginx \
         ca-certificates \
    && rm -rf /var/lib/apt/lists/*

#Dependencies
#COPY requirements.txt .
#RUN pip3 install -r requirements.txt
RUN wget https://bootstrap.pypa.io/get-pip.py && python3 get-pip.py && \
    pip install flask gevent gunicorn && \
        rm -rf /root/.cache


RUN pip install scispacy
RUN pip install spacy
RUN pip install https://s3-us-west-2.amazonaws.com/ai2-s2-scispacy/releases/v0.3.0/en_core_sci_sm-0.3.0.tar.gz


ENV PYTHONUNBUFFERED=TRUE
ENV PYTHONDONTWRITEBYTECODE=TRUE
ENV PATH="/opt/program:${PATH}"


#EXPOSE 5000
#CMD python ./index.py

COPY NER /opt/program
WORKDIR /opt/program
RUN chmod +x /opt/program/serve