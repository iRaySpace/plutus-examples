import qualified Data.Text as T
import Playground.Contract
import Plutus.Contract
import PlutusTx.Prelude

type EndpointSchema = 
    BlockchainActions 
        .\/ Endpoint "plus" ()
        .\/ Endpoint "minus" ()

-- @ called as `patterns`, handy way of breaking something up according to pattern
-- and binding it to names whilst still keeping a reference to the whole thing.
-- from `Learn you a Haskell`
plusEndpoint :: Contract () BlockchainActions T.Text ()
plusEndpoint = logInfo @String "Plus"

minusEndpoint :: Contract () BlockchainActions T.Text ()
minusEndpoint = logInfo @String "Minus"

-- (>>) sequentially compose two actions
-- putStr "Hello " >> putStrLn "World" is equivalent to
-- do putStr "Hello "
--    putStrLn "World"
contract :: Contract () EndpointSchema T.Text ()
contract = plus `select` minus
    where
        plus = endpoint @"plus" >> plusEndpoint
        minus = endpoint @"minus" >> minusEndpoint

endpoints :: Contract () EndpointSchema T.Text ()
endpoints = contract

mkSchemaDefinitions ''EndpointSchema

$(mkKnownCurrencies [])
