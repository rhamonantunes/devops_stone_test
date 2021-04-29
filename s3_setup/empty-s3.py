import boto3

s3 = boto3.resource("s3")
bucket = s3.Bucket("eks-terraform-state")
bucket.object_versions.delete()

bucket = s3.Bucket("monitoring-terraform-state")
bucket.object_versions.delete()