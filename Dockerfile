FROM python:3.7-slim
FROM tensorflow/tensorflow
ENV LANG=C.UTF-8
RUN pip install --trusted-host pypi.python.org -r requirements.txt
WORKDIR /hm2/Minst_data
COPY . /hm2/Minst_data
EXPOSE 600
ENV NAME World
CMD ["python", "handwriting.py"]

                                                                                                                                                           

                                                                              
                                                                              
                                   
