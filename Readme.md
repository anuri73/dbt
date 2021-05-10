Demo usage of singer.io + pipelinewise libraries for data transfer

1. Run install process

```bash make install```

2. Create `.env` file and setup variables based on `.env.dist`


3. Generate `singer.io` configuration which will be located under `pipelinewise/.pipelinewise` directory

```bash make pipelinewise-regenerate-config```

4. Optional: run tests to make sure everything is configured correctly

```bash make pipelinewise-test```

5. Run taps:

```bash make pipelinewise-run-tap1```
