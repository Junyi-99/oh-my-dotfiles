from omd.deps.base import DependencyChecker
import shutil
import subprocess


class DependencyDuf(DependencyChecker):
    def __init__(self):
        super().__init__("duf", "latest")

    def check(self) -> bool:
        if shutil.which("duf"):
            return True
        return False

    def install(self) -> bool:
        try:
            subprocess.run(["brew", "install", "duf"], check=True)
            return True
        except subprocess.CalledProcessError:
            return False

    def uninstall(self) -> bool:
        try:
            subprocess.run(["brew", "uninstall", "duf"], check=True)
            return True
        except subprocess.CalledProcessError:
            return False
