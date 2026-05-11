# Development Guidelines

## Code Standards

### File Naming
- Use camelCase for variable and function names
- Use PascalCase for class and component names
- Use kebab-case for file names (e.g., `my-component.js`)
- Configuration files use `.ini` format with clear section headers

### Directory Structure
```
ProjectNamePortable/
├── App/                    # Application files (read-only)
│   ├── AppInfo/           # Metadata and configuration
│   │   ├── appinfo.ini    # Application information
│   │   ├── appicon.ico    # Application icon
│   │   └── Launcher/      # Launcher settings
│   └── ApplicationFiles/  # Actual application
├── Data/                   # User data (writable)
│   └── settings/          # User preferences
└── ProjectNamePortable.exe # Launcher executable
```

### Configuration Files

#### appinfo.ini Format
```ini
[Format]
Type=PortableApps.comFormat
Version=3.8

[Details]
Name=Application Name
AppID=AppNamePortable
Publisher=Your Name
Homepage=https://example.com
Category=Utilities
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
Start=app.exe
```

## Development Workflow

### 1. Planning Phase
- Identify target application and its requirements
- Check licensing restrictions
- Determine what needs to be portable (settings, cache, registry entries)
- Plan directory structure and file organization

### 2. Setup Phase
- Create project directory under `projects/`
- Copy application files to `App/` directory
- Create necessary subdirectories
- Add application icon to `App/AppInfo/appicon.ico`

### 3. Configuration Phase
- Fill in `appinfo.ini` with accurate metadata
- Configure launcher parameters in `App/AppInfo/Launcher/`
- Set up environment variables if needed
- Add custom NSIS scripts for special handling

### 4. Testing Phase
- Test on development machine
- Verify settings persistence in `Data/` directory
- Check for registry leaks
- Test on clean Windows installations (VMs recommended)
- Test with UAC enabled/disabled
- Verify path translation works correctly

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

### 6. Packaging Phase
- Clean up unnecessary files
- Optimize file sizes
- Add documentation
- Create final distributable package
- Scan for viruses before distribution

## Best Practices

### For Portability
1. Store all user data in `Data/` directory
2. Use launcher variables instead of hardcoded paths:
   - `%PAL:AppDir%` - Path to App directory
   - `%PAL:DataDir%` - Path to Data directory
   - `%PAL:LauncherDir%` - Path to launcher
3. Clean up temporary files on exit
4. Handle registry changes properly
5. Support multiple languages if applicable

### For Maintenance
1. Keep `App/` directory separate from user data
2. Document any special requirements
3. Version control configuration files (not binaries)
4. Test before and after application updates
5. Backup `Data/` directory regularly during testing

### For Distribution
1. Include clear usage instructions
2. Provide changelog for updates
3. Respect application licenses
4. Test on multiple Windows versions (7/8/10/11)
5. Scan for malware before release

## Git Workflow

### What to Commit
- ✅ Configuration files (*.ini, *.nsh)
- ✅ Custom scripts and segments
- ✅ Documentation (README, guides)
- ✅ Launcher source files
- ✅ Icon files

### What NOT to Commit
- ❌ Application binaries (copyright issues)
- ❌ User data and settings (`Data/` directory)
- ❌ Generated executables
- ❌ Temporary files and logs
- ❌ IDE-specific files (except shared configs)

### Commit Messages
Use English for commit messages:
```
Add new feature or fix issue

- Brief description of changes
- List key modifications
- Reference related issues if applicable
```

## Documentation Updates

### Updating CHANGE-HISTORY.md

When making significant changes, update the change history file:

1. **Add entry at the top** (under the most recent date):
   ```markdown
   ## 2026-05-11
   - Added new feature or made changes
     - Details about the change
     - Link to relevant files: [filename](path/to/file)
   ```

2. **Format guidelines:**
   - Use present tense ("Added", "Fixed", "Updated")
   - Keep descriptions concise but informative
   - Include links to relevant files when applicable
   - Group related changes under one bullet point

3. **Example:**
   ```markdown
   ## 2026-05-11
   - Added clean-gitignored-files script to automate cleanup
     - PowerShell script: [scripts/clean-gitignored-files.ps1](scripts/clean-gitignored-files.ps1)
     - Batch launcher: [scripts/clean-gitignored-files.bat](scripts/clean-gitignored-files.bat)
   - Updated documentation
     - See [README.md](README.md) and [README_zh.md](README_zh.md)
   ```

### Synchronizing README Files

When updating documentation, ensure consistency across language versions:

1. **Update English README first** (`README.md`)
2. **Translate changes to Chinese README** (`README_zh.md`)
3. **Verify Quick Links section** in both files includes:
   - Change History link
   - Development Guidelines link
   - Cross-language links

4. **Quick Links format:**
   ```markdown
   [Change History](CHANGE-HISTORY.md) | [Development Guidelines](DEVELOPMENT_GUIDELINES.md) | [中文文档](README_zh.md)
   ```

5. **Checklist for documentation updates:**
   - [ ] Updated CHANGE-HISTORY.md with today's date
   - [ ] Added descriptive entries for changes
   - [ ] Included relevant file links
   - [ ] Updated README.md (English version)
   - [ ] Updated README_zh.md (Chinese version)
   - [ ] Verified Quick Links are consistent
   - [ ] Checked formatting and markdown syntax

## Testing Checklist

Before releasing a portable app:

- [ ] Application starts correctly
- [ ] Settings are saved to `Data/` directory
- [ ] No files written outside the portable directory
- [ ] No registry entries left on host system
- [ ] Works with UAC enabled
- [ ] Works without administrator privileges
- [ ] Paths translate correctly on different drives
- [ ] Cleanup occurs on exit
- [ ] Multiple instances handled properly (if applicable)
- [ ] Language switching works (if supported)

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

## License Considerations

⚠️ **Important:** Always respect software licenses when creating portable versions:

- ✅ Freeware applications are generally safe
- ✅ Open source applications (check specific license)
- ⚠️ Shareware may have restrictions
- ❌ Commercial software usually prohibits redistribution
- ❌ Never crack or bypass license protection

Always check the original application's license agreement before distributing portable versions.

---

**Last Updated:** May 2026  
**Maintainer:** Project Contributors
