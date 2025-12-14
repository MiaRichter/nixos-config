{ pkgs }:

{
  # Пакеты для ПОЛЬЗОВАТЕЛЯ akane
  userPackages = with pkgs; [
    # Терминалы и оболочки
    kitty
    #alacritty  # опционально
    
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
    # Мультимедиа
    vlc
    mpv
    
    # Мессенджеры
    telegram-desktop
    vesktop
    
    # Работа с файлами
    
    # Офис
    libreoffice-fresh
    
  ];

  # Пакеты для СИСТЕМЫ (все пользователи)
  systemPackages = with pkgs; [
    # Редакторы
    vim
    nano
    helix        # современный редактор
    
    # Мониторинг
    htop
    btop         # красивая замена htop
    neofetch
    #nvtop        # мониторинг GPU
    
    # Архиваторы
    zip
    unzip
    p7zip
    unrar
    
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
  ];

  # Игровые пакеты
  gamingPackages = with pkgs; [
    steam
    protonup-qt  # менеджер Proton-GE
    mangohud     # оверлей FPS
    goverlay     # GUI для MangoHud
    gamemode     # оптимизация для игр
  ];
}