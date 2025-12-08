FROM apache/airflow:2.9.1-python3.11

USER airflow

RUN pip install --no-cache-dir \
    dbt-core==1.10.0 \
    dbt-sqlserver==1.9.0
