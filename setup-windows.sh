- install chcocolatey

Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
set global var TERM=xterm-256color

- Chocolatey silent install mode

choco feature enable -n=allowGlobalConfirmation

choco install git openssh cmder firefox vscode neovim slack keepassxc screentogif greenshot filezilla


# from powershell
md ~\AppData\Local\nvim\autoload

$uri = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
(New-Object Net.WebClient).DownloadFile(
  $uri,
  $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath(
    "~\AppData\Local\nvim\autoload\plug.vim"
  )
)

# Games & game stores
# epic, path of exile, steam

#other apps
# fman spartan clipboard

# Firefox plugins
# ublock origin, reddit enhacement suite, hackernews enhancement suite

# additional config
# sign in to slack workspaces
git config --global user.name "benjmhart"
git config --global user.email "benjmhart@gmail.com"
git config --global core.editor nvim
git config --global --replace-all core.pager "less -F -X"