# The Gigabox

![Screenshot_2024-07-04-01-45-24_2256x1504](https://github.com/dupe-codes/dotfiles-redux/assets/4758600/fe8addc8-ea71-4909-a480-13d5055b3ef6)


## Setup guide

1. Follow the below instruction guides to intially configure barebones arch linux setup,
up to but not including the "install desktop environment step":
    - [arch linux wiki installation guide](https://wiki.archlinux.org/title/installation_guide)
    - [itsfoss guide](https://itsfoss.com/install-arch-linux/)
    - NOTE: You may need to install dhcpcd and configure it to autostart with systemctl:
        `sudo systemctl enable dhcpcd.service`

2. Restart system and login as dupe user:
    - exit chroot
    - unmount /mnt
    - shutdown now

3. Install any necessary graphics, video, and audio drivers

4. Install git then configure ssh auth
    - install ssh-keygen: `sudo pacman -S openssh`
    - follow keygen instructions at [github.com](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)

5. install python `sudo pacman -S python python-pip`

6. git clone dotfiles-redux

7. From within the dotfiles-redux directory, run: `./install`

## Additional setup options

### Enable tap-to-click

Add the following to /etc/X11/xorg.conf.d/30-touchpad.conf:

```
Section "InputClass"
    Identifier "touchpad"
    Driver "libinput"
    MatchIsTouchpad "on"
    Option "Tapping" "on"
    Option "TappingButtonMap" "lrm"
EndSection
```
