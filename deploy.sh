sudo docker build -t bdwivedi/multi-client:latest -t bdwivedi/multi-client:$SHA -f ./client/Dockerfile ./client
sudo docker build -t bdwivedi/multi-server:latest -t bdwivedi/multi-server:$SHA -f ./server/Dockerfile ./server
sudo docker build -t bdwivedi/multi-worker:latest -t bdwivedi/multi-worker:$SHA -f ./worker/Dockerfile ./worker
sudo docker push bdwivedi/multi-client:latest
sudo docker push bdwivedi/multi-server:latest
sudo docker push bdwivedi/multi-worker:latest
sudo docker push bdwivedi/multi-client:$SHA
sudo docker push bdwivedi/multi-server:$SHA
sudo docker push bdwivedi/multi-worker:$SHA
sudo kubectl apply -f k8s
sudo kubectl set image deployments/server-deployment server=bdwivedi/multi-server:$SHA
sudo kubectl set image deployments/client-deployment client=bdwivedi/multi-client:$SHA
sudo kubectl set image deployments/worker-deployment worker=bdwivedi/multi-worker:$SHA
