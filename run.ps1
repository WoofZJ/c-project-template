function Log {
    Param(
        [string]$str,
        [string]$color
    )
    $len = 0
    $lines = $str.split("\n")
    foreach ($line in $lines) {
        if ($line.Length -gt $len) {
            $len = $line.Length
        }
    }
    Write-Host ("-"*$len) -ForegroundColor $color
    foreach ($line in $lines) {
        Write-Host $line -ForegroundColor $color
    }
    Write-Host ("-"*$len) -ForegroundColor $color
}

function Info {
    Param([string]$str)
    Log $str green
}

function Error {
    Param([string]$str)
    Log $str red
}

cmake -B build
if ($?) {
    Info "solution added to ./build"
} else {
    Error "failed to generate ./build!"
    exit
}
$name = Split-Path -Path (Get-Location) -Leaf
$path = "./build/{0}.sln" -f $name
msbuild $path
if ($?) {
    Info "successfully generated executable"
} else {
    Error "failed to generate executable!"
    exit
}
if (-not (Test-Path -PathType Container "output")) {
  New-Item -ItemType Directory -Force -Path "output"
}
Copy-Item -Path ("build/Debug/{0}.exe" -f $name) -Destination ("output/{0}.exe" -f $name)
cd output
try {
    . ("./{0}.exe" -f $name)
} catch {
    Error $_
} finally {
    if ($?) {
        Info "successfully run!"
    } else {
        Error "crashed!"
    }
    cd ../
}