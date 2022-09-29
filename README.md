# Deploy helper

Small helper container with some tools to connect somewhere and make actions.

Contains:
- ssh
- rsync
- ftp client

Since the file transfer may be interrupted, if you have many or large files, it is recommended that you first upload them to a temporary directory, and then locally synchronize between directories or simply update the directory names.

## SSH
Variables
- SSH_PRIVATE_KEY
- TARGET_SERVER_ADDRESS
- TARGET_SERVER_PORT
- TARGET_SERVER_USERNAME


Run ssh-agent
```bash
eval $(ssh-agent -s)
```

Add our private key
```bash
echo "$SSH_PRIVATE_KEY" | tr -d '\r' | ssh-add -
```

Connect to the server and execute command
```bash
ssh -p$TARGET_SERVER_PORT $TARGET_SERVER_USERNAME@$TARGET_SERVER_ADDRESS 'cd /app && ls -1'
```

## RSYNC
Variables
- SSH_PRIVATE_KEY
- TARGET_SERVER_ADDRESS
- TARGET_SERVER_PORT
- TARGET_SERVER_USERNAME
- TARGET_SERVER_PATH
- TARGET_LOCAL_PATH

Add our private key
```bash
echo "$SSH_PRIVATE_KEY" | tr -d '\r' | ssh-add -
```

Sync files from TARGET_LOCAL_PATH to TARGET_SERVER_PATH If path doesn't exist, it will be created.
```bash
rsync -p$TARGET_SERVER_PORT -avP --delete $TARGET_LOCAL_PATH $TARGET_SERVER_USERNAME@$TARGET_SERVER_ADDRESS:$TARGET_SERVER_PATH
```


## FTP
Variables
- SSH_PRIVATE_KEY
- TARGET_SERVER_ADDRESS
- TARGET_SERVER_PORT
- TARGET_SERVER_USERNAME
- TARGET_SERVER_PATH

Copy local directory to server
```bash
lftp -c "open ftp://TARGET_SERVER_USERNAME:TARGET_SERVER_PASSWORD@TARGET_SERVER_ADDRESS; mirror --reverse --parallel=5 /local-dir /remote-dir"
```

Rename directory
```bash
lftp -c "open ftp://TARGET_SERVER_USERNAME:TARGET_SERVER_PASSWORD@TARGET_SERVER_ADDRESS; mv /old-dir /new-dir"
```