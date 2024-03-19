FROM photoprism/mkdocs-material:latest
WORKDIR /src
COPY . .
ENTRYPOINT [ "mkdocs", "serve", "--dev-addr=0.0.0.0:8000" ]
