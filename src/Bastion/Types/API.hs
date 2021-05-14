-- | Shared types for the <https://developers.notion.com Notion API> wrapper
-- <github.com/dalpd/bastion Bastion>.
--
-- https://docs.servant.dev/en/stable/cookbook/structuring-apis/StructuringApis.html
module Bastion.Types.API
  (
  )
where

------------------------------------------------------------------------------

import Bastion.Utils
import Bastion.Types.Database
-- import Data.Text (Text)
-- import Data.Proxy
import Servant.API
-- import Servant.Client (ClientM, client)
import Data.UUID (UUID)

------------------------------------------------------------------------------

-- | Type representation for the <https://developers.notion.com Notion API>.
type NotionAPI = DatabaseAPI -- :> PageAPI :> BlockAPI :> UserAPI :> SearchAPI

type DatabaseAPI = "databases" :> RetrieveDatabase :<|> QueryDatabase :<|> ListDatabases

-- type PageAPI = "pages" :> RetrievePage :<|> CreatePage :<|> UpdatePageProperties
-- 
-- type BlockAPI = "blocks" :> RetrieveBlockChildren :<|> AppendBlockChildren
-- 
-- type UserAPI = "users" :> RetrieveUser :> ListAllUsers
-- 
-- type SearchAPI = "search" :> Search


type RetrieveDatabase =
  AuthorizationHeader :>
  VersionHeader :>
  DatabaseId :>
  GetJSONTyped Database

type QueryDatabase = AuthorizationHeader :> VersionHeader

type ListDatabases = AuthorizationHeader :> VersionHeader
