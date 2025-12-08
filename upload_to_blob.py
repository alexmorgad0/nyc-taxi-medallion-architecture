from pathlib import Path
from azure.storage.blob import BlobServiceClient

# <<< CHANGE THIS >>>
CONNECTION_STRING = "****"
CONTAINER_NAME = "taxi-data"  

def upload_parquet_files():
    # Connect to Blob service
    blob_service_client = BlobServiceClient.from_connection_string(CONNECTION_STRING)
    container_client = blob_service_client.get_container_client(CONTAINER_NAME)

    raw_folder = Path("data/raw")

    for file_path in raw_folder.glob("*.parquet"):
        # Example filename: yellow_tripdata_2025-08.parquet
        filename = file_path.name  # 'yellow_tripdata_2025-08.parquet'

        # Extract year and month from filename
        # assumes pattern yellow_tripdata_YYYY-MM.parquet
        parts = filename.replace(".parquet", "").split("_")  # ['yellow', 'tripdata', '2025-08']
        year_month = parts[-1]  # '2025-08'
        year, month = year_month.split("-")

        # Blob path in the container (lake structure)
        blob_path = f"raw/year={year}/month={month}/{filename}"

        print(f"Uploading {file_path} -> {blob_path}")

        with open(file_path, "rb") as data:
            container_client.upload_blob(
                name=blob_path,
                data=data,
                overwrite=True
            )

    print("✅ All Parquet files uploaded to Blob storage.")

if __name__ == "__main__":
    upload_parquet_files()
