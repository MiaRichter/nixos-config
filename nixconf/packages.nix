{ pkgs, ... }:
{
fonts.packages = with pkgs; [
    # Основные Nerd Fonts
    nerd-fonts.jetbrains-mono    # Уже есть
    nerd-fonts.fira-code         # Нужно добавить
    nerd-fonts.symbols-only      # Нужно добавить
    dejavu_fonts
    noto-fonts
    noto-fonts-color-emoji
    # Font Awesome
    font-awesome                # Включает все версии
  ];
environment.systemPackages = with pkgs; [
  # Терминалы и оболочки
    kitty
    #alacritty  # опционально

    webkitgtk_4_1	
    patchelf    
    libxml2
    # Браузеры
    firefox
    #chromium   # опционально
    # GUI утилиты
    rofi
    nautilus
    hyprpaper
    #hyprlock    # блокировщик экрана
    #hypridle    # управление бездействием
    waybar
    gdm-settings
    # Мультимедиа
    vlc
    mpv
    # Мессенджеры
    telegram-desktop
    vesktop
    # для waybar
    jq                   # JSON parsing for weather script
    networkmanager       # Network management
    libnotify            # Desktop notifications for profile changes
    brightnessctl        # Backlight control utility
    pavucontrol
    # Офис
    libreoffice-fresh

  # Пакеты для СИСТЕМЫ (все пользователи)
    # Редакторы
    vim
    nano
    helix        # современный редактор
    vscode    
    # Мониторинг
    htop
    btop         # красивая замена htop
    neofetch
   # nvtopPackages.full        # мониторинг GPU
    
    # fish пакеты
    fishPlugins.done
    fishPlugins.fzf-fish
    fishPlugins.forgit
    fishPlugins.hydro
    fzf
    fishPlugins.grc
    grc
    # Архиваторы
    zip
    unzip
    p7zip
    unrar
    # пакеты для Hyperland
    hyprlock
    hypridle
    nwg-look
       
    # Сетевые утилиты
    wget
    curl
    git
    sshfs
    
    # Системные утилиты
    pciutils     # lspci
    usbutils     # lsusb
    lm_sensors   # sensors
    dmidecode    # информация о железе
    
    # Файловые системы
    ntfs3g
    exfatprogs
    
    # Безопасность
    gnupg
    openssl
    
    # Разработка
    gcc
    python3
    nodejs
    # автомонтирование дисков
    udisks2
  # Игровые пакеты
    qbittorrent
    steam
    protonup-qt  # менеджер Proton-GE
    mangohud     # оверлей FPS
    goverlay     # GUI для MangoHud
    gamemode     # оптимизация для игр
    soteria
  ];
}
