#!/usr/bin/env python3
"""Fetch all Stitch screen images and code."""
import subprocess, json, base64, os

API_KEY = "AQ.Ab8RN6L_0i7xxUvBafJVrovQTItd0I5H6CIl7D2C9pq0Pem1ew"
PROJECT = "5489010742620086530"
OUTDIR = "/Users/tony/projects/clients/oncall-protekt-app/design-reference"

SCREENS = {
    "01-design-system": "asset-stub-assets-e8ef375f065344dbab1dc9d7d70b0a3d-1774496996976",
    "02-profile-dark": "20a3c442a2b040c8b5a5e0652b6d0f8a",
    "03-notifications-dark": "be947664e87a4424b0c162247beae81d",
    "04-my-jobs-dark": "9937b83e7918493c8d0d08efe74c39be",
    "05-help-support-dark": "c5f459d1cae545108a130db9a1049f19",
    "06-sign-in-sentinel": "9819a4b9a40449c18c4898005c10a5da",
    "07-profile-sentinel": "ca21231f521049ebb49c7fc9ba04e291",
    "08-help-support-sentinel": "93012bf662084a7497d1a3a160f479da",
    "09-notifications-sentinel": "8d22601c372c4205a62f3a425687d014",
    "10-my-jobs-sentinel": "441b93eafbe448348fea24ab6f619d78",
}

os.makedirs(OUTDIR, exist_ok=True)

def fetch(tool, name, screen_id):
    env = os.environ.copy()
    env["STITCH_API_KEY"] = API_KEY
    data = json.dumps({"projectId": PROJECT, "screenId": screen_id})
    result = subprocess.run(
        ["npx", "@_davideast/stitch-mcp", "tool", tool, "-d", data],
        capture_output=True, text=True, env=env, timeout=60
    )
    if result.returncode != 0:
        print(f"  ERROR ({tool}): {result.stderr[:200]}")
        return None
    try:
        return json.loads(result.stdout)
    except json.JSONDecodeError:
        # Try to extract just the JSON object
        out = result.stdout.strip()
        start = out.find('{')
        if start >= 0:
            try:
                return json.loads(out[start:])
            except:
                pass
        print(f"  JSON parse error for {name} ({tool})")
        return None

for name, sid in SCREENS.items():
    print(f"Fetching {name}...")

    # Get image
    img_data = fetch("get_screen_image", name, sid)
    if img_data and "imageContent" in img_data:
        img_bytes = base64.b64decode(img_data["imageContent"])
        with open(f"{OUTDIR}/{name}.png", "wb") as f:
            f.write(img_bytes)
        print(f"  Saved {name}.png ({len(img_bytes)//1024}KB)")
    else:
        print(f"  Skipped image for {name}")

    # Get code
    code_data = fetch("get_screen_code", name, sid)
    if code_data and "code" in code_data:
        with open(f"{OUTDIR}/{name}.html", "w") as f:
            f.write(code_data["code"])
        print(f"  Saved {name}.html")
    elif code_data and "html" in code_data:
        with open(f"{OUTDIR}/{name}.html", "w") as f:
            f.write(code_data["html"])
        print(f"  Saved {name}.html")
    else:
        print(f"  Skipped code for {name}")

print("\nDone! Files in:", OUTDIR)
