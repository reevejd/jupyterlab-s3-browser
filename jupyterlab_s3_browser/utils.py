"""
Util methods
"""

import boto3
from botocore.exceptions import NoCredentialsError


class Utils:
    """
  Class containing util methods
  """

    @staticmethod
    def _test_aws_s3_role_access():
        """
    Checks if we have access to AWS S3 through role-based access
    """
        test = boto3.resource("s3")
        all_buckets = test.buckets.all()
        result = [
            {"name": bucket.name + "/", "path": bucket.name + "/", "type": "directory"}
            for bucket in all_buckets
        ]
        return result

    @staticmethod
    def has_aws_s3_role_access():
        """
      Returns true if the user has access to an S3 bucket
      """
        try:
            Utils._test_aws_s3_role_access()
            return True
        except NoCredentialsError:
            return False
