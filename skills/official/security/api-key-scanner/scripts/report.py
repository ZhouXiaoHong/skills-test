#!/usr/bin/env python3
import json
import sys


def summarize(matches):
    return {
        "total_matches": len(matches),
        "files": sorted({m.get("file", "unknown") for m in matches}),
    }


if __name__ == "__main__":
    data = json.load(sys.stdin) if not sys.stdin.isatty() else []
    print(json.dumps(summarize(data), indent=2))
