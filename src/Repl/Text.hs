{-# LANGUAGE OverloadedStrings #-}
-- | REPL using 'Text'
module Repl.Text
    ( module Repl
    , defaultRepl
    ) where
import           Data.Text (Text)
import qualified Data.Text.IO as Text
import           Repl

-- | This is the default REPL, echoes all input. Use @:quit@ to break the loop.
defaultRepl :: Repl Text
defaultRepl = Repl
    { replRead = Text.putStr "REPL> " *> Text.getLine 
    , replEval = id
    , replPrint = Text.putStrLn
    , replBreak = ":quit"
    }