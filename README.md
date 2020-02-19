Axelor Open Suite
================================

Axelor Open Suite reduces the complexity and improve responsiveness of business processes. Thanks to its modularity, you can start with few features and  then activate other modules when needed.

Axelor Open Suite includes the following modules :

* Customer Relationship Management
* Sales management
* Financial and cost management
* Human Resource Management
* Project Management
* Inventory and Supply Chain Management
* Production Management
* Multi-company, multi-currency and multi-lingual

Axelor Open Suite is built on top of [Axelor Open Platform](https://github.com/axelor/axelor-open-platform)

Download
-------------------------
```bash
$ git clone git@github.com:axelor/open-suite-webapp.git
$ cd open-suite-webapp
$ git checkout master
$ git submodule init
$ git submodule update
$ git submodule foreach git checkout master
$ git submodule foreach git pull origin master
```

# To create in OpenShift 

To create the application, run the following:

`helm template . | oc apply -f -`

# ArgoCD

Then to install ArgoCD, you can run:

```
git clone https://github.com/honda-lde/argo-helm
cd argo-helm/charts/argo-cd
oc project honda-labs-ci-cd
helm install argo-cd .
```

At this point, you should see ArgoCD begin to spin up and then you can verify that it is healthy once you can access the route. The default username will be admin and the password will be the name of the argocd-server pod.

# Tooling

Then to instantiate the tooling, you can run:

```
git clone https://github.com/honda-lde/labs-ci-cd
cd labs-ci-cd
oc apply -f labs-ci-cd.yaml -n honda-labs-ci-cd
```

You should then be able to log into the ArgoCD UI and see that there are a number of applications that are ready to be synced. Sync them now.

