# 便携应用工作区

## 概述

这是一个用于创建、测试和调试便携式应用程序的开发工作区，使用 PortableApps.com 格式。本项目提供了所有必要的工具和模板，可以将常规的 Windows 应用程序转换为完全便携的版本，使其能够从 USB 驱动器、云存储或任何可移动媒体运行，而不在宿主系统上留下痕迹。

---

## 项目结构

```
portable-app-workspaces/
├── projects/                    # 便携应用项目目录
│   └── QuarkCloudDrivePortable/ # 示例：夸克网盘便携版
│       ├── App/                 # 应用程序文件
│       ├── Data/                # 用户数据和设置
│       └── QuarkCloudDrivePortable.exe
│
├── tools/                       # 开发工具
│   └── PortableApps.comLauncher/# PortableApps.com Launcher 工具包
│       ├── App/                 # Launcher 运行时文件
│       ├── Other/Source/        # 源代码和构建脚本
│       ├── PortableApps.comLauncherGenerator.exe
│       └── README.md            # Launcher 文档
│
└── .idea/                       # IDE 配置 (WebStorm)
```

---

## 功能特性

### 🎯 创建便携应用
- 将已安装的 Windows 应用程序转换为便携格式
- 打包具有独立设置管理的 standalone 应用程序
- 创建具有特定配置的自定义启动器

### 🔧 调试和测试
- 在不同的 Windows 环境中测试便携应用
- 调试启动器配置和脚本
- 验证注册表隔离和文件路径处理

### 📦 分发部署
- 构建自包含的便携应用程序包
- 自定义图标、元数据和启动参数
- 准备用于 USB 驱动器或云存储分发的应用

---

## 快速开始

### 前置要求

- **操作系统：** Windows 7/8/10/11
- **IDE：** WebStorm（或任何文本编辑器）
- **知识：** 基本了解 Windows 文件系统和 INI 文件

### 步骤 1：探索工具

主要工具位于：
```
tools/PortableApps.comLauncher/PortableApps.comLauncherGenerator.exe
```

运行此可执行文件以启动创建便携应用的 GUI 向导。

### 步骤 2：研究示例

提供了一个示例便携应用：
```
projects/QuarkCloudDrivePortable/
```

检查其结构以了解：
- 文件如何组织
- `App/AppInfo/appinfo.ini` 中的配置
- `App/AppInfo/Launcher/` 中的启动器设置
- `Data/` 中的用户数据存储

### 步骤 3：创建你的第一个便携应用

#### 选项 A：使用生成器向导（推荐）

1. 运行 `PortableApps.comLauncherGenerator.exe`
2. 按照向导步骤：
   - 选择源应用程序
   - 配置启动器设置
   - 设置应用程序元数据
   - 生成便携可执行文件
3. 测试生成的便携应用

#### 选项 B：手动创建

1. **创建目录结构：**
   ```
   MyAppPortable/
   ├── App/
   │   ├── AppInfo/
   │   │   ├── appinfo.ini
   │   │   └── appicon.ico
   │   └── MyApp/
   └── Data/
   ```

2. **复制应用程序文件**到 `App/MyApp/`

3. **配置 appinfo.ini：**
   ```ini
   [Format]
   Type=PortableApps.comFormat
   Version=3.8

   [Details]
   Name=我的应用
   AppID=MyAppPortable
   Publisher=你的名字
   Homepage=https://example.com
   Category=Utilities
   Description=我的应用的便携版本
   Language=Chinese

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

4. **使用 NSIS 编译器构建启动器：**
   ```powershell
   cd tools/PortableApps.comLauncher/Other/Source
   .\makensis.exe PortableApps.comLauncher.nsi
   ```

5. **测试你的便携应用**

---

## 核心概念

### PortableApps.com 格式

该格式使用标准化的目录结构：

- **App/** - 包含实际的应用程序文件（只读，更新时替换）
- **Data/** - 存储用户设置和数据（跨更新保留）
- **AppNamePortable.exe** - 启动器可执行文件

### 启动器配置

关键配置文件：

1. **appinfo.ini** - 应用程序元数据和版本信息
2. **Launcher.ini** - 启动参数和行为设置
3. **Custom.nsh** - 用于高级操作的自定义 NSIS 脚本

### 路径变量

启动器支持特殊变量：

- `%PAL:AppDir%` - App 目录的路径
- `%PAL:DataDir%` - Data 目录的路径  
- `%PAL:LauncherDir%` - 启动器可执行文件的路径
- `%PAL:DefaultLanguage%` - 默认语言代码

---

## 开发工作流程

### 1. 规划
- 确定目标应用程序
- 确定需要便携化的内容（设置、缓存等）
- 检查许可限制

### 2. 初始设置
- 在 `projects/` 中创建目录结构
- 复制应用程序文件
- 创建基本配置文件

### 3. 配置
- 使用正确的元数据编辑 `appinfo.ini`
- 配置启动器参数
- 设置环境变量（如需要）
- 添加自定义段以进行特殊处理

### 4. 测试
- 在开发机器上运行便携应用
- 在干净的 Windows 安装上测试（推荐使用虚拟机）
- 验证设置持久性
- 检查注册表泄漏
- 在启用/禁用 UAC 的情况下测试

### 5. 调试

通过在启动器配置中添加以下内容启用调试模式：
```ini
[Debug]
LogLevel=verbose
LogFile=%PAL:DataDir%\debug.log
```

常见问题检查：
- ✅ 文件路径（尽可能使用相对路径）
- ✅ 注册表访问（应该被重定向）
- ✅ 应用程序配置中的硬编码路径
- ✅ 权限要求
- ✅ 依赖文件（DLL、运行时）

### 6. 打包
- 清理不必要的文件
- 优化文件大小
- 添加文档
- 创建最终可分发包

---

## 包含的工具

### PortableApps.com Launcher Generator
- **位置：** `tools/PortableApps.comLauncher/PortableApps.comLauncherGenerator.exe`
- **用途：** 用于创建便携应用的 GUI 向导
- **功能：** 自动设置、图标选择、元数据配置

### NSIS 编译器
- **位置：** `tools/PortableApps.comLauncher/App/NSIS/makensis.exe`
- **用途：** 将启动器脚本编译为可执行文件
- **用法：** 命令行或集成在生成器中

### 文档
- **位置：** `tools/PortableApps.comLauncher/help.html`
- **手册：** `tools/PortableApps.comLauncher/App/Manual/index.html`
- **示例：** `tools/PortableApps.comLauncher/App/Manual/examples/`

---

## 最佳实践

### 便携性
1. ✅ 将所有用户数据存储在 `Data/` 目录中
2. ✅ 使用启动器变量而不是硬编码路径
3. ✅ 退出时清理临时文件
4. ✅ 正确处理注册表更改
5. ✅ 如果适用，支持多种语言

### 维护
1. ✅ 保持 `App/` 目录与用户数据分离
2. ✅ 记录任何特殊要求
3. ✅ 对配置文件进行版本控制
4. ✅ 在应用程序更新前后进行测试
5. ✅ 定期备份 `Data/` 目录

### 分发
1. ✅ 包含清晰的使用说明
2. ✅ 为更新提供变更日志
3. ✅ 尊重应用程序许可证
4. ✅ 分发前扫描病毒
5. ✅ 在多个 Windows 版本上测试

---

## 常见任务

### 添加新的便携应用

```powershell
# 1. 创建项目目录
New-Item -ItemType Directory -Path "projects/MyNewAppPortable"

# 2. 创建子目录
New-Item -ItemType Directory -Path "projects/MyNewAppPortable/App/AppInfo/Launcher"
New-Item -ItemType Directory -Path "projects/MyNewAppPortable/Data/settings"

# 3. 复制应用程序文件到 App/MyNewApp/
# 4. 创建配置文件
# 5. 构建和测试
```

### 更新现有的便携应用

```powershell
# 1. 备份 Data 目录
Copy-Item "projects/MyAppPortable/Data" "projects/MyAppPortable/Data.backup"

# 2. 用新版本替换 App 目录内容
Remove-Item "projects/MyAppPortable/App/MyApp/*" -Recurse
Copy-Item "path/to/new/version/*" "projects/MyAppPortable/App/MyApp/" -Recurse

# 3. 更新 appinfo.ini 中的版本
# 4. 彻底测试
# 5. 如果成功则删除备份
```

### 调试启动器问题

```powershell
# 启用详细日志记录
# 编辑：App/AppInfo/Launcher/MyAppPortable.ini
# 添加：
# [Debug]
# LogLevel=verbose

# 运行应用并检查日志
Get-Content "projects/MyAppPortable/Data/settings/debug.log"
```

---

## 故障排除

### 应用程序无法启动
- 检查 launcher.ini 中的可执行文件路径
- 验证所有依赖项是否存在
- 启用调试模式运行
- 检查 Windows 事件查看器中的错误

### 设置未保存
- 确保 Data 目录具有写入权限
- 验证应用程序配置中的文件路径
- 检查应用是否使用注册表（需要重定向）
- 检查启动器清理设置

### 路径转换不正确
- 使用 `%PAL:AppDir%` 和 `%PAL:DataDir%` 变量
- 检查硬编码的绝对路径
- 检查 FilesMove 和 RegistryEntries 部分
- 在调试模式下测试路径转换

---

## 资源

### 官方文档
- **PortableApps.com：** https://portableapps.com/
- **开发指南：** https://portableapps.com/development
- **Launcher 手册：** `tools/PortableApps.comLauncher/App/Manual/`

### 社区
- **论坛：** https://portableapps.com/forum
- **GitHub：** https://github.com/PortableApps

### 相关工具
- **NSIS 文档：** https://nsis.sourceforge.io/
- **PortableApps.com 平台：** https://portableapps.com/download

---

## 许可注意事项

⚠️ **重要：** 创建便携版本时务必尊重软件许可证：

- ✅ 免费软件通常安全
- ✅ 开源应用程序（检查特定许可证）
- ⚠️ 共享软件可能有限制
- ❌ 商业软件通常禁止重新分发
- ❌ 切勿破解或绕过许可证保护

在分发便携版本之前，始终检查原始应用程序的许可协议。

---

## 为此工作区做贡献

如果你正在协作此项目：

1. 在 `projects/` 目录中创建新的便携应用
2. 遵循标准目录结构
3. 记录任何特殊配置
4. 提交前彻底测试
5. 如果添加了新工具或流程，请更新此 README

---

## 版本控制说明

### 应该提交的内容
- ✅ 配置文件 (*.ini, *.nsh)
- ✅ 自定义脚本和段
- ✅ 文档
- ✅ 启动器源文件

### 不应提交的内容
- ❌ 实际的应用程序二进制文件（版权问题）
- ❌ 用户数据和设置
- ❌ 生成的可执行文件
- ❌ 临时文件和日志

使用 `.gitignore` 排除敏感或大型文件。

---

## 获取帮助

1. **检查文档**在 `tools/PortableApps.comLauncher/` 中
2. **查看示例**在 `projects/QuarkCloudDrivePortable/` 中
3. **在线搜索**在 PortableApps.com 论坛
4. **启用调试模式**诊断问题
5. **在干净的虚拟机中测试**隔离问题

---

**工作区创建时间：** 2026年5月  
**最后更新：** 2026年5月  
**维护者：** 项目贡献者
