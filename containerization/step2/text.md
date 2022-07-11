
Create a multistage docker image with distroless, and understand the features.
<br>

### Solution
<h1>step1 - Package a go application in container using single stage.<h2>

Lets create a simple hello world go program, `helloworld.go`

```plain
cd ~/scenarios
mkdir multistage-example
cd multistage-example
```{{exec}}

Create a `helloworld.go` as below, 

```plain
cat <<EOF > helloworld.go
package main

import (
 "fmt"
)

func main() {

 fmt.Println("Hello world")
}
EOF
```{{exec}}

Check the go file is created properly.

```plain
cat helloworld.go
```{{exec}}

create a blank go.mod file using command
```plain
go mod init example.com/m/v2
```{{exec}}

create a blank go.mod file using command
```plain
go mod init example.com/m/v2
```{{exec}}

create a Dockerfile as below
```plain
cat <<EOF > Dockerfile
FROM golang:1.17-alpine as build

RUN mkdir /build
ADD . /build/
WORKDIR /build
RUN go mod download
RUN go build -o /hello
ENTRYPOINT ["/root/hello"]
EOF
```{{exec}}

Let’s build the image from it , make a note we have tagged the image as v1.0
```plain
docker build --tag helloworld:v1.0 .
```{{exec}}

You can run the built image as below 
```plain
docker run helloworld:v1.0
```{{exec}}

Now, lets see the size of the image built 
```plain
docker images | grep helloworld
```{{exec}}
<br>
<h2>Improve the image with multistage builds<h2>
  The multistage image build helps reduce the image size leads to reduce the build time, upload/download, and storage costs. This also helps in security posture as your final image has only runtime dependancies and no other packages other than that.<p>
  Let’s improve our Dockerfile to add second stage build and copy the built program from first stage to second stage. We will use the ubi-micro as our base image in second stage<p>

Update a Dockerfile as below, we will move the origianl Dockerfile as Dockerfile.v1
```plain
mv Dockerfile Dockerfile.v1
cat <<EOF > Dockerfile
FROM golang:1.17-alpine as build

RUN mkdir /build
ADD . /build/
WORKDIR /build
RUN go mod download
RUN go build -o /hello

FROM registry.access.redhat.com/ubi8/ubi-micro

WORKDIR /root/
COPY --from=build /hello .
ENTRYPOINT ["/root/hello"]
EOF
```{{exec}}

Let’s build the image again,  this time with 2.0 Tag, and run it. 
```plain
docker build --tag helloworld:v2.0 .
```{{exec}}

You can run the built image as below 
```plain
docker run helloworld:v1.0
```{{exec}}

Now, lets see the size of the image built 
```plain
docker images | grep helloworld
```{{exec}}

<h2>Distroless<h2>
<h3>
We can further reduce the overall size, by switching to the googles distroless images as our base image.<p>
"Distroless" images contain only your application and its runtime dependencies. They do not contain package managers, shells or any other programs you would expect to find in a standard Linux distribution.<p>
Let’s modify our Dockerfile and just update our base image from `registry.access.redhat.com/ubi8/ubi-micro` to `gcr.io/distroless/static` 
Here, we we are planning to use gcr.io/distroless/static as our base image. Please refer to their documentation for choosing it according to your needs.<h3>

Let's move out previosu Dockerfile as Dockerfile.v2 and update it.
```plain
mv Dockerfile Dockerfile.v1
cat <<EOF > Dockerfile
FROM golang:1.17-alpine as build

RUN mkdir /build
ADD . /build/
WORKDIR /build
RUN go mod download
RUN go build -o /hello

FROM gcr.io/distroless/static

WORKDIR /root/
COPY --from=build /hello .
ENTRYPOINT ["/root/hello"]
EOF
```{{exec}}

Let’s build the image again,  this time with 3.0 Tag, and run it. 
```plain
docker build --tag helloworld:v3.0 .
```{{exec}}

You can run the built image as below 
```plain
docker run helloworld:v1.0
```{{exec}}

Now, lets see the size of the image built 
```plain
docker images | grep helloworld
```{{exec}}