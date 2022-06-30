gcloud config set project cisc5550homework4
gcloud compute instances delete cisc5550-api
gcloud compute firewall-rules delete rule-allow-tcp-5001

gcloud compute instances create cisc5550-api --machine-type n1-standard-1 --image-family debian-9 --image-project debian-cloud --tags http-server --metadata-from-file startup-script=./startup.sh
gcloud compute firewall-rules create rule-allow-tcp-5001 --source-ranges 0.0.0.0/0 --target-tags http-server --allow tcp:5001

export TODO_API_IP=`gcloud compute instances list --filter="name=cisc5550-api" --format="value(EXTERNAL_IP)"`

docker build -t spage/cisc5550app --build-arg api_ip=${TODO_API_IP} .
docker push spage/cisc5550app

gcloud container clusters create cisc5550-cluster
kubectl create deployment cs5550 --image=spage/cisc5550app --port=5000
kubectl expose deployment cs5550 --type="LoadBalancer"

kubectl get service cs5550
