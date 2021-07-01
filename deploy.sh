docker build -t abhayk26/multi-client:latest -t abhayk26/multi-client:$SHA -f ./client/Dcokerfile ./client
docker build -t abhayk26/multi-server:latest -t abhayk26/multi-server:$SHA -f ./server/Dcokerfile ./server
docker build -t abhayk26/multi-worker:latest -t abhayk26/multi-worker:$SHA -f ./worker/Dcokerfile ./worker

docker push abhayk26/multi-client:latest
docker push abhayk26/multi-server:latest
docker push abhayk26/multi-worker:latest

docker push abhayk26/multi-client:$SHA
docker push abhayk26/multi-server:$SHA
docker push abhayk26/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=abhayk26/multi-server:$SHA
kubectl set image deployments/client-deployment client=abhayk26/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=abhayk26/multi-worker:$SHA
