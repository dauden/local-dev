# Create your custom zsh function

How to define and load your own shell function in zsh

## Add custom function to your zsh

```shell
$ cd ./src/zshc
$ sh init.sh 'your_local_path'
# example: /Volumes/Working/local-dev/src/zshc
```

### encrypt function
this function help to encrypt your file/folder with your encrypted key
```shell
$ encrypt your_file_path your_file_path_encrypted
# example: encrypt text.txt text.txt.encrypted
```


### decrypt function
this function help to decrypt your file/folder with your decrypted key
```shell
$ decryp your_file_path your_file_path_decrypted
# example: decrypt text.txt.encrypted text.txt
```

## Create your new function

Create your function then save file in `src/zshc` with name is the same with your function name.

example:
create file called `hello` with content below:

```shell
hello () {
 echo "Hello zsh_function";
}

hello
```

then open you terminal

```shell
$ hello #print out "hello zsh_function"
```
