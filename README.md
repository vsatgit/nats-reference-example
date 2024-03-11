# NATS Reference Example

## Quick Start

From the project directory (eg cd ~/space/nats-reference-example$ )

### Setup NATS credentials

Before bringing up the `cds-proto-dev` container for feature development activities, configure NATS AuthN and AuthZ.

```bash
~/space/nats-reference-example$ make resetup-nats
```

The above command would generate the NATS Operator, Account and User credentials as per the provided configuration file. 

Refer: `build/ci/nats/generate_nats_keys.sh`

Upon successful execution of the command, both `cds-nats-server` and `cds-nats-box` should be up and running.

```bash
~/space/nats-reference-example$ docker-compose ps
NAME              IMAGE                                                                     COMMAND                  SERVICE           CREATED          STATUS          PORTS
cds-nats-box      cds-harbor.rtplab.nimblestorage.com/docker_proxy/natsio/nats-box:0.14.0   "/entrypoint.sh /bin…"   cds-nats-box      10 minutes ago   Up 10 minutes
cds-nats-server   cds-harbor.rtplab.nimblestorage.com/docker_proxy/library/nats:2.10.0      "/nats-server -c /et…"   cds-nats-server   10 minutes ago   Up 10 minutes   6222/tcp, 0.0.0.0:52569->4222/tcp, 0.0.0.0:52570->8222/tcp
```

`cds-nats-box` container logs should reflect the details of configured Account and User.

```bash
~/space/nats-reference-example$ docker logs cds-nats-box
2024-03-08 02:33:53 [ OK ] push to nats-server "nats://cds-nats-server" using system account "SYS":
2024-03-08 02:33:53        [ OK ] push SYS to nats-server with nats account resolver:
2024-03-08 02:33:53               [ OK ] pushed "SYS" to nats-server natsserver: jwt updated
2024-03-08 02:33:53               [ OK ] pushed to a total of 1 nats-server
2024-03-08 02:33:53        [ OK ] push TestAccount to nats-server with nats account resolver:
2024-03-08 02:33:53               [ OK ] pushed "TestAccount" to nats-server natsserver: jwt updated
2024-03-08 02:33:53               [ OK ] pushed to a total of 1 nats-server
2024-03-08 02:33:53 +--------------------------------------------------------------------------------------+
2024-03-08 02:33:53 |                                   Account Details                                    |
2024-03-08 02:33:53 +---------------------------+----------------------------------------------------------+
2024-03-08 02:33:53 | Name                      | TestAccount                                              |
2024-03-08 02:33:53 | Account ID                | ACSPMUMTQT2WYWAYK3KROIUNXX2YCQ22LEF6WBUGOWEHYSYIIMS7JLEF |
2024-03-08 02:33:53 | Issuer ID                 | OBEO2Q6PWBWKKR3FWJNKTXEOWYOGSSKPBCSJKYROYME4X4DEEYP7KS7D |
2024-03-08 02:33:53 | Issued                    | 2024-03-08 10:33:39 UTC                                  |
2024-03-08 02:33:53 | Expires                   |                                                          |
2024-03-08 02:33:53 +---------------------------+----------------------------------------------------------+
2024-03-08 02:33:53 | Max Connections           | Unlimited                                                |
2024-03-08 02:33:53 | Max Leaf Node Connections | Unlimited                                                |
2024-03-08 02:33:53 | Max Data                  | Unlimited                                                |
2024-03-08 02:33:53 | Max Exports               | Unlimited                                                |
2024-03-08 02:33:53 | Max Imports               | Unlimited                                                |
2024-03-08 02:33:53 | Max Msg Payload           | Unlimited                                                |
2024-03-08 02:33:53 | Max Subscriptions         | Unlimited                                                |
2024-03-08 02:33:53 | Exports Allows Wildcards  | True                                                     |
2024-03-08 02:33:53 | Disallow Bearer Token     | False                                                    |
2024-03-08 02:33:53 +---------------------------+----------------------------------------------------------+
2024-03-08 02:33:53 | Sub Allow                 | test.events.>                                            |
2024-03-08 02:33:53 | Response Permissions      | Not Set                                                  |
2024-03-08 02:33:53 +---------------------------+----------------------------------------------------------+
2024-03-08 02:33:53 | Jetstream                 | Enabled                                                  |
2024-03-08 02:33:53 | Max Disk Storage          | Unlimited                                                |
2024-03-08 02:33:53 | Max Mem Storage           | Unlimited                                                |
2024-03-08 02:33:53 | Max Streams               | Unlimited                                                |
2024-03-08 02:33:53 | Max Consumer              | Unlimited                                                |
2024-03-08 02:33:53 | Max Ack Pending           | Consumer Setting                                         |
2024-03-08 02:33:53 | Max Ack Pending           | Unlimited                                                |
2024-03-08 02:33:53 | Max Bytes                 | optional (Stream setting)                                |
2024-03-08 02:33:53 | Max Memory Stream         | Unlimited                                                |
2024-03-08 02:33:53 | Max Disk Stream           | Unlimited                                                |
2024-03-08 02:33:53 +---------------------------+----------------------------------------------------------+
2024-03-08 02:33:53 | Imports                   | None                                                     |
2024-03-08 02:33:53 | Exports                   | None                                                     |
2024-03-08 02:33:53 +---------------------------+----------------------------------------------------------+
2024-03-08 02:33:53 +---------------------------------------------------------------------------------+
2024-03-08 02:33:53 |                                      User                                       |
2024-03-08 02:33:53 +----------------------+----------------------------------------------------------+
2024-03-08 02:33:53 | Name                 | TestUser                                                 |
2024-03-08 02:33:53 | User ID              | UCZDVP7LPHKQLWZOXLKJGKEUXAVSKERFZBKIJRQ5HD4XB54GJBBLC7H4 |
2024-03-08 02:33:53 | Issuer ID            | ACSPMUMTQT2WYWAYK3KROIUNXX2YCQ22LEF6WBUGOWEHYSYIIMS7JLEF |
2024-03-08 02:33:53 | Issued               | 2024-03-08 10:33:39 UTC                                  |
2024-03-08 02:33:53 | Expires              |                                                          |
2024-03-08 02:33:53 | Bearer Token         | No                                                       |
2024-03-08 02:33:53 +----------------------+----------------------------------------------------------+
2024-03-08 02:33:53 | Pub Allow            | $JS.ACK.test.>                                           |
2024-03-08 02:33:53 |                      | $JS.API.CONSUMER.CREATE.test.>                           |
2024-03-08 02:33:53 |                      | $JS.API.CONSUMER.INFO.test                               |
2024-03-08 02:33:53 |                      | $JS.API.CONSUMER.INFO.test.>                             |
2024-03-08 02:33:53 |                      | $JS.API.CONSUMER.MSG.NEXT.test.>                         |
2024-03-08 02:33:53 |                      | $JS.API.STREAM.CREATE.test                               |
2024-03-08 02:33:53 |                      | $JS.API.STREAM.INFO.test                                 |
2024-03-08 02:33:53 |                      | $JS.API.STREAM.PURGE.test                                |
2024-03-08 02:33:53 |                      | test.events.>                                            |
2024-03-08 02:33:53 | Sub Allow            | _INBOX.>                                                 |
2024-03-08 02:33:53 |                      | test.events.>                                            |
2024-03-08 02:33:53 | Response Permissions | Not Set                                                  |
2024-03-08 02:33:53 +----------------------+----------------------------------------------------------+
2024-03-08 02:33:53 | Max Msg Payload      | Unlimited                                                |
2024-03-08 02:33:53 | Max Data             | Unlimited                                                |
2024-03-08 02:33:53 | Max Subs             | Unlimited                                                |
2024-03-08 02:33:53 | Network Src          | Any                                                      |
2024-03-08 02:33:53 | Time                 | Any                                                      |
2024-03-08 02:33:53 +----------------------+----------------------------------------------------------+

`cds-proto-dev` container can be started now by executing the following command;

```bash
~/space/nats-reference-example$ docker-compose up -d
```

To exec into the `cds-proto-dev` docker container: `docker exec -ti cds-proto-dev bash -l`

```bash
~/space/nats-reference-example$ docker exec -ti cds-proto-dev bash -l
dev@cds-proto-dev:~/ws$ make all
```

Post this developement activity can be continued as usual. NATS credential setup is stored in gitingored directory: `build/ci/nats/kets/` and `build/ci/nats/nsc`. This is a one time operation, unless the permission are updated, in which case refer to `NATS Permission update` section.

All containers can started and stopped using the following command:

```bash
~/space/nats-reference-example$ docker compose --profile nats stop/start
```

### NATS Permission update
In case, the NATS user permission needs to be updated, the changes mainly needs to be done in the `build/ci/nats/configure_nsc.sh` file.

After the permissions have been updated, the user credentials needs to be regenerated using the command: `make resetup-nats`
