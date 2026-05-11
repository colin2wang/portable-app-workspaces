# Quark Cloud Drive Portable

## Overview

Quark Cloud Drive Portable is a portable version of the Quark Cloud Drive application, packaged using the PortableApps.com format. This allows you to run Quark Cloud Drive from any location (USB drive, cloud storage, etc.) without installing it on the host system and without leaving traces behind.

## Features

- **Fully Portable**: Runs without installation and leaves no registry entries or files on the host system
- **Settings Isolation**: All user settings and data are stored within the portable package
- **Registry Sandboxing**: Registry entries are isolated and redirected to prevent system pollution
- **Automatic Cleanup**: Temporary directories are automatically cleaned up when the application closes
- **Update Prevention**: Includes mechanisms to prevent forced updates that could break portability

## Directory Structure

```
QuarkCloudDrivePortable/
├── App/
│   ├── AppInfo/
│   │   ├── Launcher/
│   │   │   ├── Custom.nsh              # Custom launch/close scripts
│   │   │   └── QuarkCloudDrivePortable.ini  # Launcher configuration
│   │   ├── appicon.ico                 # Application icon
│   │   └── appinfo.ini                 # Application metadata
│   └── QuarkCloudDrive/                # Main application files
│       ├── !)阻止强制升级.bat           # Script to prevent forced updates
│       └── [Application binaries]      # Quark Cloud Drive executable and dependencies
├── Data/
│   └── settings/
│       ├── QCDrive_Bak.reg             # Registry backup
│       ├── QCDrive_Up1.reg             # Registry entries for upload context menu
│       ├── QCDrive_Up2.reg             # Registry entries for directory upload
│       └── QuarkCloudDrivePortableSettings.ini  # Portable launcher settings
├── .gitignore                          # Git ignore rules
├── QuarkCloudDrivePortable.exe         # Portable launcher executable
└── remove-quark-menu.bat               # Utility to remove context menu entries
```

## Usage

### Running the Application

Simply double-click `QuarkCloudDrivePortable.exe` to start Quark Cloud Drive. The application will run with all its data contained within the portable package.

### Preventing Forced Updates

The package includes two mechanisms to prevent forced updates:

1. **Automatic Prevention**: The launcher automatically creates a file at `%LocalAppData%\quark-cloud-drive-updater` to block the updater directory creation
2. **Manual Script**: Run `!)阻止强制升级.bat` inside the `App\QuarkCloudDrive\` directory to forcefully clean up any update-related files

### Removing Context Menu Entries

If you want to remove the Quark Cloud Drive context menu entries from Windows Explorer:

1. Run `remove-quark-menu.bat`
2. Restart Windows Explorer if needed

## Technical Details

### Launcher Configuration

The launcher is configured in `App/AppInfo/Launcher/QuarkCloudDrivePortable.ini`:

- **ProgramExecutable**: Points to `QuarkCloudDrive\QuarkCloudDrive.exe`
- **RunInBackground**: Set to `true` to avoid showing a command prompt window
- **WaitForExe**: Waits for `QuarkCloudDrive.exe` to close before exiting
- **Registry Sandboxing**: Isolates registry entries for context menus and application settings
- **Directory Redirection**: Redirects AppData and LocalAppData directories to the portable package

### Registry Isolation

The following registry keys are sandboxed:

- `HKCR\*\shell\QuarkCloudDrive.upload` - File context menu upload option
- `HKCR\Directory\shell\QuarkCloudDrive.upload` - Directory context menu upload option
- `HKCR\Directory\shell\QuarkCloudDrive.backup` - Directory context menu backup option
- `HKCU\Software\QuarkCloudDrive` - Application settings

### Directory Redirection

The following directories are redirected to the portable package:

- `%APPDATA%\quark-cloud-drive` → `Data/settings/quark-cloud-drive`
- `%LOCALAPPDATA%\quark-cloud-drive` → `Data/settings/quark-cloud-drive`
- `%LOCALAPPDATA%\quark-cloud-drive-updater` → `Data/settings/quark-cloud-drive-updater`

## Development Notes

### Building from Source

To rebuild the portable launcher:

1. Make changes to the configuration files in `App/AppInfo/`
2. Use the PortableApps.com Launcher Generator to recompile
3. Test the new executable thoroughly

### Custom Scripts

The `Custom.nsh` file contains custom NSIS functions:

- **CustomLaunch**: Executed before the main application starts
- **CustomClose**: Executed after the main application closes

### Version Information

- **Package Version**: 1.0.0.0
- **Display Version**: 1.0
- **Format Version**: 3.9 (PortableApps.com format)

## Troubleshooting

### Application Won't Start

1. Check if the path contains special characters or spaces
2. Verify that the `App/QuarkCloudDrive/` directory contains the application files
3. Try running as administrator if permission issues occur

### Settings Not Persisting

1. Ensure the `Data/` directory has write permissions
2. Check that antivirus software isn't blocking the application
3. Verify the launcher configuration in `QuarkCloudDrivePortable.ini`

### Context Menu Issues

1. Run `remove-quark-menu.bat` to clean up existing entries
2. Restart Windows Explorer
3. Re-launch the portable application to recreate the entries

## License and Disclaimer

This portable package is created for personal use and convenience. Quark Cloud Drive is a commercial product developed by Quark. Please respect the original software's license terms and conditions.

- The portable packaging script and configuration are provided as-is
- No warranty is provided for this portable package
- Users are responsible for complying with the original software's license

## Credits

- **Original Application**: Quark Cloud Drive by Quark
- **Portable Packaging**: Using PortableApps.com Format
- **Launcher Technology**: PortableApps.com Launcher

---

**Note**: This portable version is not officially affiliated with or endorsed by Quark. It is created by users for users to enhance portability and convenience.
