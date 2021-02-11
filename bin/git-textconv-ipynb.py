#!/usr/bin/env python
import json
import sys
import hashlib

fn = sys.argv[1]

with open(fn) as f:
    try:
        nb = json.load(f)
    except json.decoder.JSONDecodeError as e:
        sys.stderr.write(f"ERROR in {sys.argv[0]}: {e}")
        sys.stderr.write(f"ERROR in {sys.argv[0]}: Failing back to doing nothing.")
        for line in f:
            print(line)
        sys.exit(0) # signal ok

for cell in nb['cells']:
    for output in cell.get("outputs",[]):
        data = output.get("data", {})
        if "image/png" in data:
            chksum = hashlib.sha256(data["image/png"].encode()).hexdigest()
            data["image/png"] = f"<<sha256:{chksum}>>"

print(json.dumps(
    nb,
    indent=1,
    sort_keys=True
))
