from omd.deps.base import DependencyChecker
import shutil
import subprocess


class DependencyZoxide(DependencyChecker):
    def __init__(self):
        super().__init__("zoxide", "latest")

    def check(self) -> bool:
        if shutil.which("zoxide"):
            # TODO: check if `eval "$(zoxide init zsh)"` is in .zshrc
            
            return True
        return False

    def install(self) -> bool:
        try:
            subprocess.run(["brew", "install", "zoxide"], check=True)
            # TODO: add `eval "$(zoxide init zsh)"` to .zshrc
            return True
        except subprocess.CalledProcessError:
            return False

    def uninstall(self) -> bool:
        try:
            subprocess.run(["brew", "uninstall", "zoxide"], check=True)
            return True
        except subprocess.CalledProcessError:
            return False
        # TODO: remove `eval "$(zoxide init zsh)"` in .zshrc