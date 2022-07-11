
Create a multistage docker image with distroless, and understand the features.

<h1>Goal</h1>
<li> This scenario will help you understand and create a Container image using a multistage build process. </li>
<li>You will build a distroless as a base image and understand that is light weight. </li>
<li>You will also understand the value of using multistage builds using the distroless as a base images.</li>

<h1>Lesson Takeaway</h1>
  <li>Containers need to be small (in the order of 200-500 MB).  </li>
  <li>Containers should not include unnecessary packages. </li>
  <li>Distroless containers help you achieve the above goal of keeping contains small, minimize attack surface and allow us to scale easily.</li>

<br>

### Solution
step1 - Package a go application in single stage

Lets create a simple hello world go program, `helloworld.go`

```plain
echo amazing > /etc/my-second-file
```{{exec}}

And to verify we can run

```plain
cat /etc/my-second-file
```{{exec}}
