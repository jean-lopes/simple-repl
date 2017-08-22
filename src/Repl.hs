-- | Simple REPL library core, defines the REPL data type.
--
-- Note: This module is not supposed to be imported!
--
-- Instead, import @Repl.String@ or @Repl.Text@
module Repl
    ( Repl(..)
    , runRepl
    ) where
import System.IO

-- | Contains the 'REP' operations of a REPL, and the loop breaking value.
data Repl a = Repl
    { replRead :: IO a -- ^ Command used to read the input from the terminal.
    , replEval :: a -> a -- ^ Evaluation function.
    , replPrint :: a -> IO () -- ^ Command used to print the result of evaluation.
    , replBreak :: a -- ^ Used to check if REPL should break the loop.
    }

-- | Starts the REPL
--
-- Note: Sets the buffering mode of @\<stdin\>@ and @\<stdout\>@ to @NoBuffering@. 
--
-- If you alter the buffering mode during execution via the 
-- 'replRead' or 'replPrint' functions, the REPL will not work properly.
runRepl :: Eq a => Repl a -> IO ()
runRepl repl = do    
    hSetBuffering stdin NoBuffering
    hSetBuffering stdout NoBuffering    
    runRepl'
  where
    runRepl' = do 
        line <- replRead repl
        let result = replEval repl line
        if replBreak repl == line 
            then return ()
            else replPrint repl result >> runRepl repl
