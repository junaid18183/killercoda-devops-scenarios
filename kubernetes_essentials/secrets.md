
<h1>Topic - How to inject a Secrets in the k8s deployment</h1>
<h2>Convert your secret data to a base-64 representation</h2>
Suppose you want to have two pieces of secret data: a username my-app and a password 39528$vdg7Jb. <p>
First, use a base64 encoding tool to convert your username and password to a base64 representation. <p>
Here's an example using the commonly available base64 program:

```plain
echo -n 'my-app' | base64
echo -n '39528$vdg7Jb' | base64
```{{exec}}

Create a Secret using yaml file, create a secret.yaml file as below

```plain
cat <<EOF > secret.yaml
apiVersion: v1
kind: Secret
metadata:
  name: test-secret
data:
  username: bXktYXBw
  password: Mzk1MjgkdmRnN0pi
  EOF
```{{exec}}

Create the Secret
```plain
kubectl apply -f secret.yaml
```{{exec}}

View information about the Secret
```plain
kubectl get secret test-secret
```{{exec}}