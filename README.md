# Yet Another Containerized Kafka Cluster

Now, 42 Chrome tabs later with outdated OSS repositories, articles and SE+AI results
for dockerized Confluent-, Bitnami- or Wurstmeister-based Kafka clusters,
it's time to add another one, probably outdated in seconds.

The primary goal for this repository is to have a modern containerized Kafka cluster with 
observability and several features known from production for testing use on small machines.

This repository is mostly inspired by [Vladimir Penkov](https://medium.com/@penkov.vladimir/kafka-cluster-with-ui-and-metrics-easy-setup-d12d1b94eccf
).

## Kafka cluster with KRaft mode with SASL, SSL and ACL

The docker composition contains:

- 3-node Bitnami Kafka cluster in KRaft mode
- Kafka-UI
- Grafana served with data from Prometheus with Kafka- & JMX-Exporter

Configured Kafka features:
- KRaft mode (Consensus protocol)
- Security Protocol: SASL_SSL
- Auth Mechanisms: PLAIN, SCRAM-SHA-256, SCRAM-SHA-512
- ACL support with StandardAuthorizer
- Least user privileges (no anonymous access without ACLs)
- Topic auto creation disabled by default

### Kafka without Zookeeper

Apache Kafka has officially deprecated ZooKeeper in version 3.5.

Kafka uses the Raft consensus algorithm for leader election, so that 
the dependency on ZooKeeper for managing cluster metadata is eliminated.
The Raft algorithm is a consensus protocol designed to ensure 
fault-tolerant replication of state machines in a distributed system.

## Getting started

1. add your local ip address to the `.env` file
2. start "generate.sh" script (requires the `kafka-hosts.txt`)
   ```
   ./generate.sh
   ```
3. start composition with:
   ```
   docker-compose up -d
   ```

> **NOTE**: 
> Configure other `.env` entries as needed, the settings
> in the `docker-compose.yml` are the typical defaults, 
> which might conflict with other tools on your machine.


### Client Certificate

A client certificate is created in the `pem` folder
along with the self-signed CA.

### Web Frontends

- Grafana: [localhost:3000](http://localhost:3000) (admin/admin)
- Kafka-UI: [localhost:8080](http://localhost:8080) (admin/admin)

### Client and Admin properties

- client credentials are in `KAFKA_CLIENT_USERS` and `KAFKA_CLIENT_PASSWORD` environment variables
- client and admin properties examples are in `admin.properties` and `client.properties.*` files

Additional users and respective ACLs are added at runtime as needed.

## Useful commands

```
# topic creation
./kafka-topics.sh --bootstrap-server 192.168.0.188:29092 \
   --create --topic test-topic --partitions 3 --replication-factor 3 \
   --command-config admin.properties
```

```
# create ACL for topic test-topic
./kafka-acls.sh --bootstrap-server 192.168.0.188:29092 \
   --add --allow-principal User:da --operation All --group '*' \
   --topic test-topic --command-config admin.properties
```

```
# checking ACLs
./kafka-acls.sh --bootstrap-server 192.168.0.188:29092 \
   --list --topic test-topic --command-config admin.properties
```

```
# starting producer
./kafka-console-producer.sh --bootstrap-server 192.168.0.188:29092 \
   --topic test-topic --producer.config client.properties.t1
```

```
# starting consumer
./kafka-console-consumer.sh --bootstrap-server 192.168.0.188:29092 \
   --topic test-topic --consumer.config client.properties.t1  --from-beginning
```

## Additional users and ACLs

The KRaft mode cluster needs to support SCRAM, configure the auth mechanisms accordingly
with `KAFKA_CFG_SASL_ENABLED_MECHANISMS` set to `PLAIN,SCRAM-SHA-256,SCRAM-SHA-512`

For flexible testing with users and their related authorization,
see the scripts in the `./scripts` folder.

You might see the following access rejection in the logs:

````
kafka-1         | [2024-07-30 14:29:43,713] INFO 
  Principal = User:user1 is Denied operation = DESCRIBE 
    from host = 192.168.65.1 
    on resource = Group:LITERAL:examplekafkaproducerconsumer-kafkaConnectionConsumer 
    for request = FindCoordinator with resourceRefCount = 1 
    based on rule DefaultDeny (kafka.authorizer.logger)
````

This illustrates the successful application of the ACL.


### Using the ACL scripts

In order to simplify work with the kafka containers use `bash -s` and copy the required
`admin.properties` to a container location

```
docker cp admin.properties kafka-0:/tmp
```

The execute a script, for instance:

```
docker exec -i kafka-0 bash -s < ./scripts/create-users.sh
docker exec -i kafka-0 bash -s < ./scripts/describe-users.sh
docker exec -i kafka-0 bash -s < ./scripts/setup-acls.sh
```

Remove ACLs using the Kafka-UI as needed.

## References

- [Bitnami Kafka](https://github.com/bitnami/containers/blob/main/bitnami/kafka/README.md)
- [Kafka in KRaft mode](https://developer.confluent.io/learn/kraft/)
- [Kafka cluster with UI and metrics](https://medium.com/@penkov.vladimir/kafka-cluster-with-ui-and-metrics-easy-setup-d12d1b94eccf)
- [Kafka development with Docker](https://jaehyeon.me/blog/2023-07-20-kafka-development-with-docker-part-11/)
