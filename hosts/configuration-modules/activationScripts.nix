{ config, homeDir, ... }:

let
  gpgagentconf = "${homeDir}/.gnupg/gpg-agent.conf";
in
{
  system.userActivationScripts = {
    gnupgp = ''
      mkdir -p ${homeDir}/.gnupg
      touch ${gpgagentconf}

      [[ "^pinentry-program " =~ $(cat "${gpgagentconf}") ]] && echo "pinentry-program /run/current-system/sw/bin/pinentry-curses" >> "${gpgagentconf}"
    '';
    removeInitVim = ''
      rm -fr ${homeDir}/.config/nvim/init.vim
    '';
    linkneovimconfig = ''
      ln -sf ${homedir}/.dotfiles/configs/nvim ${homedir}/.config/
    '';
    linkawesomewmconfig = ''
      ln -sf ${homedir}/.dotfiles/configs/awesome ${homedir}/.config/
    '';
  };
}
