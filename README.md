# Hive ETL Pipeline

A data pipeline using HiveQL and Shell coordination for processing daily web logs.

## Workflow
1. Ingest raw logs to HDFS.
2. Load data into `web_logs` staging table.
3. Run `aggregation.hql` to summarize traffic.
4. Export results to downstream MySQL.

## Structure
- `scripts/`: Shell wrappers
- `hql/`: Hive queries
