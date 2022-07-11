
Build a simple Image & Run Container​ from it.

<br>

### Solution
Switch to ~/scenarios directory to hold all our files.
Create a directory to hold the code and Dockerfile​
```plain
cd ~/scenarios
mkdir hello-world
cd hello-world
```{{exec}}

Create a Dockerfile with the command below​, 

```plain
cat <<EOF > Dockerfile
FROM alpine  
CMD ["echo", "Hello World!!"]
EOF
```{{exec}}

Check the Docerfile and understand each line

```plain
cat Dockerfile
```{{exec}}

Build the dockerimage image for verification purposes

```plain
docker build --tag helloworld:v1.0 .
docker images | grep helloworld
```{{exec}}

Run the container from the image

```plain
docker run --rm helloworld:v1.0
```{{exec}}