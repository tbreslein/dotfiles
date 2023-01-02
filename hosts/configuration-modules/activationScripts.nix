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
      ln -sf ${homeDir}/.dotfiles/configs/nvim ${homeDir}/.config/
    '';
    linkawesomewmconfig = ''
      ln -sf ${homeDir}/.dotfiles/configs/awesome ${homeDir}/.config/
    '';
    linkawesomelain = ''
      ln -sf ${homeDir}/Downloads/lain ${homeDir}/.config/awesome/
    '';
  };
}
