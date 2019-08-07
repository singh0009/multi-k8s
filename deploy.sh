docker build -t singh0009/multi-client:latest -t singh0009/multi-client:$SHA -f ./client/Dockerfile ./client 
docker build -t singh0009/multi-server:latest -t singh0009/multi-server:$SHA -f ./server/Dockerfile ./server 
docker build -t singh0009/multi-worker:latest -t singh0009/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push singh0009/multi-client:latest
docker push singh0009/multi-server:latest
docker push singh0009/multi-worker:latest

docker push singh0009/multi-client:$SHA
docker push singh0009/multi-server:$SHA
docker push singh0009/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=singh0009/multi-server:$SHA
kubectl set image deployments/client-deployment client=singh0009/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=singh0009/multi-worker:$SHA