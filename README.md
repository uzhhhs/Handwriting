本程序部署在docker中，实现了从Mnist数据集中提取手写体图片，通过模型训练，使程序学习识别数字，同时将数据集中的数字识别出来返回给用户，将返回给用户的数字、当前时间戳存入Cassandra数据库中。

下面将给出程序实现过程：
1.需要一台安装并配置好docker、Python、TensorFlow、Cassandra、Cassandra-driver的Linux系统的电脑，同时需要预留足够的磁盘空间。

2.创建一个单独的文件夹，从官网上下载mnist数据集：http://yann.lecun.com/exdb/mnist/
train-images-idx3-ubyte.gz:  training set images (9912422 bytes) 
train-labels-idx1-ubyte.gz:  training set labels (28881 bytes) 
t10k-images-idx3-ubyte.gz:   test set images (1648877 bytes) 
t10k-labels-idx1-ubyte.gz:   test set labels (4542 bytes)

3.将代码handwriting.py放入文件夹中，同时创建好Dockerfile文件，指定好文件的位置以及暴露的端口，需要基于的基础镜像。

4.通过pip freeze指令获取当前Python环境引用的包，同时通过pip install -r requirements.txt生成requirements.txt文件，可以发现此文件内部有许多的包，但是项目可能用不上，可自行抉择。

5.配置Cassandra数据库，首先创建Cassandra镜像，network服务，并且设置好-p中的端口映射，启动容器：
docker run --name some-cassandra -p 9042:9042 -d cassandra:latest

6.通过Python命令行测试能否连接上数据库，同时提前创建好keyspace和其中的table，以便使用：
   from cassandra.cluster import Cluster
   cluster = Cluster(contact_points=['127.0.0.1'],port=9042) #设置端口
   session = cluster.connect() #连接数据库
   
7.在handwriting.py Dockerfile requirements.txt的目录下，运行docker build --tag=handwriting . 构建镜像（注意最后的“.”必不可少）此步骤需要collecting你所涉及到的各种包、镜像，用时较长，可能由于版本的问题还需要自行改变requirements.txt的内容。

8.运行镜像 docker run handwriting 观察到训练模型的建立（共50000次，结果越来越接近1）

9.重新打开一个终端，运行curl -x POST ...指令，指定端口地址，应用类型，以及title（也就是训练集的前N张图片）的数量，将数量以json的方式传递进程序。同时程序会自动弹出一个图片窗口，显示训练集中的图片，在第一个终端下可以看到识别结果。

10.关闭图片窗口，第一个终端下会自动将数据库中的table中的数据遍历出来（应用了select * from...），可观察到识别结果已经写入数据库。程序运行完毕。

视频地址：链接: https://pan.baidu.com/s/12oa4Du9oiNqc6oNoQGRhYw 提取码: uwwg 复制这段内容后打开百度网盘手机App，操作更方便哦
