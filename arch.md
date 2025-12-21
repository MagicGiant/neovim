# Всякие Arch настройки

## Установка yay

```sh
sudo pacman -S --needed base-devel git
mkdir ~/builds
cd mkdir ~/builds
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
```

## Необходимые пакеты

```sh
yay -S git cmake extra-cmake-modules base-devel qt5-tools cargo unzip
```

## Установка приложений
```sh
yay -S partitionmanager rar exfatprogs obs-studio crow-translater flameshot-git jdk-openjdk sing-geoip-db sing-geosite-db telegram-desktop-bin termite cava steam zoom onlyoffice-bin loupe visual-studio-code-bin  zsh fastfetch playerctl

```

## Установка китайских символов

```sh
yay -S noto-fonts-cjk adobe-source-han-sans-cn-fonts adobe-source-han-serif-cn-fonts wqy-microhei
sudo nano /etc/locale.gen
```

раскомментировать:
zh_CN.UTF-8 UTF-8
zh_TW.UTF-8 UTF-8
en_US.UTF-8 UTF-8

```sh
sudo locale-gen
```

## Установка остальных символов - картинок

```sh
yay -S ttf-nerd-fonts-symbols
fc-cache -fv
```

Название "Symbols Nerd Font"

## Установка oh my zsh (красивый терминал)

```sh
rm -rf ~/.oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```

``` sh
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k

vim  ~/.zshrc
```

ZSH_THEME заменить на:

```bashrc
ZSH_THEME="powerlevel10k/powerlevel10k"
```

Выполняем
```sh
source ~/.zshrc
```

## Добавление дирректории в path.

> ⚠️ Работает только в используемом окружении. Если используется .bashrc, записывать туда. Если .zshrc...

```sh
export PATH=$PATH:/путь/к/директории
```

## Круглая тема

```sh
cd ~/builds
git clone https://github.com/matinlotfali/KDE-Rounded-Corners
cd KDE-Rounded-Corners
mkdir build
cd build
cmake ..
cmake --build . -j
sudo make install
```

```sh
cd ~/builds
git clone https://github.com/vinceliuice/Graphite-kde-theme.git
cd Graphite-kde-theme
./install.sh
```

## Playerctl (позволяет прокручивать ролики и аудио. Можно назначить горячие клавиши)

```sh
playerctl position 5+
```
