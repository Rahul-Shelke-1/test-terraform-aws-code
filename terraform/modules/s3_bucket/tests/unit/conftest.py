import os
import pytest
from tftest import TerraformTest, TerraformPlanOutput

@pytest.fixture(scope="module")
def s3_module():
    """
    Initializes and runs a Terraform plan on the S3 module once per test session.
    """
    # 1. Go up two levels from tests/unit/ to reach the root Terraform module folder
    root_dir = os.path.abspath(os.path.join(os.path.dirname(__file__), "../.."))

    tf_test = TerraformTest(tfdir=root_dir, binary="tofu")
    tf_test.setup(use_cache=True)

    # 2. Go up one level to tests/, then into fixtures/ for basic.tfvars
    tfvars_path = os.path.abspath(os.path.join(os.path.dirname(__file__), "../fixtures/basic.tfvars"))

    # 3. Run plan with the variables file
    plan = tf_test.plan(tf_var_file=tfvars_path, output=True)._raw
    return plan
