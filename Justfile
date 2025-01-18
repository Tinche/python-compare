benchmark := "nbody"
version := "3.12"

build-deadsnakes version=version:
    docker buildx build . -f Dockerfile.deadsnakes -t bench.deadsnakes.{{version}} --build-arg version={{version}}

build-docker version=version:
    docker buildx build . -f Dockerfile.python -t bench.python.{{version}} --build-arg version={{version}}

build-uv version=version:
    docker buildx build . -f Dockerfile.uv -t bench.uv.{{version}} --build-arg version={{version}}

build-ubuntu version=version:
    docker buildx build . -f Dockerfile.ubuntu.{{ if version == "3.12" { "noble" } else { "oracular" } }} -t bench.ubuntu.{{version}}

build-debian version=version:
    docker buildx build . -f Dockerfile.debian -t bench.debian.{{version}} --build-arg version={{version}}

bench-deadsnakes version=version BENCHMARK=benchmark:
    docker run --rm bench.deadsnakes.{{version}} {{BENCHMARK}}

bench-docker version=version BENCHMARK=benchmark:
    docker run --rm bench.python.{{version}} {{BENCHMARK}}

bench-uv version=version BENCHMARK=benchmark:
    docker run --rm bench.uv.{{version}} {{BENCHMARK}}

bench-ubuntu version=version BENCHMARK=benchmark:
    docker run --rm bench.ubuntu.{{version}} {{BENCHMARK}}

bench-debian version=version BENCHMARK=benchmark:
    docker run --rm bench.debian.{{version}} {{BENCHMARK}}

build version=version: (build-deadsnakes version) (build-docker version) (build-uv version) (build-ubuntu version) (build-debian version)

bench BENCHMARK=benchmark version=version: (bench-deadsnakes version BENCHMARK) (bench-docker version BENCHMARK) (bench-uv version BENCHMARK) (bench-ubuntu version BENCHMARK) (bench-debian version BENCHMARK)
