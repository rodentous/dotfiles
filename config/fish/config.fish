for file in ~/config/fish/config/*.fish
    source $file
end

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin /home/rodent/.ghcup/bin $PATH # ghcup-env
