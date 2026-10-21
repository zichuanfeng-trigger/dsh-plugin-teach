# 昼 · DSH CLI 垫片
# 这台机器没有把 dsh 装进 PATH，桌面版的 CLI 藏在 app.asar 里，
# 需要用 Electron 的「当作 Node 来跑」开关才能调用。
#
# 用法（在 teach 目录下）：
#   pwsh -NoProfile -File .\scratch\dsh.ps1 --version
#   pwsh -NoProfile -File .\scratch\dsh.ps1 --profile web --dump-config
#   pwsh -NoProfile -File .\scratch\dsh.ps1 --profile web --patch .\scratch\probe.patch.yml --dump-config

$ErrorActionPreference = 'Stop'

# 路径解析顺序：
#   一、环境变量 DSH_EXE 指向安装目录里的 exe
#   二、下面这一行写死的本机默认值
# 换机器时只改一处，或者设一个环境变量。
$exe = if ([string]::IsNullOrWhiteSpace($env:DSH_EXE)) {
  'N:\SoftApp\dsh\DSH NEXT\DSH NEXT.exe'
} else {
  $env:DSH_EXE
}

# CLI 入口固定在 asar 内的相对路径上，跟着 exe 所在目录走
$cli = Join-Path (Split-Path -Parent $exe) 'resources\app.asar\lib\desktop-cli.js'

# 注意：$cli 在 app.asar 内部，是 Electron 才能读的虚拟路径，
# PowerShell 的 Test-Path 看不到它（会返回 False），所以只校验 exe。
if (-not (Test-Path -LiteralPath $exe)) {
  Write-Error "找不到 DSH 可执行文件：$exe`n请设环境变量 DSH_EXE 指向你机器上的 'DSH NEXT.exe'。"
  exit 1
}

# 保存原值，跑完还原，避免污染当前 shell 会话
$previous = $env:ELECTRON_RUN_AS_NODE
$env:ELECTRON_RUN_AS_NODE = '1'
try {
  & $exe $cli @args
  exit $LASTEXITCODE
}
finally {
  if ($null -eq $previous) { Remove-Item Env:\ELECTRON_RUN_AS_NODE -ErrorAction SilentlyContinue }
  else { $env:ELECTRON_RUN_AS_NODE = $previous }
}
