class Chat < ApplicationRecord
	has_many :message
	validates :appToken, :presence => true
end
