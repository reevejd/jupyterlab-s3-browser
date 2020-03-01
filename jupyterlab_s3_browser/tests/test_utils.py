import pytest
import jupyterlab_s3_browser
from moto import mock_s3


def test_not_has_aws_s3_role_access_when_unauthenticated():
    if jupyterlab_s3_browser.has_aws_s3_role_access():
        pytest.fail("Unexpectedly found s3 role-based access.")


@mock_s3
def test_has_aws_s3_role_access_when_authenticated():
    if not jupyterlab_s3_browser.has_aws_s3_role_access():
        pytest.fail("not authenticated")
