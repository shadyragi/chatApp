require 'elasticsearch/model'

class Message < ApplicationRecord
  belongs_to :chat
  validates :content, :presence => true


  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  index_name Rails.application.class.parent_name.underscore

  settings index: { :number_of_shards => 1  } do

    mapping dynamic: false do
      indexes :chat_id, analyzer: 'not_analyzed'
      indexes :content, analyzer: 'english'
    end
  end


  def self.search(chat_id, query)
    query_terms_count = query.split.length()

    __elasticsearch__.search(
    min_score: query_terms_count == 1 ? 1.0 : 2.0,
    query: { 
      bool: { 
        must: {
          query_string: {
            query: "*#{query}*",
            fields: ['content'],
          }
        },
        filter: {
          term: {
            "chat_id" => chat_id
          }
        }
      },
    }).records.to_json(except: [:id, :chat_id])
  end
end
