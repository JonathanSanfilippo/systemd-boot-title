
# Automatic Boot Title Update Script

This script automates the process of updating the boot title in the bootloader configuration files whenever a new kernel version is installed or upgraded on your system. It also sets up a `pacman` hook to ensure the title is updated after each kernel package installation.

## What the script does:
1. **Updates the boot title**: The script updates the boot title in the `/boot/loader/entries` configuration files to reflect the current kernel version.
2. **Sets up a pacman hook**: The script creates a pacman hook that triggers the `update-boot-title.sh` script whenever the `linux*` package is installed or upgraded. This ensures the boot title is updated automatically after kernel updates.

## Steps to run the script:

### 1. Create the boot title update script:
This will create a script that updates the boot title with the current kernel version.

```bash
#!/bin/bash

# Create the script to update the boot title with the current kernel version
cat << 'EOF' | sudo tee /usr/local/bin/update-boot-title.sh > /dev/null
#!/bin/bash

# Define the directory containing boot entries
BOOT_ENTRIES="/boot/loader/entries"

# Get the current kernel version
KERNEL_VERSION=$(uname -r)

# Loop through each boot entry configuration file in the boot entries directory
for entry in "$BOOT_ENTRIES"/*.conf; do
    # Check if the file contains a title line
    if grep -q '^title' "$entry"; then
        # Update the title to reflect the current kernel version
        sed -i "s/^title.*/title   Linux $KERNEL_VERSION/" "$entry"
    fi
done
EOF

# Make the script executable
sudo chmod +x /usr/local/bin/update-boot-title.sh
```

### 2. Create the pacman hook:
This sets up a pacman hook that will run the script automatically after kernel upgrades.

```bash
# Create the directory for pacman hooks if it doesn't already exist
sudo mkdir -p /etc/pacman.d/hooks

# Create the pacman hook file to update the boot title automatically after kernel updates
cat << 'EOF' | sudo tee /etc/pacman.d/hooks/update-boot-title.hook > /dev/null
[Trigger]
Type = Package
Operation = Install
Operation = Upgrade
Target = linux*

[Action]
Description = Updating boot title with current kernel version...
When = PostTransaction
Exec = /usr/local/bin/update-boot-title.sh
EOF
```

### 3. Verify the setup:
After running the script, it will update the bootloader title automatically each time the kernel is installed or upgraded. You can check the `/boot/loader/entries` directory to see if the titles are being updated correctly.

## Conclusion:
This setup ensures that your bootloader entries are always up to date with the current kernel version without requiring manual intervention after every kernel update. It's an efficient way to keep track of which kernel version is running when booting the system.

---

## License
This script is open source. Feel free to modify and use it as needed.
