# Kube-Ingress Demos

_**Run Kubernetes Cluster Locally**_
--

- Included in this DEMO 

_**Kube-Land Utility Scripts/Tools**_
---
| Component/Technology | Purpose |
| ------------- | ------------- | 
| **Spring Boot Microservices** | Java Spring Boot Microservices for TEST/DEMO |
| **Spring Boot Admin Console** | Java Spring Boot Admin Console for Microservices Monitoring from <BR/> https://github.com/codecentric/spring-boot-admin  |
| **Gradle** | For building Spring Boot Microservices |
| **Rest API Docs** | For Auto-generating Spring Boot Microservices REST API Documentation |
| **Kubernetes Kind** | Local Kubernetes Test Tool "Kind" from https://kind.sigs.k8s.io/ |
| **Kubernetes RBAC** | Kubernetes Role Based Access Control |
| **Kubernetes Ingress** | For Request Routing / API Gateway |
| **NGINX Ingress Controller** | NGINX Ingress Controller |
| **Dockerfile** | For Building Docker Container Image for Microservices |
| **Docker Registry** | Local Docker Registry For Building/Publishing Docker Container Images for Microservices |
| **K8Dash** |  K8Dash UI For Monitoring/Managing Kubernetes Cluster Resources |

- Install Kind on your Local Machine (Mac or Windows Instructions below)

    https://kind.sigs.k8s.io/docs/user/quick-start

- Install Chocolatey & Kind on your Local Machine (Only For Windows)

    Open Command Shell with Administration Rights
    
    `Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))`

    `choco install kind`

- Verify that Kind is properly installed by running the commands below,
 
    `kind get clusters`
    
    `kind get nodes`


`git clone https://github.com/navikco/kube-ingress.git`

`cd kube-ingress/setup/scripts/`

`chmod 700 kubeLandBlast.sh`

`./kubeLandBlast.sh green <<<Or Any Environment - dev/qa etc.>>>`

- This would start Docker Containers for Kubernetes Kind (https://github.com/kubernetes-sigs/kind)

- It would also start the Kubernetes Pod for K8Dash UI Dashboard

- It would also start the Kube Microservice Pods for admin & accounts

- It would also print the **LONG Security Token** on the Console for K8Dash UI Login

- Once the Command exits with success,
     
    - You can Browse your Spring Boot Admin (SBA) Console on --> 
    
        http://localhost:8080/admin/wallboard/

    - If Your SBA Console is not up, you can run the PORT FORWARD command below and retry,
        
        `kubectl port-forward service/ingress-nginx 8080:80 --namespace=ingress-nginx &`
          
    - You can Browse your Microservices REST API Documentation on, 
    
        http://localhost:8080/kube/accounts/info/index.html

        http://localhost:8080/kube/customers/info/index.html

        http://localhost:8080/kube/users/info/index.html
     
    - Verify if your Microservices are working in your Local Kubernetes Cluster
        
        - Microservice Endpoint
     
            `curl 'http://localhost:8761/kube/accounts/300' -i -X GET -H 'Accept: application/json'`
            
            `curl 'http://localhost:8761/kube/customers' -i -X GET -H 'Accept: application/json'`
            
            `curl 'http://localhost:8761/kube/users' -i -X GET -H 'Accept: application/json'`
    
    - You can Browse your K8Dash UI on --> 
    
        - Copy the **LONG Security Token** displayed on the Console by the last command and use it to Login on K8Dash UI 
    
            http://localhost:8000/

        - If Your K8Dash UI is not up on Windows, you can run the PORT FORWARD command below and retry,
        
            `kubectl port-forward deployment/k8dash 8000:4654 --namespace=kube-system &`
       
    - You should be also able to execute any **kubectl** Commands
    
    - To Check your Local Kubernetes Cluster,
    
        `kubectl get nodes`


- To Deploy Test Apps/Microservices Manually via **kubectl** Commands,

    - Run the **kubectl** commands below,
    
        `cd kube/setup/cluster/kube-green/`
    
        `kubectl create -f kube-green.yml`   (Creates Kubernetes Namespace)
          
        `kubectl get namespaces`  (Should list **kube-green** Namespace)
    
        `kubectl create -f admin/admin-service.yml`  (Creates & Exposes **admin** Microservice as Kubernetes Service)
    
        `kubectl get services --namespace=kube-green`
    
        `kubectl create -f admin/admin-deployment.yml`  (Creates **admin** Microservice Deployment)
    
        `kubectl get pods --namespace=kube-green`
    
        `kubectl create -f accounts/accounts-service.yml`  (Creates & Exposes **accounts** Microservice as Kubernetes Service)
    
        `kubectl get services --namespace=kube-green`
    
        `kubectl create -f accounts/accounts-deployment.yml`  (Creates **accounts** Microservice Deployment)
    
        `kubectl get pods --namespace=kube-green`


_**LOCALLY Build and Run Microservices Docker Images**_
---

- Build & Run the **admin** Microservice first,
    
`cd kube-ingress/setup/scripts/`

`./setupKubeLandDeployment.sh green customers`


_**Display K8Dash UI Token to Login**_
---

`cd setup/scripts/` 

`./fetchKubeLandK8DashAccessKey.sh`



_**Cleanup/Destroy LOCAL Workspace once Done**_
---

`cd setup/scripts/` 

`./destroyKubeLandCluster.sh`
