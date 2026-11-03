import hashlib
import os
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest


ROOT = Path(__file__).resolve().parents[1]


class UpdateFormulaTest(unittest.TestCase):
    def test_repeated_updates_preserve_architecture_and_macos_requirement(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            (root / "Casks").mkdir()
            (root / "scripts").mkdir()
            (root / "bin").mkdir()
            formula = root / "Casks/storytel-player.rb"
            shutil.copy(ROOT / "Casks/storytel-player.rb", formula)
            script = root / "scripts/update-homebrew-formula.sh"
            shutil.copy(ROOT / "scripts/update-homebrew-formula.sh", script)
            curl = root / "bin/curl"
            curl.write_text('''#!/bin/bash
set -eu
url=""
while [ "$#" -gt 0 ]; do
    case "$1" in
        https://*) url="$1"; shift ;;
        -o) output="$2"; shift 2 ;;
        *) shift ;;
    esac
done
printf '%s' "$url" > "$output"
''')
            curl.chmod(0o755)
            env = {**os.environ, "PATH": f"{root / 'bin'}:{os.environ['PATH']}"}

            for version in ("9.8.7", "9.8.8"):
                with self.subTest(version=version):
                    subprocess.run(
                        ["bash", str(script), version],
                        env=env, check=True, capture_output=True, text=True,
                    )
                    result = formula.read_text()
                    self.assertIn('arch arm: "arm64", intel: "x64"', result)
                    self.assertIn('depends_on macos: :monterey', result)
                    self.assertIn(f'version "{version}"', result)
                    for architecture in ("arm64", "x64"):
                        url = (
                            "https://github.com/debba/storytel-player/releases/download/"
                            f"v{version}/Storytel-Player-{version}-mac-{architecture}.dmg"
                        )
                        checksum = hashlib.sha256(url.encode()).hexdigest()
                        self.assertIn(f'"{checksum}"', result)

                    previous = result
                    subprocess.run(
                        ["bash", str(script), version],
                        env=env, check=True, capture_output=True, text=True,
                    )
                    self.assertEqual(formula.read_text(), previous)


if __name__ == "__main__":
    unittest.main()
