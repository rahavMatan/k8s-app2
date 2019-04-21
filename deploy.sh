docker build -t rahavmatan/multi-client:latest -t rahavmatan/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t rahavmatan/multi-server:latest -t rahavmatan/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t rahavmatan/multi-worker:latest -t rahavmatan/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push rahavmatan/multi-client:latest
docker push rahavmatan/multi-server:latest
docker push rahavmatan/multi-worker:latest

docker push rahavmatan/multi-client:$SHA
docker push rahavmatan/multi-server:$SHA
docker push rahavmatan/multi-worker:$SHA

kubectl apply  -f k8s
kubectl set image deployments/server-deployment server=rahavmatan/multi-server:$SHA
kubectl set image deployments/client-deployment client=rahavmatan/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=rahavmatan/multi-worker:$SHA