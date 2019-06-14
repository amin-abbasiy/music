class Song < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :tags
  has_many :liker, class_name: "Like", foreign_key: "user_id"
  has_many :like, through: :liker, source: :liked

  has_many :comments, dependent: :destroy
  default_scope -> {order(id: :desc)}
  mount_uploader :file, VoiceUploader
  mount_uploader :picture, PictureUploader
  validates(:user_id, presence: true)
  validates(:content, presence: true, length: {maximum: 200})
  # validates(:file, presence: true)
  validate(:song_size)
  def self.like?(song)
     like.include?(song)
  end
  def song_size
     if file.size > 10.megabyte then
        errors.add(:file, "File Cant Be More Than 10MB")
     end
  end
  def Song.search(string)
     if string then
        Song.where("content LIKE ? ", string) 
     end

  end
  def Song.like
    #  update_attribute(like: Song.like + 1)  
  end
  scope :find_query, -> (str) do
    where("(content LIKE ?) OR (file LIKE ?)", "%#{str}%", "%#{str}%")
  end

end
