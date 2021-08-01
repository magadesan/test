docker build -t restest .
docker run --name restest restest
docker rm restest
docker rmi restest
