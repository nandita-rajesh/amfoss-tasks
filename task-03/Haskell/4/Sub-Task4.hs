import System.IO
import Control.Monad (when)

generateDiamond :: Int -> String
generateDiamond n = unlines $ upperPart ++ lowerPart
  where
    upperPart = [ replicate (n - i - 1) ' ' ++ replicate (2 * i + 1) '*' | i <- [0..n-1] ]
    lowerPart = [ replicate (n - i - 1) ' ' ++ replicate (2 * i + 1) '*' | i <- reverse [0..n-2] ]

main :: IO ()
main = do
    content <- readFile "input.txt"
    let n = read (filter (/= ' ') content) :: Int

    let diamondPattern = generateDiamond n

    writeFile "output.txt" diamondPattern

    putStrLn "Pattern printed to output.txt"
