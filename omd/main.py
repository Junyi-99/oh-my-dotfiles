# add ~/.oh-my-dotfiles into the pythonpath

import sys
sys.path.append("/Users/junyi/.oh-my-dotfiles")


from omd.deps import DependencyFzf, DependencyHomebrew, DependencyNeovim, DependencyNodeJS, DependencyBatcat, DependencyDuf, DependencyZoxide, DependencyCustomSSHInclude

if __name__ == "__main__":
    DependencyHomebrew().check() or DependencyHomebrew().install()    
    DependencyFzf().check() or DependencyFzf().install()
    DependencyBatcat().check() or DependencyBatcat().install()
    DependencyNeovim().check() or DependencyNeovim().install()
    DependencyNodeJS().check() or DependencyNodeJS().install()
    DependencyDuf().check() or DependencyDuf().install()
    DependencyZoxide().check() or DependencyZoxide().install()
    DependencyCustomSSHInclude().check() or DependencyCustomSSHInclude().install()