from omd.deps.base import DependencyChecker
import subprocess
import shutil


class DependencyBatcat(DependencyChecker):
    def __init__(self):
        super().__init__("batcat", "latest")

    def check(self) -> bool:
        batcat = shutil.which("batcat")
        bat = shutil.which("bat")
        if batcat or bat:
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
