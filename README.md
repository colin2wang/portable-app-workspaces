# Portable Apps Workspace

## Overview

This is a development workspace for creating, testing, and debugging portable applications using the PortableApps.com format. The project provides all necessary tools and templates to convert regular Windows applications into fully portable versions that can run from USB drives, cloud storage, or any removable media without leaving traces on the host system.

---

## Project Structure

```
portable-app-workspaces/
├── projects/                    # Directory for portable app projects
│   └── QuarkCloudDrivePortable/ # Example: Quark Cloud Drive portable version
│       ├── App/                 # Application files
│       ├── Data/                # User data and settings
│       └── QuarkCloudDrivePortable.exe
│
├── tools/                       # Development tools
│   └── PortableApps.comLauncher/# PortableApps.com Launcher toolkit
│       ├── App/                 # Launcher runtime files
│       ├── Other/Source/        # Source code and build scripts
│       ├── PortableApps.comLauncherGenerator.exe
│       └── README.md            # Launcher documentation
│
└── .idea/                       # IDE configuration (WebStorm)
```

---

## What You Can Do Here

### 🎯 Create Portable Applications
- Convert installed Windows applications to portable format
- Package standalone applications with portable settings management
- Create custom launchers with specific configurations

### 🔧 Debug and Test
- Test portable apps across different Windows environments
- Debug launcher configurations and scripts
- Verify registry isolation and file path handling

### 📦 Distribute
- Build self-contained portable application packages
- Customize icons, metadata, and launch parameters
- Prepare apps for distribution on USB drives or cloud storage

---

## Quick Start

### Prerequisites

- **Operating System:** Windows 7/8/10/11
- **IDE:** WebStorm (or any text editor)
- **Knowledge:** Basic understanding of Windows file systems and INI files

### Step 1: Explore the Tools

The main tool is located at:
```
tools/PortableApps.comLauncher/PortableApps.comLauncherGenerator.exe
```

Run this executable to launch the GUI wizard for creating portable apps.

### Step 2: Study the Example

An example portable app is provided:
```
projects/QuarkCloudDrivePortable/
```

Examine its structure to understand:
- How files are organized
- Configuration in `App/AppInfo/appinfo.ini`
- Launcher settings in `App/AppInfo/Launcher/`
- User data storage in `Data/`

### Step 3: Create Your First Portable App

#### Option A: Using the Generator Wizard (Recommended)

1. Run `PortableApps.comLauncherGenerator.exe`
2. Follow the wizard steps:
   - Select source application
   - Configure launcher settings
   - Set application metadata
   - Generate the portable executable
3. Test the generated portable app

#### Option B: Manual Creation

1. **Create directory structure:**
   ```
   MyAppPortable/
   ├── App/
   │   ├── AppInfo/
   │   │   ├── appinfo.ini
   │   │   └── appicon.ico
   │   └── MyApp/
   └── Data/
   ```

2. **Copy application files** to `App/MyApp/`

3. **Configure appinfo.ini:**
   ```ini
   [Format]
   Type=PortableApps.comFormat
   Version=3.8

   [Details]
   Name=My Application
   AppID=MyAppPortable
   Publisher=Your Name
   Homepage=https://example.com
   Category=Utilities
   Description=Portable version of My Application
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
   Start=MyApp.exe
   ```

4. **Build the launcher** using NSIS compiler:
   ```powershell
   cd tools/PortableApps.comLauncher/Other/Source
   .\makensis.exe PortableApps.comLauncher.nsi
   ```

5. **Test your portable app**

---

## Key Concepts

### PortableApps.com Format

The format uses a standardized directory structure:

- **App/** - Contains the actual application files (read-only, replaced on updates)
- **Data/** - Stores user settings and data (preserved across updates)
- **AppNamePortable.exe** - The launcher executable

### Launcher Configuration

Key configuration files:

1. **appinfo.ini** - Application metadata and version info
2. **Launcher.ini** - Launch parameters and behavior settings
3. **Custom.nsh** - Custom NSIS scripts for advanced operations

### Path Variables

The launcher supports special variables:

- `%PAL:AppDir%` - Path to the App directory
- `%PAL:DataDir%` - Path to the Data directory  
- `%PAL:LauncherDir%` - Path to the launcher executable
- `%PAL:DefaultLanguage%` - Default language code

---

## Development Workflow

### 1. Planning
- Identify the target application
- Determine what needs to be made portable (settings, cache, etc.)
- Check for licensing restrictions

### 2. Initial Setup
- Create directory structure in `projects/`
- Copy application files
- Create basic configuration files

### 3. Configuration
- Edit `appinfo.ini` with correct metadata
- Configure launcher parameters
- Set up environment variables if needed
- Add custom segments for special handling

### 4. Testing
- Run the portable app on your development machine
- Test on clean Windows installations (VMs recommended)
- Verify settings persistence
- Check for registry leaks
- Test with UAC enabled/disabled

### 5. Debugging

Enable debug mode by adding to launcher configuration:
```ini
[Debug]
LogLevel=verbose
LogFile=%PAL:DataDir%\debug.log
```

Common issues to check:
- ✅ File paths (use relative paths when possible)
- ✅ Registry access (should be redirected)
- ✅ Hardcoded paths in application config
- ✅ Permission requirements
- ✅ Dependency files (DLLs, runtimes)

### 6. Packaging
- Clean up unnecessary files
- Optimize file sizes
- Add documentation
- Create final distributable package

---

## Tools Included

### PortableApps.com Launcher Generator
- **Location:** `tools/PortableApps.comLauncher/PortableApps.comLauncherGenerator.exe`
- **Purpose:** GUI wizard for creating portable apps
- **Features:** Automated setup, icon selection, metadata configuration

### NSIS Compiler
- **Location:** `tools/PortableApps.comLauncher/App/NSIS/makensis.exe`
- **Purpose:** Compile launcher scripts into executables
- **Usage:** Command-line or integrated in generator

### Documentation
- **Location:** `tools/PortableApps.comLauncher/help.html`
- **Manual:** `tools/PortableApps.comLauncher/App/Manual/index.html`
- **Examples:** `tools/PortableApps.comLauncher/App/Manual/examples/`

---

## Best Practices

### For Portability
1. ✅ Store all user data in `Data/` directory
2. ✅ Use launcher variables instead of hardcoded paths
3. ✅ Clean up temporary files on exit
4. ✅ Handle registry changes properly
5. ✅ Support multiple languages if applicable

### For Maintenance
1. ✅ Keep `App/` directory separate from user data
2. ✅ Document any special requirements
3. ✅ Version control your configuration files
4. ✅ Test before and after application updates
5. ✅ Backup `Data/` directory regularly

### For Distribution
1. ✅ Include clear usage instructions
2. ✅ Provide changelog for updates
3. ✅ Respect application licenses
4. ✅ Scan for viruses before distribution
5. ✅ Test on multiple Windows versions

---

## Common Tasks

### Adding a New Portable App

```powershell
# 1. Create project directory
New-Item -ItemType Directory -Path "projects/MyNewAppPortable"

# 2. Create subdirectories
New-Item -ItemType Directory -Path "projects/MyNewAppPortable/App/AppInfo/Launcher"
New-Item -ItemType Directory -Path "projects/MyNewAppPortable/Data/settings"

# 3. Copy application files to App/MyNewApp/
# 4. Create configuration files
# 5. Build and test
```

### Updating an Existing Portable App

```powershell
# 1. Backup Data directory
Copy-Item "projects/MyAppPortable/Data" "projects/MyAppPortable/Data.backup"

# 2. Replace App directory contents with new version
Remove-Item "projects/MyAppPortable/App/MyApp/*" -Recurse
Copy-Item "path/to/new/version/*" "projects/MyAppPortable/App/MyApp/" -Recurse

# 3. Update version in appinfo.ini
# 4. Test thoroughly
# 5. Remove backup if successful
```

### Debugging Launcher Issues

```powershell
# Enable verbose logging
# Edit: App/AppInfo/Launcher/MyAppPortable.ini
# Add:
# [Debug]
# LogLevel=verbose

# Run the app and check log
Get-Content "projects/MyAppPortable/Data/settings/debug.log"
```

---

## Troubleshooting

### Application Won't Start
- Check executable path in launcher.ini
- Verify all dependencies are present
- Run with debug mode enabled
- Check Windows Event Viewer for errors

### Settings Not Saving
- Ensure Data directory has write permissions
- Verify file paths in application config
- Check if app uses registry (needs redirection)
- Review launcher cleanup settings

### Paths Not Translating Correctly
- Use `%PAL:AppDir%` and `%PAL:DataDir%` variables
- Check for hardcoded absolute paths
- Review FilesMove and RegistryEntries sections
- Test path translation in debug mode

---

## Resources

### Official Documentation
- **PortableApps.com:** https://portableapps.com/
- **Development Guide:** https://portableapps.com/development
- **Launcher Manual:** `tools/PortableApps.comLauncher/App/Manual/`

### Community
- **Forums:** https://portableapps.com/forum
- **GitHub:** https://github.com/PortableApps

### Related Tools
- **NSIS Documentation:** https://nsis.sourceforge.io/
- **PortableApps.com Platform:** https://portableapps.com/download

---

## License Considerations

⚠️ **Important:** Always respect software licenses when creating portable versions:

- ✅ Freeware applications are generally safe
- ✅ Open source applications (check specific license)
- ⚠️ Shareware may have restrictions
- ❌ Commercial software usually prohibits redistribution
- ❌ Never crack or bypass license protection

Always check the original application's license agreement before distributing portable versions.

---

## Contributing to This Workspace

If you're collaborating on this project:

1. Create new portable apps in the `projects/` directory
2. Follow the standard directory structure
3. Document any special configurations
4. Test thoroughly before committing
5. Update this README if you add new tools or processes

---

## Version Control Notes

### What to Commit
- ✅ Configuration files (*.ini, *.nsh)
- ✅ Custom scripts and segments
- ✅ Documentation
- ✅ Launcher source files

### What NOT to Commit
- ❌ Actual application binaries (copyright issues)
- ❌ User data and settings
- ❌ Generated executables
- ❌ Temporary files and logs

Use `.gitignore` to exclude sensitive or large files.

---

## Getting Help

1. **Check the documentation** in `tools/PortableApps.comLauncher/`
2. **Review the example** in `projects/QuarkCloudDrivePortable/`
3. **Search online** at PortableApps.com forums
4. **Enable debug mode** to diagnose issues
5. **Test in a clean VM** to isolate problems

---

**Workspace Created:** May 2026  
**Last Updated:** May 2026  
**Maintainer:** Project Contributors
