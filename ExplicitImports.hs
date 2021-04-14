import Data.Text (Text)
import Text.Printf (printf)

import PlutusTx (Data)
import PlutusTx.Prelude (Integer, (>>=), String, ($))
import Plutus.Contract (type (.\/), Endpoint, Contract, select, endpoint, (>>), logInfo)

import Playground.Contract (printSchemas, ensureKnownCurrencies, IO, BlockchainActions, printJson, stage)
import Playground.TH (mkSchemaDefinitions)
import Playground.Types (KnownCurrency)

type GiftSchema =
    BlockchainActions
        .\/ Endpoint "give" Integer
        .\/ Endpoint "grab" ()

give amount = do
    logInfo @String $ printf "made a gift of %d lovelace" amount

grab = do
    logInfo @String $ "collected gifts"

-- (>>) / (>>=) are functions from Monad class
-- Check: https://www.youtube.com/watch?v=xCut-QT2cpI
endpoints :: Contract () GiftSchema Text ()
endpoints = (give' `select` grab') >> endpoints
    where
        give' = endpoint @"give" >>= give
        grab' = endpoint @"grab" >> grab

mkSchemaDefinitions ''GiftSchema
