from omd.deps.base import DependencyChecker
import shutil
import subprocess


class DependencyHomebrew(DependencyChecker):
    def __init__(self):
        super().__init__("homebrew", "latest")

    def check(self) -> bool:
        if shutil.which("brew"):
            return True
        return False

    def install(self) -> bool:
        try:
            subprocess.run(["/bin/bash", "-c", "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"], check=True)
            return True
        except subprocess.CalledProcessError:
            return False

    def uninstall(self) -> bool:
        try:
            subprocess.run(["/bin/bash", "-c", "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"], check=True, env={"NONINTERACTIVE": "1"})
            return True
        except subprocess.CalledProcessError:
            return False
