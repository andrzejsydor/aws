[https://aws.amazon.com/docker/](https://aws.amazon.com/docker/)

[Deploy Docker Containers on Amazon Elastic Container Service Amazon ECS](https://aws.amazon.com/getting-started/hands-on/deploy-docker-containers/)

# Install Docker and Docker Compose on Amazon Linux

Create EC2 based on Amazon Linux 2



Paste in user data section:

```sh
#!/bin/bash
sudo yum update -y
sudo amazon-linux-extras install docker
sudo service docker start
sudo usermod -a -G docker ec2-user
sudo systemctl enable docker

sudo curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```



Check if working correctly

```sh
docker info
docker run hello-world
docker-compose version
```



Create file `docker-compose.yml` with content

```
version: '3'
services:
  web1:
    container_name: ng-cont 
    image: nginx:alpine
    ports: 
      - "80:80"
```

Check if working correctly

```
docker-compose up -d
curl 127.0.0.1
```


# AWS Elastic Beanstalk

[https://aws.amazon.com/blogs/aws/aws-elastic-beanstalk-for-docker/](https://aws.amazon.com/blogs/aws/aws-elastic-beanstalk-for-docker/)



## Deploying Elastic Beanstalk applications from Docker containers

[https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/create_deploy_docker.html](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/create_deploy_docker.html)



## Single Container Docker environments

[https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/single-container-docker.html](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/single-container-docker.html)

[https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/single-container-docker-configuration.html](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/single-container-docker-configuration.html)

Go to Elastic Beanstalk

Create a new environment (Docker)

Upload new version based on file [Dockerrun.aws.json](./basic/Dockerrun.aws.json)



# Maven

[https://docs.aws.amazon.com/neptune/latest/userguide/iam-auth-connect-prerq.html](https://docs.aws.amazon.com/neptune/latest/userguide/iam-auth-connect-prerq.html)

```sh
#!/bin/bash
sudo wget https://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo -O /etc/yum.repos.d/epel-apache-maven.repo
sudo sed -i s/\$releasever/6/g /etc/yum.repos.d/epel-apache-maven.repo
sudo yum install -y apache-maven
```

# Links

https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/user-data.html

