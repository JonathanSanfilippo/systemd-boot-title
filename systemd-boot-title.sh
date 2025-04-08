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

# Final message to indicate that the files were created and configured successfully
echo "All files have been created and configured correctly!"

