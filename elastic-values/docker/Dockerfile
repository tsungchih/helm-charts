ARG elasticsearch_version=7.9.1
FROM docker.elastic.co/elasticsearch/elasticsearch-oss:${elasticsearch_version}

RUN bin/elasticsearch-plugin install --batch https://d3g5vo6xdbdb9a.cloudfront.net/downloads/elasticsearch-plugins/opendistro-security/opendistro_security-1.11.0.0.zip \
    && bin/elasticsearch-plugin install --batch https://d3g5vo6xdbdb9a.cloudfront.net/downloads/elasticsearch-plugins/opendistro-job-scheduler/opendistro-job-scheduler-1.11.0.0.zip \
    && bin/elasticsearch-plugin install --batch https://d3g5vo6xdbdb9a.cloudfront.net/downloads/elasticsearch-plugins/opendistro-alerting/opendistro_alerting-1.11.0.1.zip \
    && bin/elasticsearch-plugin install --batch https://d3g5vo6xdbdb9a.cloudfront.net/downloads/elasticsearch-plugins/opendistro-sql/opendistro_sql-1.11.0.0.zip \
    && bin/elasticsearch-plugin install --batch https://d3g5vo6xdbdb9a.cloudfront.net/downloads/elasticsearch-plugins/opendistro-index-management/opendistro_index_management-1.11.0.0.zip \
    && bin/elasticsearch-plugin install --batch https://d3g5vo6xdbdb9a.cloudfront.net/downloads/elasticsearch-plugins/opendistro-anomaly-detection/opendistro-anomaly-detection-1.11.0.0.zip \
    && bin/elasticsearch-plugin install --batch https://d3g5vo6xdbdb9a.cloudfront.net/downloads/elasticsearch-plugins/performance-analyzer/opendistro_performance_analyzer-1.11.0.0.zip
