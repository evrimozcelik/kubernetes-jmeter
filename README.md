# Running Jmeter Scripts on Kubernetes

With this code you can build Jmeter docker image and deploy it into Kubernetes environment and run Jmeter scripts remotely.

I inspired by the [docker-jmeter](https://github.com/justb4/docker-jmeter) project on GitHub and adapted it based on my needs.

## Prerequisites for Setup

Create a Kubernetes cluster with either [Minikube](https://kubernetes.io/docs/getting-started-guides/minikube) for local testing, or with [IBM Bluemix Container Service](https://github.com/IBM/container-journey-template) to deploy in cloud.

You will need to create your Kubernetes cluster first and make sure it is fully deployed in your Bluemix account.

Please follow the steps below to install the sample application into your Bluemix Kubernetes cluster and generate load.

## Steps
1. [Prepare Bluemix Kubernetes cluster](#1-prepare-bluemix-kubernetes-cluster)  
2. [Build and Push Docker Image](#2-build-and-push-docker-image)
3. [Deploy Jmeter Image to Kubernetes](#3-deploy-jmeter-image-to-kubernetes)
4. [Generate Load](#4-generate-load)

# 1. Prepare Bluemix Kubernetes cluster
Follow the instructions in [Getting Started](https://console.bluemix.net/containers-kubernetes/home/registryGettingStarted) to setup required tools and Bluemix Kubernetes cluster.

# 2. Build and Push Docker Image
After building the Docker image, it can be pushed into the Bluemix Container Registry or DockerHub. The example below builds the docker image to be put into the Bluemix Container Registry, please replace the <namespace> with the name of your namespace.

```bash
$ docker build -t registry.eu-gb.bluemix.net/<namespace>/jmeter .
$ docker push registry.eu-gb.bluemix.net/<namespace>/jmeter
```

# 3. Deploy Jmeter Image to Kubernetes
Use the following command to deploy the Jmeter Image to Kubernetes cluster on Bluemix.

```bash
$ kubectl create -f jmeter-deployment.yaml
```

# 4. Generate Load
After deploying Jmeter Image onto your Kubernetes cluster, you can use the following commands to run the Jmeter script and collect performance logs.

```bash
JMETER_POD_NAME="jmeter-2150202267-g1vbh" # replace with your Jmeter Pod name

kubectl exec -it ${JMETER_POD_NAME}  -- rm -rf /tmp/jmeter-report # Clean the scripts that might be sent previously
kubectl cp ./jmeter-script ${JMETER_POD_NAME}:/tmp/jmeter-script # Copy your Jmeter script to Jmeter Pod
kubectl exec -it ${JMETER_POD_NAME}  -- ./bin/jmeter.sh -n -t /tmp/jmeter-script/sample.jmx # Run your Jmeter script on Jmeter Pod
rm -rf /tmp/jmeter-report # Clean the logs from previous run
kubectl cp ${JMETER_POD_NAME}:/tmp/jmeter-report /tmp/jmeter-report # Copy the logs to your local machine
```
