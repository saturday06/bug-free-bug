$errorActionPreference = 'Stop'

$blender_zip_url = "https://download.blender.org/release/Blender2.93/blender-2.93.9-windows-x64.zip"
$blender_zip_sha256 = "C7B117464F203EE65025FCF1EEBB1D9566946CBE0100D54C693A42394A1C0DD4"
$airtest_zip_url = "https://airtestproject.s3.netease.com/downloads/AirtestIDE/win64/AirtestIDE-win-1.2.13.zip"
$airtest_zip_sha256 = "BD9C054AD282D9662EE995440B8E29E316EBBA50770DB695908B4D79A7EC2CC0"

function log($message) {
    Write-Output ("[" + (Get-Date -Format "yyyy-MM-dd HH:mm:ss") + "] $message")
}

function abort($message) {
    Write-Output ((Get-Date -Format "yyyy-MM-dd HH:mm:ss") + " $message")
}

function download_unpack($url, $sha256, $path) {
    $archive_name = ([uri]$url).Segments[-1]

    log "${url} をダウンロードしています"
    $archive_path = Join-Path $archive_dir $archive_name
    if (-not(Test-Path -Path $archive_path -PathType Leaf)) {
        $temp_path = (New-TemporaryFile).FullName
        Invoke-WebRequest -UseBasicParsing -Uri $url -OutFile $temp_path
        Copy-Item $temp_path -Destination $archive_path
    } else {
        log "Use download cache for ${url}"
    }

    log "check hash ${url}"
    $local_sha256 = (Get-FileHash -LiteralPath $archive_path -Algorithm SHA256).Hash
    if ($sha256 -ne $local_sha256) {
        abort "${archive_path} のSHA256ハッシュが一致しません。
            正しい値: ${sha256}
            実際の値: ${local_sha256}
        "
    }

    # アーカイブを展開
    log "unpacking"
    $unpack_ok_path = $path + ".unpack_ok.txt"
    if (-not(Test-Path -Path $path -PathType Container) -or 
        -not(Test-Path -Path $unpack_ok_path -PathType Leaf) -or
        (Get-Content -Path $unpack_ok_path) -ne $sha256
    ) {
        if (Test-Path -Path $path) {
            Remove-Item $path -Force -Recurse
        }
        $unpack_dir = $path + ".unpack"
        if (Test-Path -Path $unpack_dir) {
            Remove-Item $unpack_dir -Force -Recurse
        }
        Expand-Archive -LiteralPath $archive_path -DestinationPath $unpack_dir
        $file_name = ([io.path]::GetFileName($path)).ToString()
        $unpacked_main_dir = (Get-ChildItem $unpack_dir -Directory)[0].FullName
        if ($file_name -ne ([io.path]::GetFileName($unpacked_main_dir)).ToString()) {
            Rename-Item $unpacked_main_dir $file_name
        }
        Move-Item (Join-Path $unpack_dir ([io.path]::GetFileName($path)).ToString()) ([io.path]::GetDirectoryName($path)).ToString()
        Remove-Item $unpack_dir -Force -Recurse
        Set-Content $unpack_ok_path $sha256 -NoNewline
    } else {
        log "already unpacked"
    }

    log "ok"
}

log "start"

# サンドボックス作業用フォルダ。サンドボックス内で再利用できるように固定の場所。
$work_dir = [System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::Desktop)

log "work folder: $work_dir"

# ダウンロードアーカイブ用フォルダを作る。ホストマシンで再利用できるように固定の場所に作る。
$archive_dir = Join-Path $PSScriptRoot Archive
if (-not(Test-Path -Path $archive_dir -PathType Container)) {
    New-Item $archive_dir -itemType Directory
}

# vc redistributable
$vc_redist_x64_url = "https://aka.ms/vs/17/release/vc_redist.x64.exe"
$vc_redist_x64_path = $archive_dir = Join-Path (Join-Path $PSScriptRoot Archive) ([uri]$vc_redist_x64_url).Segments[-1]
log "$vc_redist_x64_url をダウンロードしています"
if (-not(Test-Path -Path $vc_redist_x64_path -PathType Leaf)) {
    Invoke-WebRequest -UseBasicParsing -Uri $vc_redist_x64_url -OutFile $vc_redist_x64_path
} else {
    log "Use download cache for ${url}"
}
& $vc_redist_x64_path /install /quiet

$blender_dir = Join-Path $work_dir Blender
$airtest_dir = Join-Path -Path $work_dir -ChildPath AirtestIDE

log "blender $blender_dir"
log "airtest $airtest_dir"

download_unpack $blender_zip_url $blender_zip_sha256 $blender_dir
download_unpack $airtest_zip_url $airtest_zip_sha256 $airtest_dir

log "complete"
