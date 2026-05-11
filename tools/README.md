# PortableApps.com Launcher

## Overview

PortableApps.com Launcher is a universal portable application launcher that enables you to run Windows applications from removable drives (USB drives, external hard drives, cloud storage, etc.) without leaving traces on the host computer. It's part of the [PortableApps.com Platform](https://portableapps.com/), the most popular portable software suite for Windows.

**Version:** 2.2.9  
**License:** Open Source / Freeware  
**Publisher:** PortableApps.com

---

## Where to Download

### Official Sources

1. **PortableApps.com Launcher**
   - URL: https://portableapps.com/apps/development/portableapps.com_launcher
   - This is the primary source for downloading the launcher generator

2. **PortableApps.com Installer**
   - URL: https://portableapps.com/apps/development/portableapps.com_installer
   - The installer tool for creating portable application installers

3. **GitHub Repository**
   - Check the official PortableApps.com repositories for source code and releases
   - URL: https://github.com/PortableApps

### System Requirements

- **Operating System:** Windows 7, 8, 10, or 11 (32-bit or 64-bit)
- **Disk Space:** Minimal (launcher itself is lightweight)
- **Permissions:** Standard user permissions (no admin rights required for most operations)

---

## How to Use

### Quick Start Guide

#### Method 1: Using the Generator Wizard (Recommended for Beginners)

1. **Launch the Generator**
   ```
   Run: PortableApps.comLauncherGenerator.exe
   ```

2. **Follow the Wizard Steps**
   - Select the application you want to make portable
   - Configure application settings and parameters
   - Choose icons and metadata
   - Generate the portable launcher

3. **Test Your Portable App**
   - Run the generated executable
   - Verify that settings are saved in the Data directory
   - Test on different computers if needed

#### Method 2: Manual Configuration (For Advanced Users)

1. **Directory Structure**
   
   A typical portable app structure looks like this:
   ```
   YourAppPortable/
   ├── App/
   │   ├── AppInfo/
   │   │   ├── appinfo.ini       # Application metadata
   │   │   └── appicon.ico       # Application icon
   │   └── YourApp/              # Actual application files
   │       └── ...
   ├── Data/
   │   └── settings/             # User settings and data
   └── YourAppPortable.exe       # Generated launcher
   ```

2. **Configure appinfo.ini**
   
   Edit `App/AppInfo/appinfo.ini` with your application details:
   ```ini
   [Format]
   Type=PortableApps.comFormat
   Version=3.8

   [Details]
   Name=Your Application Name
   AppID=YourAppPortable
   Publisher=Your Name
   Homepage=https://your-website.com
   Category=Category
   Description=Brief description
   Language=English

   [License]
   Shareable=true
   OpenSource=false
   Freeware=true
   CommercialUse=false

   [Version]
   PackageVersion=1.0.0.0
   DisplayVersion=1.0

   [Control]
   Icons=1
   Start=YourApp.exe
   ```

3. **Create Custom Launch Parameters (Optional)**
   
   Create `App/AppInfo/Launcher/YourAppPortable.ini`:
   ```ini
   [Launch]
   ProgramExecutable=YourApp\YourApp.exe
   CommandLineArguments=--portable
   DirectoryMoveOK=yes
   SupportsUNC=yes
   
   [Environment]
   YOUR_VAR=value
   ```

4. **Build the Launcher**
   
   Use NSIS (Nullsoft Scriptable Install System) to compile:
   ```
   Navigate to: Other/Source/
   Run: makensis.exe PortableApps.comLauncher.nsi
   ```

---

## Key Features

### Portability Features
- ✅ **No Registry Traces** - Keeps registry changes isolated
- ✅ **Settings Management** - Automatically saves/loads user settings
- ✅ **Path Translation** - Handles absolute paths in configuration files
- ✅ **Environment Variables** - Sets custom environment variables for apps
- ✅ **Multi-language Support** - Supports 30+ languages

### Advanced Capabilities
- 📦 **Custom Segments** - Execute custom code before/after launch
- 🔧 **Plugin Support** - Extend functionality with NSIS plugins
- 🎨 **Splash Screen** - Customizable splash screen support
- 🌐 **Language Switching** - Automatic language detection and switching
- 📝 **XML Processing** - Built-in XML manipulation functions

---

## Documentation & Resources

### Built-in Documentation

The launcher includes comprehensive HTML documentation:
- **Main Help File:** `help.html` (in root directory)
- **Manual:** `App/Manual/index.html`
- **Troubleshooting:** `App/Manual/troubleshooting.html`

### Key Documentation Sections

1. **Introduction** (`App/Manual/intro/`)
   - Overview of portable app concepts
   - Quick start guide

2. **Features** (`App/Manual/features/`)
   - User features
   - Developer features

3. **Advanced Topics** (`App/Manual/advanced/`)
   - Custom segments
   - Debugging techniques
   - Development guidelines

4. **Reference** (`App/Manual/ref/`)
   - Launcher.ini configuration reference
   - PAF (PortableApps.com Format) specification
   - Environment variable substitution

5. **Examples** (`App/Manual/examples/`)
   - 7-Zip portable example
   - Scribus portable example

6. **Topics** (`App/Manual/topics/`)
   - 64-bit application support
   - Java applications
   - Qt applications
   - Registry handling
   - Splash screens
   - XML processing

### Online Resources

- **Official Website:** https://portableapps.com/
- **Launcher Documentation:** https://portableapps.com/apps/development/portableapps.com_launcher
- **Installer Documentation:** https://portableapps.com/apps/development/portableapps.com_installer
- **Forums:** https://portableapps.com/forum
- **Bug Tracker:** Available on GitHub repositories

---

## Common Use Cases

### 1. Making an Existing App Portable

```
Step 1: Install the application normally
Step 2: Copy installed files to App/YourApp/
Step 3: Create appinfo.ini with app metadata
Step 4: Configure launcher settings
Step 5: Test and debug
Step 6: Distribute the portable version
```

### 2. Creating a Game Launcher

See: `App/Manual/topics/games.html`
- Handle save games in Data directory
- Configure graphics settings
- Manage user profiles

### 3. Java Applications

See: `App/Manual/topics/java.html`
- Bundle JRE with your app
- Set JAVA_HOME environment variable
- Handle Java-specific path issues

---

## Troubleshooting

### Common Issues

**Problem:** Application doesn't start
- ✅ Check that `ProgramExecutable` path is correct in launcher.ini
- ✅ Verify all required DLLs and dependencies are present
- ✅ Enable debug mode to see detailed logs

**Problem:** Settings not saving
- ✅ Ensure Data directory has write permissions
- ✅ Check file paths in configuration files
- ✅ Verify registry cleanup isn't removing needed entries

**Problem:** Language not switching
- ✅ Check that language files are in correct location
- ✅ Verify locale settings in appinfo.ini
- ✅ Ensure application supports multiple languages

### Debug Mode

Enable debugging by setting in your launcher configuration:
```ini
[Debug]
LogLevel=verbose
LogFile=%PAL:DataDir%\settings\debug.log
```

View logs at: `Data/settings/debug.log`

---

## Development Tools Included

This package includes:

- **NSIS Compiler** (`App/NSIS/makensis.exe`)
  - Nullsoft Scriptable Install System for building launchers
  
- **Generator Wizard** (`PortableApps.comLauncherGenerator.exe`)
  - GUI tool for creating portable apps
  
- **Plugins** (`Other/Source/Plugins/`)
  - Extended functionality for NSIS scripts
  
- **Sample Scripts** (`Other/Source/Segments/`)
  - Pre-built code segments for common tasks

---

## Best Practices

### For Users
1. Always store user data in the `Data/` directory
2. Never modify files in the `App/` directory directly
3. Regularly backup your `Data/` directory
4. Test portable apps on multiple systems

### For Developers
1. Follow the PortableApps.com Format specification
2. Use relative paths whenever possible
3. Implement proper cleanup on exit
4. Test with UAC enabled and disabled
5. Provide clear error messages
6. Document any special requirements

---

## License

PortableApps.com Launcher is released under an open source license. See the license files in the `Other/Source/` directory for complete terms.

**Key Points:**
- ✅ Free for personal use
- ✅ Free for commercial use
- ✅ Open source - modify and redistribute
- ✅ Shareable - distribute with your portable apps

---

## Support & Community

- **Forum:** https://portableapps.com/forum
- **Launcher Documentation:** https://portableapps.com/apps/development/portableapps.com_launcher
- **Installer Documentation:** https://portableapps.com/apps/development/portableapps.com_installer
- **Email:** Contact through the official website
- **GitHub:** Submit issues and pull requests

---

## Version History

### Version 2.2.9 (Current)
- Latest stable release
- Improved compatibility with Windows 10/11
- Enhanced language support
- Bug fixes and performance improvements

See `App/Manual/releases/` for detailed release notes.

---

## Contributing

Contributions are welcome! To contribute:

1. Fork the repository on GitHub
2. Create a feature branch
3. Make your changes
4. Submit a pull request
5. Follow the coding standards in the documentation

---

## Credits

**Developer:** PortableApps.com  
**Technology:** NSIS (Nullsoft Scriptable Install System)  
**Community:** PortableApps.com forum contributors  

Special thanks to the open source community for their continued support.

---

**Last Updated:** May 2026  
**Document Version:** 1.0
