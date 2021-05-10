Demo usage of singer.io + pipelinewise libraries for data transfer

1. Clone directory. Pay attention that project has submodule

```git clone --recurse-submodules git@github.com:anuri73/dbt.git```

2. Run install process

```make install```

3. Create `.env` file and setup variables based on `.env.dist`


4. Generate `singer.io` configuration which will be located under `pipelinewise/.pipelinewise` directory

```make pipelinewise-regenerate-config```

5. Optional: run tests to make sure everything is configured correctly

```make pipelinewise-test```

6. Run taps:

```make pipelinewise-run-tap1```
