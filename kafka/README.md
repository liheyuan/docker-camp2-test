# kafka common cmd 

## Topic 
```
# add topic
kafka-topics.sh --zookeeper sbmvt-zk-test:2181 --create --partitions 1 --topic topic1 --replication-factor 1
Created topic "topic1".

# list topic
kafka-topics.sh --zookeeper sbmvt-zk-test:2181 --list

# describe topic
kafka-topics.sh --describe --zookeeper sbmvt-zk-test:2181 --topic topic1

```

## Producer & Consumer
```
# publish topic
kafka-console-producer.sh --broker-list kafka_kafka-1-test:9092 --topic topic1

# consume topic
kafka-console-consumer.sh --zookeeper sbmvt-zk-test:2181 --from-beginning --topic topic1
```
