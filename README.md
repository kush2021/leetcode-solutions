# LeetCode Solutions

This repository will contain a website to host detailed explanations for LeetCode solutions. The purpose of this website is to make coding easy and accessible for everyone.

## Installation

There is a docker container hosted on [kush2021/leetcode-solutions](https://hub.docker.com/r/kush2021/leetcode-solutions) that contains the software necessary to run the website.
First, pull the container.

```
docker pull kush2021/leetcode-solutions:latest
```

Next, run the container.

```
docker run -d -p 8000:8000 --name leetcode-solutions --platform linux/amd64 kush2021/leetcode-solutions:latest
```

The website will be available on [http://localhost:8000](http://localhost:8000)!

## License

This project is licensed under the MIT License.

## Credits

The inspiration for this project goes to [P.-Y. Chen](walkccc.me/LeetCode/). All of the work is my own, unless otherwise noted.
