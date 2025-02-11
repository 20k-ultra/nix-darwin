# nix-darwin

```
#0 - Change hostname

#0.1 - Remove items from dock
#0.2 - auto hide top bar
#0.3 - disable natural scroll and enable tap (gestures)
#0.4 - change mission control to not rearrange apps

#1 Install nix
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install

#1.5 Create nix config folder
mkdir -p ~/.config/nix

#2 backup previous config
sudo mv /etc/nix/nix.conf /etc/nix/nix.conf.before-nix-darwin

# !! Close terminal and open again

#2.5 download home-manager
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update

#3 Clone this repo's nix folder into ~/.config/nix

#4 run to apply
nix run nix-darwin --extra-experimental-features 'nix-command flakes' -- switch --flake ~/.config/nix

#5 any updates you make after can be applied with just 
darwin-rebuild switch --flake ~/.config/nix
```
