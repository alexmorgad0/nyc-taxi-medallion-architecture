from airflow import DAG
from airflow.operators.bash import BashOperator
from airflow.operators.python import PythonOperator
from datetime import datetime

def load_raw_data():
    import subprocess
    subprocess.run(["python", "/opt/airflow/load_raw_to_sql.py"], check=True)

with DAG(
    dag_id="taxi_pipeline_dag",
    start_date=datetime(2025, 1, 1),
    schedule_interval=None,   # manual run only
    catchup=False,
    tags=["taxi", "dbt", "azure"],
) as dag:

    ingest_raw = PythonOperator(
        task_id="ingest_raw",
        python_callable=load_raw_data
    )

    dbt_run = BashOperator(
        task_id="dbt_run",
        bash_command="cd /opt/airflow/dbt_project && dbt run --profiles-dir /opt/airflow/dbt_profile"
    )

    dbt_test = BashOperator(
        task_id="dbt_test",
        bash_command="cd /opt/airflow/dbt_project && dbt test --profiles-dir /opt/airflow/dbt_profile"
    )

    ingest_raw >> dbt_run >> dbt_test
