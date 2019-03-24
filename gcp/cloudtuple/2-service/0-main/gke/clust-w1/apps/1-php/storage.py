#!/usr/bin/env python3

from google.cloud import storage

storage_client = storage.Client()
buckets = list(storage_client.list_buckets())

for bucket in buckets:
    print("=============================")
    print(bucket.name)
    print("=============================")
    blobs = bucket.list_blobs()
    for blob in blobs:
        print(blob.name)
