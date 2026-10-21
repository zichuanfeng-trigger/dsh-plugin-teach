# 从 app.asar 中定向取出若干文件（只读研究用，不改动安装目录）
# asar 目录节点的形状：目录 { files: { name: node } }，文件 { offset, size, integrity }
#
# 用法:
#   pwsh -NoProfile -File .\scratch\asar-extract.ps1
#   pwsh -NoProfile -File .\scratch\asar-extract.ps1 -Asar 'D:\你的安装目录\resources\app.asar'
#
# 不传 -Asar 时按 DSH_EXE 环境变量推导，再回退到本机默认安装位置。
param(
  [string]$Asar,
  [string]$OutDir = (Join-Path $PSScriptRoot 'asar')
)

if ([string]::IsNullOrWhiteSpace($Asar)) {
  $exe = if ([string]::IsNullOrWhiteSpace($env:DSH_EXE)) {
    'N:\SoftApp\dsh\DSH NEXT\DSH NEXT.exe'
  } else {
    $env:DSH_EXE
  }
  $Asar = Join-Path (Split-Path -Parent $exe) 'resources\app.asar'
}

if (-not (Test-Path -LiteralPath $Asar)) {
  Write-Error "找不到 app.asar：$Asar`n请用 -Asar 参数指定，或设环境变量 DSH_EXE。"
  exit 1
}

$wanted = @(
  'node_modules/@deepseek-ai/dsh-client-ui-plugin-manager/README.zh.md',
  'node_modules/@deepseek-ai/dsh-client-ui-plugin-manager/locale/zh.json',
  'node_modules/@deepseek-ai/dsh-client-ui-plugin-manager/package.json',
  'node_modules/@deepseek-ai/dsh-client-ui-conversation/README.zh.md',
  'node_modules/@deepseek-ai/dsh-client-ui-slots/package.json',
  'node_modules/@deepseek-ai/dsh-client-runtime/README.zh.md',
  'node_modules/@deepseek-ai/dsh-web-app/package.json',
  'node_modules/@deepseek-ai/dsh-hmr/package.json',
  'package.json'
)

$fs = [System.IO.File]::OpenRead($Asar)
try {
  $br = New-Object System.IO.BinaryReader($fs)
  $null = $br.ReadUInt32(); $null = $br.ReadUInt32(); $null = $br.ReadUInt32()
  $jsonLen = $br.ReadUInt32()
  $json = [System.Text.Encoding]::UTF8.GetString($br.ReadBytes([int]$jsonLen))
  $headerEnd = 16 + $jsonLen
  $root = ($json | ConvertFrom-Json)

  New-Item -ItemType Directory -Force -Path $OutDir | Out-Null

  foreach ($p in $wanted) {
    $node = $root
    $ok = $true
    foreach ($seg in ($p -split '/')) {
      if ($null -eq $node.files) { $ok = $false; break }
      $prop = $node.files.PSObject.Properties[$seg]
      if ($null -eq $prop) { $ok = $false; break }
      $node = $prop.Value
    }
    if (-not $ok -or $null -eq $node.offset) { Write-Host "MISS  $p"; continue }

    $fs.Position = $headerEnd + [int64]$node.offset
    $bytes = $br.ReadBytes([int]$node.size)
    $out = Join-Path $OutDir ($p -replace '/', '__')
    [System.IO.File]::WriteAllBytes($out, $bytes)
    Write-Host "OK    $p  ($([int]$node.size) bytes)"
  }
}
finally { $fs.Dispose() }
