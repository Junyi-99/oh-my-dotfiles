from omd.deps.base import DependencyChecker
import shutil
import subprocess


class DependencyNodeJS(DependencyChecker):
    def __init__(self):
        super().__init__("nodejs", "latest")

    def check(self) -> bool:
        if shutil.which("node"):
            return True
        return False

    def install(self) -> bool:
        try:
            subprocess.run(["brew", "install", "node"], check=True)
            return True
        except subprocess.CalledProcessError:
            return False

    def uninstall(self) -> bool:
        try:
            subprocess.run(["brew", "uninstall", "node"], check=True)
            return True
        except subprocess.CalledProcessError:
            return False
