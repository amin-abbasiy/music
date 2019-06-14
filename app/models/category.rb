class Category < ApplicationRecord
     has_many :songs
     has_many :usercats
end
