import pandas as pd
from sqlalchemy import create_engine
from azure.storage.blob import BlobServiceClient
from io import BytesIO

# CHANGE THESE
BLOB_CONNECTION_STRING = "****"
CONTAINER_NAME = "taxi-data"
BLOB_PATH = "raw/year=2025/month=08/yellow_tripdata_2025-08.parquet"

SQL_SERVER = "***"
SQL_DATABASE = "sqldb-taxi-platform"
SQL_USERNAME = "***"          
SQL_PASSWORD = "***"     


def load_to_sql():
    print("📥 Downloading Parquet from Blob...")

    blob_service = BlobServiceClient.from_connection_string(BLOB_CONNECTION_STRING)
    container_client = blob_service.get_container_client(CONTAINER_NAME)
    blob_data = container_client.download_blob(BLOB_PATH).readall()

    df = pd.read_parquet(BytesIO(blob_data))
    print(f"Total rows in file: {len(df)}")


    conn_str = (
        f"mssql+pyodbc://{SQL_USERNAME}:{SQL_PASSWORD}"
        f"@{SQL_SERVER}:1433/{SQL_DATABASE}"
        "?driver=ODBC+Driver+18+for+SQL+Server"
        "&Encrypt=yes&TrustServerCertificate=no"
    )

    engine = create_engine(conn_str, fast_executemany=True)

    print("📝 Writing to Azure SQL table raw.yellow_trips_2025_08 ...")
    df.to_sql(
        name="yellow_trips_2025_08",
        schema="raw",
        con=engine,
        if_exists="replace",
        index=False,
        chunksize=20000,
    )

    print("✅ Done: data in raw.yellow_trips_2025_08")


if __name__ == "__main__":
    load_to_sql()
