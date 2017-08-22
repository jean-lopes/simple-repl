-- | REPL using 'String'
module Repl.String
    ( module Repl
    , defaultRepl
    ) where
import Repl

-- | This is the default REPL, echoes all input. Use @:quit@ to break the loop.
defaultRepl :: Repl String
defaultRepl = Repl
    { replRead = putStr "REPL> " *> getLine 
    , replEval = id
    , replPrint = putStrLn
    , replBreak = ":quit"
    }