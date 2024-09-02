import Control.Monad (forM_)

main :: IO ()
main = do
    putStrLn "Enter a number:"
    input <- getLine
    let n = read input :: Int
    printDiamond n

printDiamond :: Int -> IO ()
printDiamond n = do
    forM_ [0..(n-1)] $ \i -> do
        putStr (replicate (n - i - 1) ' ')
        putStr (replicate (2 * i + 1) '*')
        putStrLn ""
    
    forM_ [(n-2),(n-3)..0] $ \i -> do
        putStr (replicate (n - i - 1) ' ')
        putStr (replicate (2 * i + 1) '*')
        putStrLn ""
