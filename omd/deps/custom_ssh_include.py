from omd.deps.base import DependencyChecker
import os


class DependencyCustomSSHInclude(DependencyChecker):
    def __init__(self):
        super().__init__("zoxide", "latest")
        self.ssh_config_path = os.path.expanduser("~/.ssh/config")

    def _contains_include(self) -> bool:
        with open(self.ssh_config_path, "r") as f:
            lines = f.readlines()
            for line in lines:
                if line.startswith("Include ~/.oh-my-dotfiles/etc/ssh/*.local"):
                    return True
        return False

    def check(self) -> bool:
        if not os.path.exists(self.ssh_config_path):
            return False
        return self._contains_include()

    def install(self) -> bool:
        if self._contains_include():
            return True

        try:
            with open(self.ssh_config_path, "a") as f:
                f.write("Include ~/.oh-my-dotfiles/etc/ssh/*.local")
            return True
        except Exception:
            return False

    def uninstall(self) -> bool:
        if not self._contains_include():
            return True

        try:
            with open(self.ssh_config_path, "r") as f:
                lines = f.readlines()
            with open(self.ssh_config_path, "w") as f:
                for line in lines:
                    if not line.startswith("Include ~/.oh-my-dotfiles/etc/ssh/*.local"):
                        f.write(line)
            return True
        except Exception:
            return False