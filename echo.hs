module Main where

import Network.Socket
import System.IO
import Control.Monad (liftM, when)

main :: IO ()
main = do
  sock <- socket AF_INET Stream 0    -- create socket
  setSocketOption sock ReuseAddr 1   -- make socket immediately reusable - eases debugging.
  bind sock (SockAddrInet 4242 iNADDR_ANY)   -- listen on TCP port 4242.
  listen sock 2                              -- set a max of 2 queued connections
  mainLoop sock                              -- unimplemented

mainLoop :: Socket -> IO ()
mainLoop sock = do
  conn <- accept sock     -- accept a connection and handle it
  runConn conn            -- run our server's logic
  mainLoop sock           -- repeat

runConn :: (Socket, SockAddr) -> IO ()
runConn (sock, addr) = do
  handle <- socketToHandle sock ReadWriteMode
  hSetBuffering handle NoBuffering
  echoMessage handle "Hello!"
  hClose handle

echoMessage :: Handle -> [Char] -> IO ()
echoMessage handle "CLOSE" = do
  putStrLn "CLOSING"
echoMessage handle message = do
  hPutStrLn handle message
  echo <- liftM init (hGetLine handle)
  echoMessage handle echo
