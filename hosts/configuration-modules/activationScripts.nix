{ config, homeDir, ... }:

{
  system.userActivationScripts = {
    gnupgp = ''
      mkdir -p ${homeDir}/.gnupg
      touch ${homeDir}/.gnupg/gpg-agent.conf

      grep -q "^pinentry-program *" ${homeDir}/.gnupg/gpg-agent.conf
      if [ $? -ne 0 ]; then
        echo "pinentry-program /run/current-system/sw/bin/pinentry-curses" >> "${homeDir}/.gnupg/gpg-agent"
      fi
    '';
  };
}
