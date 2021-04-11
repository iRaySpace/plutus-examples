import qualified Data.Text as T -- https://hackage.haskell.org/package/text-1.2.4.1/docs/Data-Text.html
import Playground.Contract
import Plutus.Contract
import PlutusTx.Prelude -- https://playground.plutus.iohkdev.io/tutorial/haddock/plutus-tx/html/Language-PlutusTx-Prelude.html

contract :: Contract () BlockchainActions T.Text ()
contract = logInfo @String "What's up, buddy?"

-- Expose contract
endpoints :: Contract () BlockchainActions T.Text ()
endpoints = contract

mkSchemaDefinitions ''BlockchainActions

currency :: KnownCurrency
currency = KnownCurrency (ValidatorHash "a") "ABC" (TokenName "I" :| [])

mkKnownCurrencies ['currency]
