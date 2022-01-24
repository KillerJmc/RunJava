﻿# RunJava
# Arthur: Jmc
# Date: 2022.1.24

# 如果找不到JAVA_HOME就报错
if ($env:JAVA_HOME.Length -eq 0)
{
    Write-Error "找不到JAVA_HOME！"
    pause; return
}

# 参数只能有一个
if ($args.Length -eq 0)
{
    Write-Warning "请输入要执行的文件，只能是单个java文件或者jar文件。"
    pause; return
} 
elseif ($args.Length -gt 1)
{
    Write-Error "参数个数大于1！"
    pause; return
}

# 文件路径
$filePath = $args[0].ToString()

# 检查路径是否存在
if (-not (Test-Path $filePath))
{
    Write-Error "路径不存在！"
    pause; return
}

# 按情况执行
if ($filePath.EndsWith('.jar'))
{
    java -jar $filePath
}
elseif ($filePath.EndsWith('.java'))
{
    # 临时Java文件路径
    $tmpJavaPath = [System.IO.Path]::GetTempPath() + 'Temp.java'

    # 转化源码的编码为系统编码并输出到临时Java文件来解决编码问题
    cat -Encoding UTF8 $filePath | Out-File -Encoding default $tmpJavaPath

    # 执行临时Java文件
    java $tmpJavaPath

    # 清除临时Java文件
    rm $tmpJavaPath
}
else
{
    Write-Error "文件格式错误，仅支持java文件或jar文件！"
    pause; return
}

# 退出信息
Write-Host -NoNewline "`n进程已退出，按任意键关闭此窗口. . ."
cmd /c "pause > nul"

