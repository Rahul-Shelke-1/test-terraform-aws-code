import json

def test_public_access_block(s3_module):
    """Validates that public access block is strictly enforced."""

    pab = s3_module['resource_changes']
    resource_address = "aws_s3_bucket_public_access_block.this"

    pab_change = next((item for item in pab if item['address'] == resource_address), None)
    after_state = pab_change["change"]["after"]

    assert pab is not None, "Public access block resource is missing."
    assert resource_address == pab_change["address"]
    assert after_state["block_public_acls"] is True
    assert after_state["block_public_policy"] is True
    assert after_state["ignore_public_acls"] is True
    assert after_state["restrict_public_buckets"] is True
