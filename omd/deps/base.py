import subprocess
import sys
import os
from abc import ABC, abstractmethod
from typing import List

class DependencyChecker(ABC):
    def __init__(self, name: str, version: str):
        self.name = name
        self.version = version

    @abstractmethod
    def check(self) -> bool:
        raise NotImplementedError

    @abstractmethod
    def install(self) -> bool:
        raise NotImplementedError

    @abstractmethod
    def uninstall(self) -> bool:
        raise NotImplementedError

    def __str__(self):
        return self.name + " " + self.version
