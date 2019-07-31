- install chcocolatey

Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

- Chocolatey silent install mode

choco feature enable -n=allowGlobalConfirmation

choco install git openssh cmder firefox vscode nvim slack keepassxc screentogif greenshot