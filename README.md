# NATS Reference Starter Guide

## Overview

This repo has been created to serve as quick starter for docker-based local development setup for NATS Jetstream configured with authentication/authorization by means of JWTs and Nkeys.

Code in this repo can be re-used in conjuction with `cds-proto-dev` container based development setup to spin up a single-node NATS Jetstream server along with `nats-box` container, which provides a CLI based tool to interact with nats server.

### Why is it necessary?

There are a few steps involved in configuring NATS Jetstream server to have authentication/authorization capabilities using JWTs and Nkeys in the local setup. These same steps would be performed by the DevOps team in higher environments.

The starter setup tries to abstract out the NATS configurational overhead in local setup so that developers can focus on their primary development processes.

#### What are the benefit of using NATS with authentication/authorization capabilities in local dev setup?

Having NATS Jetstream server configured with authentication/authorization capabilities in local dev setup allows for

- developing on an almost similar NATS Jetstream server setup w.r.t authentication/authorization capabilities, as provided in higher environments
- provides an easy way to configure the allowed pub-sub permissions needed early on during development
- makes its easier to share the required pub/sub permissions to generate service-specific JWTs in sandbox environments
  
## Directory Structure

```sh
.
├── .gitignore                          # lists directories/files to be ignored by git
├── Makefile                            # root level Makefile to mimic an actual feature repo Makefile
├── README.md
├── docker-compose.yml                  # docker-compose to start/stop nats-server and nats-box
├── nats-make.mk                        # nats configuration specific commands are listed here, can be included as-is in a feature repo
└── nats_configs                        # parent directory for all nats configuration artefacts
    ├── .env                            # nats specific environment variables
    ├── scripts                         # scripts used for configuring NATS
    │   ├── configure-nats-with-jwts.sh
    │   ├── init-config.sh
    │   ├── nats-box-entrypoint.sh
    │   └── user-config.sh
    └── server_configs                  # directory storing nats-server configs
        └── server.conf          
```

## Dev Environment - Quick Start

### Prerequiste

With the move to ghcr.io, you need to [authenticate with a Personal Access Token (classic)](https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry#authenticating-with-a-personal-access-token-classic) with at least `read:packages` scope, ensuring you [authorize the token for SSO](https://docs.github.com/en/enterprise-cloud@latest/authentication/authenticating-with-saml-single-sign-on/authorizing-a-personal-access-token-for-use-with-saml-single-sign-on).

### Commands

The repo has been configured with the following commands:

- `make configure-nats`:     initializes NATS with Authorization and Authentication configured based on provided environment variables and permissions
- `make nats-down`:          brings down nats-server and nats-box and removes them
- `make cleanup-dirs`:       cleanup directories that stores NATS JWTs and NKeys
- `make cleanup-nats`:       cleans up all NATS configuration related to Authorization and Authentication
- `make reconfigure-nats`:   reconfigures NATS with Authorization and Authentication after clearing the existing configuration
- `nats-start`:              start nats-server and nats-box containers
- `nats-stop`:               stop nats-server and nats-box containers

### Initial setup

User should run `make configure-nats` command in order configure NATS authorization and authentication based on the user provided input in `nats_configs/.env` and `nats_configs/scripts/user-config.sh`.

A sample reference is provided for both `nats_configs/.env` and `nats_configs/scripts/user-config.sh`, which can be tweaked as per need.

Upon successful execution of command, the following logs should be seen in the terminal:

<details>
    <summary>Terminal logs related to configuring operator, account and users</summary>

```sh
[ OK ] generated and stored operator key ...
[ OK ] added operator "TestOperator"
...
[ OK ] edited operator "TestOperator"
...
[ OK ] added account "TestAccount"
[ OK ] added pub "$JS.API.STREAM.CREATE.test"
[ OK ] added pub "$JS.API.STREAM.INFO.test"
[ OK ] added pub "$JS.API.STREAM.NAMES"
[ OK ] added pub "$JS.ACK.test.>"
[ OK ] added pub "$JS.API.CONSUMER.INFO.test"
[ OK ] added pub "$JS.API.CONSUMER.INFO.test.>"
[ OK ] added pub "$JS.API.CONSUMER.CREATE.test.>"
[ OK ] added pub "$JS.API.CONSUMER.MSG.NEXT.test.>"
[ OK ] added pub "$JS.API.STREAM.PURGE.test"
[ OK ] added sub "test.events"
[ OK ] added sub "test.events.>"
[ OK ] added sub "_INBOX.>"
...
[ OK ] added user "TestUser" to account "TestAccount"
...
[ OK ] added user "FTUser" to account "TestAccount"
...
```

</details>

and both `nats-server` and `nats-box` containers should be up and running

<details>
    <summary>docker-compose ps</summary>

```sh
❯ docker-compose ps
NAME          IMAGE                    COMMAND                  SERVICE       CREATED          STATUS          PORTS
nats-box      natsio/nats-box:0.14.0   "/entrypoint.sh /bin…"   nats-box      21 minutes ago   Up 21 minutes   
nats-server   nats:2.10.0              "/nats-server -c /et…"   nats-server   21 minutes ago   Up 21 minutes   6222/tcp, 0.0.0.0:62391->4222/tcp, 0.0.0.0:62392->8222/tcp
```

</details>

Further inspecting the `nats-box` logs should show the configured Account & Users.

Note: User `Pub Allow` and `Sub Allow` section can be used from the logs to raise PR to configure permissions in sandbox environments

<details>
    <summary>nats-box container logs</summary>

```sh
+--------------------------------------------------------------------------------------+
|                                   Account Details                                    |
+---------------------------+----------------------------------------------------------+
| Name                      | TestAccount                                              |
| Account ID                | ABNNFNE4TJDCM2KW7CO32C2RWVKJIV3JEET4IF7XSKZQ7MKRH2CTVS2O |
| Issuer ID                 | OBE3EGBCLBYBJWJP3WOLTDUTOWQEDMP6ZLYYWSMH72D7QABCP5Q2ITI3 |
| Issued                    | 2024-03-14 11:45:09 UTC                                  |
| Expires                   |                                                          |
+---------------------------+----------------------------------------------------------+
| Max Connections           | Unlimited                                                |
| Max Leaf Node Connections | Unlimited                                                |
| Max Data                  | Unlimited                                                |
| Max Exports               | Unlimited                                                |
| Max Imports               | Unlimited                                                |
| Max Msg Payload           | Unlimited                                                |
| Max Subscriptions         | Unlimited                                                |
| Exports Allows Wildcards  | True                                                     |
| Disallow Bearer Token     | False                                                    |
| Response Permissions      | Not Set                                                  |
+---------------------------+----------------------------------------------------------+
| Jetstream                 | Enabled                                                  |
| Max Disk Storage          | Unlimited                                                |
| Max Mem Storage           | Disabled                                                 |
| Max Streams               | Unlimited                                                |
| Max Consumer              | Unlimited                                                |
| Max Ack Pending           | Consumer Setting                                         |
| Max Ack Pending           | Unlimited                                                |
| Max Bytes                 | optional (Stream setting)                                |
| Max Memory Stream         | Unlimited                                                |
| Max Disk Stream           | Unlimited                                                |
+---------------------------+----------------------------------------------------------+
| Imports                   | None                                                     |
| Exports                   | None                                                     |
+---------------------------+----------------------------------------------------------+
+---------------------------------------------------------------------------------+
|                                      User                                       |
+----------------------+----------------------------------------------------------+
| Name                 | TestUser                                                 |
| User ID              | UDZNLQXVIQWZZKIRCGDKBBJOJUIPO7BVJNA7WZY7QECDHPUCBTGI73II |
| Issuer ID            | ABNNFNE4TJDCM2KW7CO32C2RWVKJIV3JEET4IF7XSKZQ7MKRH2CTVS2O |
| Issued               | 2024-03-14 11:45:09 UTC                                  |
| Expires              |                                                          |
| Bearer Token         | No                                                       |
+----------------------+----------------------------------------------------------+
| Pub Allow            | $JS.ACK.test.>                                           |
|                      | $JS.API.CONSUMER.CREATE.test.>                           |
|                      | $JS.API.CONSUMER.INFO.test                               |
|                      | $JS.API.CONSUMER.INFO.test.>                             |
|                      | $JS.API.CONSUMER.MSG.NEXT.test.>                         |
|                      | $JS.API.STREAM.CREATE.test                               |
|                      | $JS.API.STREAM.INFO.test                                 |
|                      | $JS.API.STREAM.NAMES                                     |
|                      | $JS.API.STREAM.PURGE.test                                |
| Sub Allow            | _INBOX.>                                                 |
|                      | test.events                                              |
|                      | test.events.>                                            |
| Response Permissions | Not Set                                                  |
+----------------------+----------------------------------------------------------+
| Max Msg Payload      | Unlimited                                                |
| Max Data             | Unlimited                                                |
| Max Subs             | Unlimited                                                |
| Network Src          | Any                                                      |
| Time                 | Any                                                      |
+----------------------+----------------------------------------------------------+
+---------------------------------------------------------------------------------+
|                                      User                                       |
+----------------------+----------------------------------------------------------+
| Name                 | FTUser                                                   |
| User ID              | UBNRSQN4SMNPN35BRTJZBA7743Y6N67HUKMUZWVVM6ENAWT4MHQ7N3GM |
| Issuer ID            | ABNNFNE4TJDCM2KW7CO32C2RWVKJIV3JEET4IF7XSKZQ7MKRH2CTVS2O |
| Issued               | 2024-03-14 11:45:09 UTC                                  |
| Expires              |                                                          |
| Bearer Token         | No                                                       |
+----------------------+----------------------------------------------------------+
| Pub Allow            | $JS.ACK.tags.>                                           |
|                      | $JS.API.CONSUMER.CREATE.test                             |
|                      | $JS.API.CONSUMER.CREATE.test.>                           |
|                      | $JS.API.CONSUMER.DELETE.test.>                           |
|                      | $JS.API.CONSUMER.DURABLE.CREATE.test.>                   |
|                      | $JS.API.CONSUMER.DURABLE.UPDATE.test.>                   |
|                      | $JS.API.CONSUMER.INFO.test                               |
|                      | $JS.API.CONSUMER.INFO.test.>                             |
|                      | $JS.API.CONSUMER.MSG.NEXT.test.*                         |
|                      | $JS.API.CONSUMER.UPDATE.test.>                           |
|                      | $JS.API.INFO                                             |
|                      | $JS.API.STREAM.CREATE.test                               |
|                      | $JS.API.STREAM.DELETE.test                               |
|                      | $JS.API.STREAM.INFO.test                                 |
|                      | $JS.API.STREAM.NAMES                                     |
|                      | test.events                                              |
|                      | test.events.>                                            |
| Sub Allow            | _INBOX.>                                                 |
|                      | test.events                                              |
|                      | test.events.>                                            |
| Response Permissions | Not Set                                                  |
+----------------------+----------------------------------------------------------+
| Max Msg Payload      | Unlimited                                                |
| Max Data             | Unlimited                                                |
| Max Subs             | Unlimited                                                |
| Network Src          | Any                                                      |
| Time                 | Any                                                      |
+----------------------+----------------------------------------------------------+
```

</details>

### Subsequent start and stop

Once `nats-server` has been configured with JWTs and Nkey Seed, `nats-server` and `nats-box` containers can be started/stopped using `make nats-start` and `make nats-stop` commands respectively.

### Regenerate JWTs and NkSeed

All the JWTs and NkSeeds needs to be regenerated whenever pub/sub permissions defined in `nats_configs/scripts/user-config.sh` changes. This can be done by execting `make reconfigure-nats` command.

## NATS JWTs and NkSeed management

The repo has been setup to allow re-usability in mind. Common configuration related to Operator and Account has been seperated out from the user configuration.
Refer [NATS Security documentation](https://pages.github.hpe.com/cloud/storage-design/docs/service-communication/nats.html#security) to understand how NATS uses Operator, Account and User to enable its security model.

Each microservices should only focus on configuring

- the environment variables in `nats_configs/.env` as per their requirements and
- the required `allowed-pub` and `allowed-sub` permission in `nats_configs/scripts/user-config.sh` to generate User JWTs and NkSeed.

The generated User JWT and NkSeed can be found in `nats_configs/creds` directory in a file with `.creds` extension. This cred file should be configured as either environent variable or configuration based on the application specific setup.

### Process difference between local setup & sandboxes

|                  |Sandboxes|Local Dev setup|
|------------------|--------|----------------|
|Operator & Account Setup|sc-ops-nats-jetstream-creds-provisioner|init-config.sh|
|User JWT & Seed Key Setup |PR adding permissions in [natsAuthzConfigProd.yaml](https://github.hpe.com/cloud/sc-ops-nats-jetstream-creds-provisioner/blob/main/authzfiles/natsAuthzConfigProd.yaml)|Adding permission in `user-config.sh`|
|User JWT & Seed Key Access|vault path: `storagecentral/app/nats/users/<svc_name>/<USER_NAME>`|creds in directory: `nats_configs/creds/<USER_NAME.creds>`|
