{-# LANGUAGE OverloadedStrings #-}
-- | Simple REPL library.
module Repl
    ( Repl(..)
    , defaultRepl
    , runRepl
    ) where
import           Data.Text (Text)
import qualified Data.Text as Text
import qualified Data.Text.IO as Text

-- | Representation of a REPL.
data Repl = Repl
    { replRead :: IO Text -- ^ Command used to read the input from the terminal.
    , replEval :: Text -> Text -- ^ Evaluation function.
    , replPrint :: Text -> IO () -- ^ Command used to print the result of evaluation.
    , replBreak :: Text -- ^ Used to check if REPL should break the loop.
    }

-- | This is the default REPL, echoes all input. Use @:quit@ to break the loop.
defaultRepl :: Repl
defaultRepl = Repl
    { replRead = Text.putStr "REPL> " *> Text.getLine 
    , replEval = id
    , replPrint = Text.putStrLn
    , replBreak = ":quit"
    }

-- | Checks if the command is equal to the REPL loop breaking text.
isQuitCommand :: Repl -> Text -> Bool
isQuitCommand (Repl _ _ _ xs) ys = normalize xs == normalize ys
  where
    normalize = Text.toLower . Text.strip

-- | Starts the REPL.
runRepl :: Repl -> IO ()
runRepl repl = do    
    line <- replRead repl
    let result = replEval repl line
    if isQuitCommand repl line 
        then Text.putStrLn ""
        else replPrint repl result >> runRepl repl