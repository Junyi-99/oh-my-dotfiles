from omd.deps.base import DependencyChecker
import shutil
import subprocess


class DependencyNeovim(DependencyChecker):
    def __init__(self):
        super().__init__("neovim", "latest")

    def check(self) -> bool:
        if shutil.which("nvim"):
            return True
        return False

    def install(self) -> bool:
        try:
            subprocess.run(["brew", "install", "neovim"], check=True)
            return True
        except subprocess.CalledProcessError:
            return False

    def uninstall(self) -> bool:
        try:
            subprocess.run(["brew", "uninstall", "neovim"], check=True)
            return True
        except subprocess.CalledProcessError:
            return False
