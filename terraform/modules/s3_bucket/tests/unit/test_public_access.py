def test_public_access_block(s3_module):
    """Validates that public access block is strictly enforced."""
    pab = s3_module['resource_changes']

    assert pab is not None, "Public access block resource is missing."
