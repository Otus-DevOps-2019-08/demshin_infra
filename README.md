# demshin_infra

demshin Infra repository

## Homework 3

Connect to `someinternalhost` with `ProxyJump` option.

```bash
ssh -i ~/.ssh/appuser -A -J appuser@35.228.78.194 appuser@10.166.0.3
```

### Additional task

This solution uses `ProxyJump` option too. First you need to add some configuration to ssh config:

```bash
 echo "Host someinternalhost
    HostName 10.166.0.3
    User appuser
    ProxyJump appuser@35.228.78.194" >> ~/.ssh/config
```

Then run:

```bash
ssh someinternalhost
```bash

PROFIT!
