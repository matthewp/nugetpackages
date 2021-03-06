try { 
  $nugetPath = $env:ChocolateyInstall
  $nugetExePath = Join-Path $nuGetPath 'bin'
  $packageBatchFileName = Join-Path $nugetExePath "lein.bat"

  $mydir = (Split-Path -parent $MyInvocation.MyCommand.Definition)
  $leinDir = ($mydir | Split-Path | Join-Path -ChildPath "bin")
  #$path = ($psakeDir | Split-Path | Join-Path -ChildPath  'lein.bat')
  $path = Join-Path $leinDir  'lein.bat'
  Write-Host "Adding $packageBatchFileName and pointing to $path"
  "@echo off
  ""$path"" %*" | Out-File $packageBatchFileName -encoding ASCII 
  
  lein self-install

  write-host "Leiningen is now ready. You can type 'lein' from any command line at any path. Get started by typing 'lein'"

  Write-ChocolateySuccess 'leiningen'
} catch {
  Write-ChocolateyFailure 'leiningen' "$($_.Exception.Message)"
  throw 
}
