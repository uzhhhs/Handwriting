FROM python:3.7-slim
FROM tensorflow/tensorflow
WORKDIR /project
COPY . /project
RUN pip install matplotlib
RUN pip install -r requirements.txt
EXPOSE 600
ENV NAME World
CMD ["python", "handwriting.py"]


~                                                                                                          
~                                                                                                          
~                                                                                                          
~                                                                                                          
~                                                                                                          
~                                      
