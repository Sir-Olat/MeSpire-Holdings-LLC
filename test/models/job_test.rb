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

require 'test_helper'

class JobTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
