FROM python:3
ARG api_ip
ENV TODO_API_IP=34.135.29.160
RUN pip install flask
RUN pip install requests
EXPOSE 5000/tcp
COPY todolist.py .
COPY templates/index.html templates/
CMD python todolist.py