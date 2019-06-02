FROM python:3.7-slim
FROM tensorflow/tensorflow
ENV LANG=C.UTF-8
ARG MATPLOTLIB_VERSION=2.2.0

# Build dependencies
RUN pip3 install --no-cache-dir matplotlib==$MATPLOTLIB_VERSION

WORKDIR /hm2/Minst_data
COPY . /hm2/Minst_data
EXPOSE 600
ENV NAME World
CMD ["python", "handwriting.py"]

                                                                                                                                                           

                                                                              
                                                                              
                                   
