module Modules::ItemResource
  extend ActiveSupport::Concern
  
  RESOURCE_TYPE = {
    link: 'Link',
    document: 'Document'
  }

end