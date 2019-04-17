docker build -t bdwivedi/multi-client:latest -t bdwivedi/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t bdwivedi/multi-server:latest -t bdwivedi/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t bdwivedi/multi-worker:latest -t bdwivedi/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push bdwivedi/multi-client:latest
docker push bdwivedi/multi-server:latest
docker push bdwivedi/multi-worker:latest

docker push bdwivedi/multi-client:$SHA
docker push bdwivedi/multi-server:$SHA
docker push bdwivedi/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=bdwivedi/multi-server:$SHA
kubectl set image deployments/client-deployment client=bdwivedi/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=bdwivedi/multi-worker:$SHA