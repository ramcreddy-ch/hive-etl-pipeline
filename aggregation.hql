-- Create partitioned table for web logs
CREATE EXTERNAL TABLE IF NOT EXISTS web_logs (
    ip_address STRING,
    request_time STRING,
    method STRING,
    url STRING,
    response_code INT,
    user_agent STRING
)
PARTITIONED BY (dt STRING, country STRING)
STORED AS PARQUET
LOCATION '/data/warehouse/web_logs';

-- Daily aggregation
INSERT OVERWRITE TABLE daily_traffic PARTITION (dt='${hiveconf:DT}')
SELECT
    country,
    url,
    count(1) as hits,
    count(distinct ip_address) as unique_visitors
FROM web_logs
WHERE dt='${hiveconf:DT}'
GROUP BY country, url;
