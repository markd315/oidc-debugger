# OAuth 2.0 and OpenID Connect Debugger

:earth_americas: Live here: https://oauthdebugger.com or https://oidcdebugger.com

## What is this?

Read the blog post: [Introducing the OpenID Connect Debugger](https://www.recaffeinate.co/post/introducing-openid-connect-debugger/)

Getting an OAuth or OpenID Connect flow working properly can be tricky. There's a bunch of parameters you need to get right, and it's not always easy to capture or parse errors. I wrote this little web tool to make the process easier.

## How to use the debugger

All you need to do is temporarily set your OAuth client redirect URI to `https://oidcdebugger.com/debug` (or `https://oauthdebugger.com/debug`):

<img src="https://www.recaffeinate.co/img/post/introducing-openid-connect-debugger/temp-redirect-uri.png" alt="Temporarily change client redirect URI to debugger" title="Screenshot of Google developer console" width="550px">

Then, build a request to your authorization server using the debugger, and fire it off:

<img src="https://www.recaffeinate.co/img/post/introducing-openid-connect-debugger/switch-response-mode.gif" alt="Choose response mode and click Send Request" title="Screenshot of debugger form" width="550px">

The debugger will capture the callback and help you understand what happened (whether success or failure):

<img src="https://www.recaffeinate.co/img/post/introducing-openid-connect-debugger/error-and-success.gif" alt="Decode the error message, or view the successful callback information" title="Screenshot of error and success page" width="550px">

## Contributing

Issues and PRs are welcome! The project is built with ASP.NET Core, Docker, and Vue.js.

To build and run locally,

```
git clone https://github.com/markd315/oidc-debugger.git
cd oidc-debugger
docker build -t oidcdebugger-local .
docker run -d -p 3000:5000 oidcdebugger-local:latest
```

You can tag and push a new version like this
```
docker tag oidcdebugger-local identity-docker-prod.mia.ulti.io/identity/oidcdebugger:latest
docker push identity-docker-prod.mia.ulti.io/identity/oidcdebugger:latest
```

kube
```
helm2 ls
helm2 del --purge oidcdebugger
cd identity-k8s #(repo in Platform Services bitbucket)
helm2 install --name oidcdebugger helm/oidcdebugger
k get pods -n oidcdebugger

sudo su -

export KUBECONFIG=/Users/markda/identity-k8s/k8s/identity-V16/config #wherever you cloned your repo to, but port-forward needs sudo
kubectl port-forward -n oidcdebugger oidcdebugger-app-hash 80:5000
```