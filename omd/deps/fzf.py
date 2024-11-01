from omd.deps.base import DependencyChecker
import subprocess
import shutil

class DependencyFzf(DependencyChecker):
    def __init__(self):
        super().__init__("fzf", "latest")

    def check(self) -> bool:
        if shutil.which("fzf"):
            return True
        return False
        
    def install(self) -> bool:
        try:
            subprocess.run(["brew", "install", "fzf"], check=True)
            return True
        except subprocess.CalledProcessError:
            return False

    def uninstall(self) -> bool:
        try:
            subprocess.run(["brew", "uninstall", "fzf"], check=True)
            return True
        except subprocess.CalledProcessError:
            return False
