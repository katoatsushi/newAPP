class Event < ApplicationRecord
	mount_uploader :picture, PictureUploader
  mount_uploader :picture2, PictureUploader
	belongs_to :user
	has_many :clips
  # has_many :users, through: :clips
  has_many :users
  
  # has_many :customers, through: :clips
  #validate  :picture_size


  # 今日以降、X月X日以前のイベントをすべて取得する
  def self.fetch_events_from_today_until(datetime)
   Event.where("when BETWEEN ? AND ?", DateTime.now, datetime)
  end
  # 以内のイベント
  scope :in3days, -> from, to {
      if from.present? && to.present?
        where(when: from..to)
      elsif from.present?
        where('when >= ?', from)
      elsif to.present?
        where('when <= ?', to)
      end
  }

   private

    # アップロードされた画像のサイズをバリデーションする
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
end
