You'll need [`just`](https://github.com/casey/just) and Docker to run the tasks.

First, build the Docker images locally:

```
$ just build 3.12
```

Then, use them to run one of the [pyperformance benchmarks](https://pyperformance.readthedocs.io/benchmarks.html):

```
$ just bench nbody 3.12
```

(You may want to prepare your system for benchmarking first by installing [`pyperf`](https://github.com/psf/pyperf) locally (`uv tool install pyperf`) and using `pyperf system tune`.)
