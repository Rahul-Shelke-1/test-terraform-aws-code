def test_s3_bucket_creation(s3_module):
    """Test that the core S3 bucket resource respects variables loaded from a .tfvars fixture."""

    bucket = s3_module['resource_changes']

    assert bucket is not None, "S3 bucket resource is missing from plan."

    # 1. Assert the resource exists in the plan
    assert "aws_s3_bucket.this" in bucket[0]['address']

    # 2. Extract resource changes for the bucket
    bucket_change = bucket[0]
    after_state = bucket_change["change"]["after"]

    # 3. Assert bucket name matches what's defined in basic.tfvars
    assert after_state["bucket"] == "my-unit-test-bucket-2026"

    # 4. Assert tags match the fixture map
    assert after_state["tags"] == {
        "Environment": "UnitTest",
        "Project": "S3Module"
    }
