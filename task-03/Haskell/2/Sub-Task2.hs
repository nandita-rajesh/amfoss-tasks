import System.IO

readAndWriteFile :: FilePath -> FilePath -> IO ()
readAndWriteFile inputFile outputFile = do
    inputHandle <- openFile inputFile ReadMode
    content <- hGetContents inputHandle
    outputHandle <- openFile outputFile WriteMode
    hPutStr outputHandle content
    hClose inputHandle
    hClose outputHandle
    putStrLn $ "Content successfully copied from " ++ inputFile ++ " to " ++ outputFile ++ "."

main :: IO ()
main = readAndWriteFile "input.txt" "output.txt"
