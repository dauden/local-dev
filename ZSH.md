# Create your custom zsh function

How to define and load your own shell function in zsh

## Add custom function to your zsh

```shell
$ cd ./zsh_function/init
$ sh init.sh 'your_local_path'
# example: /Volumes/Working/local-dev/src/zsh_functions
```

### openssl-encrypt function
this function help to encrypt your file/folder with your encrypted key
```shell
$ openssl-encrypt your_file_path your_file_path_encrypted
# example: openssl-encrypt text.txt text.txt.encrypted
```


### openssl-decrypt function
this function help to decrypt your file/folder with your decrypted key
```shell
$ openssl-decryp your_file_path your_file_path_decrypted
# example: openssl-decrypt text.txt.encrypted text.txt
```

## Create new function

Create your function then save file in `src/zsh_functions` with name is the same with your function name.

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
