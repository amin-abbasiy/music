class Tag < ApplicationRecord
  belongs_to :song
  scope :find_tags, -> (id_song) do
      where('song_id = ?', id_song)
  end
end
