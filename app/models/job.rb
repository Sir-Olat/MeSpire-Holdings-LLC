# == Schema Information
#
# Table name: jobs
#
#  id           :integer          not null, primary key
#  title        :string
#  description  :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  slug         :string
#  location     :string
#  job_type     :string
#  salary       :integer
#  salary_range :string
#  admin_id     :integer
#  published    :boolean          default(FALSE)
#  published_at :datetime
#

class Job < ApplicationRecord

  belongs_to :admin


  extend FriendlyId
  friendly_id :title, use: :slugged

  scope :most_recent, -> { order(created_at: :desc) }
  scope :most_recent_published, -> { order(published_at: :desc) }
  scope :published, -> { where( published: true) }

  validates :title, presence: :true
  validates :description, presence: :true

  def should_generate_new_friendly_id?
    title_changed?
  end

  def display_day_published
    if published_at.present?
      "Published #{published_at.strftime('%-b %-d,%Y')}"
    else
      'Not Published Yet'
    end
  end

  def publish
    update(published: true, published_at: Time.now)
  end

  def unpublish
    update(published: false, published_at: nil)
  end

end
