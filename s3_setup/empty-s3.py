import boto3

s3 = boto3.resource("s3")
bucket = s3.Bucket("eks-terraformtfstate")
bucket.object_versions.delete()

bucket = s3.Bucket("monitoring-terraformtfstate")
bucket.object_versions.delete()