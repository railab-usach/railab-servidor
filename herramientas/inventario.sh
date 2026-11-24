# Solo lectura: specs del servidor del RAI Lab (sin sudo, sin cambios)
echo "=== SO ==="; cat /etc/os-release | grep -E '^(PRETTY_NAME|VERSION_ID)='; uname -r; uptime
echo "=== CPU ==="; lscpu | grep -E 'Model name|^CPU\(s\)|Thread|Core|Socket|MHz|L3|Flags' | sed 's/Flags:.*/&/' | cut -c1-200
echo "AVX2: $(grep -c avx2 /proc/cpuinfo) núcleos | AVX: $(grep -c ' avx ' /proc/cpuinfo) núcleos | F16C: $(grep -c f16c /proc/cpuinfo)"
echo "=== RAM ==="; free -h
echo "--- Módulos (udev, sin root) ---"; udevadm info /sys/devices/virtual/dmi/id 2>/dev/null | sed -n 's/^E: //p' | grep -E '^MEMORY_DEVICE_[0-9]+_(LOCATOR|SIZE|PRESENT|SPEED_MTS)='
echo "=== Discos ==="; lsblk -o NAME,SIZE,TYPE,ROTA,MODEL,MOUNTPOINT | grep -v loop; df -h -x tmpfs -x devtmpfs -x squashfs -x overlay
echo "=== PCI (GPU, red, audio) ==="; lspci | grep -Ei 'vga|3d|nvidia|ethernet|network|audio|usb'
echo "=== GPU driver ==="; lsmod | grep -Ei 'nouveau|nvidia' | head; command -v nvidia-smi && nvidia-smi --query-gpu=name,memory.total,driver_version --format=csv 2>&1
echo "=== Red ==="; ip -br addr | grep -v '^lo'; ip route | head -3
echo "=== Puertos escuchando ==="; ss -tlnH | awk '{print $4}' | sort -u
echo "=== SSH config ==="; grep -Ei '^\s*(PasswordAuthentication|PermitRootLogin|PubkeyAuthentication)' /etc/ssh/sshd_config /etc/ssh/sshd_config.d/*.conf 2>/dev/null
echo "=== Firewall ==="; systemctl is-active ufw 2>&1; systemctl is-active fail2ban 2>&1
echo "=== Servicios activos (no del sistema) ==="; systemctl list-units --type=service --state=running --no-legend | awk '{print $1}' | grep -Ev '^(systemd|dbus|getty|polkit|cron|rsyslog|udisks|upower|accounts|ModemManager|multipathd|packagekit|networkd|snapd\.|serial-getty|user@)' | head -40
echo "=== Snaps ==="; snap list 2>/dev/null | awk 'NR>1{print $1, $2}'
echo "=== Docker ==="; command -v docker && docker ps --format '{{.Names}} {{.Image}} {{.Status}}' 2>&1 | head
echo "=== Ollama ==="; OH=$(systemctl show ollama.service -p Environment --value 2>/dev/null | grep -o 'OLLAMA_HOST=[^ ]*' | cut -d= -f2); export OLLAMA_HOST=${OH:-127.0.0.1:11434}
command -v ollama && ollama --version 2>&1; ollama list 2>&1 | head; ollama ps 2>&1 | head -5
echo "=== Python/herramientas ==="; python3 --version; for t in git pip3 ffmpeg mosquitto piper whisper llama-server tailscale; do printf "%s: " $t; command -v $t || echo no; done
echo "=== Temperaturas ==="; command -v sensors >/dev/null && sensors 2>/dev/null | grep -E 'Package|Core|temp' | head -8 || cat /sys/class/thermal/thermal_zone*/temp 2>/dev/null
echo "=== Usuarios con shell ==="; awk -F: '$7 ~ /(bash|zsh|sh)$/ {print $1}' /etc/passwd
echo "=== Home railab (1 nivel) ==="; ls -la ~ | head -40
echo "=== Repos git en home ==="; find ~ -maxdepth 3 -name .git -type d 2>/dev/null | head
echo "FIN"
