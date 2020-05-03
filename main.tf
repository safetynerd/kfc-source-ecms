provider "kafkaconnect" {
  url = data.vault_generic_secret.kafka-secrets["kafka-connect"]
}


resource "kafkaconnect_connector" "source" {
  config = {
    "connector.class" = "io.debezium.connector.sqlserver.SqlServerConnector",
    "snapshot.locking.mode" = "none",
    "tasks.max" = "1",
    "database.hostname" = data.vault_generic_secret.ecms-secrets["host"],
    "database.port" = "1433",
    "database.user" = data.vault_generic_secret.ecms-secrets["user"],
    "database.password" = data.vault_generic_secret.ecms-secrets["password"],
    "database.server.id" = "9",
    "database.server.name" = "ecms",
    "database.dbname" = "ecmsSecRc",
    "table.whitelist" = "dbo.Inspections",
    "database.history.kafka.bootstrap.servers" = data.vault_generic_secret.kafka-secrets["kafka_broker"],
    "database.history.kafka.topic" = "ecms_history_topic",
    "snapshot.mode" = "initial",
    "transforms" = "unwrap",
    "transforms.unwrap.type" = "io.debezium.transforms.ExtractNewRecordState",
    "transforms.unwrap.drop.tombstones" = "false",
    "transforms.unwrap.delete.handling.mode" = "rewrite"
  }

}