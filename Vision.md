# Vision

* Two stage rocket: Platform and stack

* Platform!
** Cloud agnostic (Not if we use az pgsql!)
*** Thin "cloud" layer
*** Stack which will run on az, aws, etc.
** Leading in tech - Embrace the cloud
*** Lets not host pgsql, mysql, rabbit etc. There are people out there specializing in that... Azure, AWS, GCE
*** CI/CD
**** Kill the bureaucracy - Tech supports it!
**** Selenium!!! No manual (human) testing
**** Fits within our existing process!!!
** Automated... Auto ad, auto cluster, auto stack, auto test and auto update!
*** tls/ssl at cluster level... Not configured for each app - https://akomljen.com/get-automatic-https-with-lets-encrypt-and-kubernetes-ingress/

* Open source
** Well this cloud already is! And more should follow... Especially tools and frameworks!

* Developer friendly
** Build for alpine (or whatever... But not debian! Security and not for containers) - Sure alpine is free too... But scans on quay has shown it to be well updated
** Build with docker... That's the docker way!
** docker-compose - We don't really need a readme anymore... (Besides one pointing to docker-compose and explaining .env)
** docker in app repo
*** Generic helm chart
** devs build for dev (and test) - Currently devs can't run the helm chart. WTF?
*** No duplication of values... Just list the ones we override!

* Admin friendly
** Integrate with existing tools (AAD)
** UI, not command line - Azure ui, Azure postgresql, Kubernetes UI
*** Grafan, kibana - Alerts

* Doesn't work/Disclaimer
** Not my work
** Plenty of other stuff... Three sp's, lots of IDK's

* Nice!!!
** Auto create service principal, unknown password
** Revisions control... Everything is in git
** AKS... MS handles managers nodes... less work, security updates
** No (in cluster) tiller
** Standard tools
*** Terraform. "Easily" ported to AWS or GCP
*** Helmfile

helm-2.7.2 --kube-context ml-test delete --purge ml-arp ;and helm-2.7.2 --kube-context ml-test install --name ml-arp --namespace ml erst/ml-arp
