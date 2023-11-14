## What is NVM?

Node Version Manager (NVM), as the name implies, is a tool for managing Node versions on your device.

## How to Install NVM on MACOS

1. Install from nvm installer script
   In your terminal, run the nvm installer like this:
```shell
$curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
```
2. Export profile configuration
  add text below to end of file
   ``~/.zshrc`` or ``~/.bash_profile``
```shell
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
```
3. Reload configs
```shell
$ source ~/.zshrc
# or
$ source ~/.bashrc
```
test version
```shell
$ nvm -v
```
out put 
```shell
 $ 0.39.5
```
Enjoy your code...
