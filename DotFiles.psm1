# utilities for dotfile deployment on Windows 7+
function Add-Symlink {
  $DestPath = $args[0]
  $SrcPath  = $args[1]

  if (Test-Path $DestPath) {
    Write-Warning "$DestPath is already symlinked!!!"
  } else {
    if ((Get-Item $SrcPath) -is [System.IO.DirectoryInfo]) {
      # src is a directory
      cmd /c mklink /D "$DestPath" "$SrcPath"
    } else {
      # src is a file
      cmd /c mklink "$DestPath" "$SrcPath"
    }

    echo "$DestPath has been symlinked"
  }
}

function Remove-Symlink {
  $DestPath = $args[0]
  $SrcPath  = $args[1]

  if (Test-Path $DestPath) {
    if ((Get-Item $SrcPath) -is [System.IO.DirectoryInfo]) {
      cmd /c rmdir "$DestPath"
    } else {
      cmd /c del "$DestPath"
    }
  } else {
    Write-Warning "$DestPath doesn't exist"
  }
}

function Install-Manifest {
  $ManifestFile = $args[0]

  echo "Deploying $ManifestFile..."

  $Manifest = Import-Csv -Header ("package", "file") -Delimiter ("|") -Path "$ManifestFile"

  foreach ($ManifestRow in $Manifest) {
    $DeployFile = $ManifestRow.file
    $Package = $ManifestRow.package
    $SourcePath = "$PSScriptRoot\$Package\$DeployFile"
    $DestPath = "$env:HOME\$DeployFile"

    Add-Symlink $DestPath $SourcePath
  }
}

function Uninstall-Manifest {
    $ManifestFile = $args[0]

    echo "Undeploying $ManifestFile..."

    $Manifest = Import-Csv -Header ("package", "file") -Delimiter ("|") -Path "$ManifestFile"

    foreach ($ManifestRow in $Manifest) {
      $DeployedFile = $ManifestRow.file
      $Package = $ManifestRow.package
      $SourcePath = "$PSScriptRoot\$Package\$DeployedFile"
      $DestPath = "$env:HOME\$DeployedFile"

      Remove-Symlink $DestPath $SourcePath
    }
}
