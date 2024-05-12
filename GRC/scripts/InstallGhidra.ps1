# 安装 JDK...
Write-Host "`n[+] Installing OpenJDK..."

# 需要手动下载和安装JDK，或使用chocolatey等包管理器
choco install openjdk11

# 获取 Ghidra 文件...
Write-Host "`n[+] Getting Ghidra..."

# 获取最新版本的 Ghidra
#$LatestGhidraVersion = ((Invoke-WebRequest -Uri "https://github.com/NationalSecurityAgency/ghidra/releases/latest" -MaximumRedirection 0 -ErrorAction Ignore).Headers.Location -split "/")[-1]
#$LatestGhidra = (Invoke-WebRequest -Uri "https://github.com/NationalSecurityAgency/ghidra/releases/tag/Ghidra_11.0.3_build").Content -match 'ghidra_.*\.zip' | Select -First 1
$GhidraUrl = "https://github.com/NationalSecurityAgency/ghidra/releases/download/Ghidra_11.0.3_build/ghidra_11.0.3_PUBLIC_20240410.zip"

# 下载 Ghidra 压缩包到指定路径
$DownloadPath = "$Env:USERPROFILE\Downloads\ghidra.zip"
Invoke-WebRequest -Uri $GhidraUrl -OutFile $DownloadPath

# 解压 Ghidra
$ExtractPath = "$Env:USERPROFILE\Ghidra"
Expand-Archive -Path $DownloadPath -DestinationPath $ExtractPath
$FolderName = (Get-ChildItem -Path $ExtractPath | Select-Object -First 1).Name

# 更新图标图片...
Write-Host "`n[+] Getting the icon image..."
$IconUrl = "C:\Users\chenjie123456\Desktop\GH\GRC\Clipboard Image (2024-5-11 22.13).png"
$IconPath = "$Env:USERPROFILE\$FolderName\support\ghidra.png"
Invoke-WebRequest -Uri $IconUrl -OutFile $IconPath

# 创建桌面快捷方式
$ShortcutPath = "$Env:USERPROFILE\Desktop\Ghidra.lnk"
$WshShell = New-Object -ComObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut($ShortcutPath)
$Shortcut.TargetPath = "$Env:USERPROFILE\$FolderName\ghidraRun.bat" # 假设存在ghidraRun.bat启动脚本
$Shortcut.IconLocation = $IconPath
$Shortcut.Save()

# 清理下载的压缩文件
Remove-Item -Path $DownloadPath -Force

Write-Host "`n[+] Ghidra installation completed."
