# Echo.hs

**TCP echo server written in Haskell.**

## Using Telnet

Telnet is an application for communincating with TCP.
To start a connection with telnet the hostname and portnumber of a TCP server is required.
Connections are opened by executing the following command.

```
$ telnet hostname portnumber
```

When running the echo server use hostname:`localhost` and portnumber:`4242`

To force close on a telnet session.

1. Open the telnet prompt by holding down the ‘Ctrl’ key and push the ‘]’ key. (prompt: Microsoft Telnet>)
2. Type quit.
3. Push the ‘Enter’ key.

## Program notes
### Use a handle not a connection

> Network.Socket incorrectly represent binary data in send and recv and, as a result, use of these functions is not advised and may lead to bugs. Network.Socket actually recommends using these same methods defined in the ByteString module. However, to keep things simple, we'll stick to System.IO for input and output. Importing our new module and turning our Socket into a Handle now looks like the following:

Not sure the details of this but it is the reason to import `System.IO`.

### Lifting to a monad.

I have no idea what the difference between these two lines are.
```hs
name <- liftM init (hGetLine hdl)
-- OR
name <- hGetLine hdl
```
