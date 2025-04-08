
# Script to Update Boot Title and Configure System Hooks

This script automates the creation of a file that dynamically updates the boot title with the current kernel version whenever the system undergoes a kernel update. It also creates a `pacman` hook to automatically run the update script every time a kernel package is installed or upgraded.

## Script Content

The script performs the following tasks:

1. **Creates the `update-boot-title.sh` file:**
   - This file automatically updates the boot title with the current kernel version.
   - Each time the kernel is updated, the boot title will be updated to reflect the new kernel version.

2. **Creates the `pacman` hook `update-boot-title.hook`:**
   - This hook is triggered after installing or upgrading any package that matches the pattern `linux*` (kernel packages).
   - The `update-boot-title.sh` script will be executed automatically after any kernel package is installed or upgraded.


## Installation and Usage

### 1. Run the Script

To get started, copy the following script and save it as a `.sh` file (e.g., `setup-boot-title.sh`). Execute the script with superuser privileges to automatically configure all the necessary files.

```bash
# Download the script
wget https://example.com/setup-boot-title.sh -O setup-boot-title.sh

# Make the script executable
chmod +x setup-boot-title.sh

# Run the script as superuser
sudo ./setup-boot-title.sh
```

### 2. How It Works

- **`update-boot-title.sh`**:
   - The system's boot title will be automatically updated to reflect the current kernel version (e.g., "Linux 5.10.0-1").
   - The boot configuration file is located in `/boot/loader/entries`.

- **`pacman` hook**:
   - Every time a kernel package is installed or updated, the script will be executed to update the boot title.

- **`vash.sh`**:
   - The file is created at `/usr/local/bin/vash.sh`. You can edit it to add custom commands or configurations for your system.

### 3. Customizations

- You can customize the `vash.sh` script to include other configurations.
- If you do not wish to run the hook file, you can simply remove or disable the `/etc/pacman.d/hooks/update-boot-title.hook` file.

## Removal

If you wish to remove the files created by the script, you can do so manually:

```bash
# Remove the update script
sudo rm /usr/local/bin/update-boot-title.sh

# Remove the pacman hook
sudo rm /etc/pacman.d/hooks/update-boot-title.hook

```

## Author

This script was created by [Jonathan](https://github.com/Jonathansanfilippo) to automate the process of updating the boot title and configuring the system for custom setups.

## License

Distributed under the MIT License. See the LICENSE file for more details.
