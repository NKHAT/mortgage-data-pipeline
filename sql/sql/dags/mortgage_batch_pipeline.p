from datetime import datetime
from airflow import DAG
from airflow.providers.google.cloud.operators.bigquery import BigQueryInsertJobOperator

default_args = {
    'owner': 'data_engineering',
    'start_date': datetime(2026, 1, 1),
    'retries': 1,
}

with DAG(
    'mortgage_legacy_csv_pipeline',
    default_args=default_args,
    schedule_interval='@daily',
    catchup=False,
    template_searchpath=['/home/airflow/gcs/dags/sql/']
) as dag:

    load_staging = BigQueryInsertJobOperator(
        task_id='load_staging_legacy_table',
        configuration={
            "query": {
                "query": "temp1_load_legacy.sql",
                "useLegacySql": False,
            }
        }
    )

    apply_scd_type2 = BigQueryInsertJobOperator(
        task_id='apply_scd_type2_core',
        configuration={
            "query": {
                "query": "temp2_merge_legacy_scd.sql",
                "useLegacySql": False,
            }
        }
    )

    load_staging >> apply_scd_type2
