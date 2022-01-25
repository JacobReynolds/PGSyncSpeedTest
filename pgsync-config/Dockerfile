FROM python:3.7

WORKDIR /usr/src/app
RUN python3 -m pip install pgsync==2.1.10

# Uncomment if using plugins
# RUN mkdir /usr/src/pythonpath/
# COPY ./plugins /usr/src/pythonpath/plugins

# ENV PYTHONPATH /usr/src/pythonpath

COPY schema.json .
COPY run.sh .
COPY wait-for-it.sh .

RUN chmod +x run.sh
RUN chmod +x wait-for-it.sh