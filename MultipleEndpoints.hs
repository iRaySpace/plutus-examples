import qualified Data.Text as T
import Playground.Contract
import Plutus.Contract
import PlutusTx.Prelude

type EndpointSchema = 
    BlockchainActions 
        .\/ Endpoint "plus" ()
        .\/ Endpoint "minus" ()
 
plusEndpoint :: Contract () BlockchainActions T.Text ()
plusEndpoint = logInfo @String "Plus"

minusEndpoint :: Contract () BlockchainActions T.Text ()
minusEndpoint = logInfo @String "Minus"

contract :: Contract () EndpointSchema T.Text ()
contract = plus `select` minus
    where
        plus = endpoint @"plus" >> plusEndpoint
        minus = endpoint @"minus" >> minusEndpoint

endpoints :: Contract () EndpointSchema T.Text ()
endpoints = contract

mkSchemaDefinitions ''EndpointSchema

$(mkKnownCurrencies [])