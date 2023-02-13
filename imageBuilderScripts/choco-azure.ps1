If ((Get-ExecutionPolicy) -ne 'RemoteSigned') {Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Force}
Invoke-WebRequest https://chocolatey.org/install.ps1 -UseBasicParsing | Invoke-Expression
choco install 7zip -y
choco install adobereader -y
choco install azcopy10 -y
choco install azure-cli -y
choco install azure-iot-installer -y
choco install docker-desktop -y
choco install Firefox
choco install flux
choco install gh
choco install git
choco install github-desktop
choco install GoogleChrome
choco install jq
choco install kubernetes-cli -y
choco install kubernetes-helm -y
choco install paint.net
choco install pulumi -y
choco install pwsh -y
choco install servicebusexplorer -y
choco install terraform -y
choco install vscode -y
choco install git -y
