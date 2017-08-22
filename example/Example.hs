{-# LANGUAGE OverloadedStrings #-}
module Example
where
import           Repl.Text
import qualified Data.Text as Text
import qualified Data.Text.IO as Text

-- | Runs the default REPL, and than the a custom REPL
main :: IO ()
main = do
    putStrLn "Starting default REPL"
    runRepl defaultRepl

    putStrLn "Starting custom REPL"
    runRepl defaultRepl
        { replRead = Text.putStr ">>> " >> Text.getLine
        , replEval = Text.toUpper
        , replPrint = \xs -> Text.putStrLn $ Text.snoc xs '!'
        , replBreak = "BYE"
        }