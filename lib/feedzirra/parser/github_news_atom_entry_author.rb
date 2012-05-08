module Feedzirra
  module Parser
    class GithubNewsAtomEntryAuthor
      include SAXMachine
      include FeedUtilities
      element :name
      element :email
      element :uri
    end
  end
end
