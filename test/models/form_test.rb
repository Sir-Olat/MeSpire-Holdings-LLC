# == Schema Information
#
# Table name: forms
#
#  id                    :integer          not null, primary key
#  name                  :string
#  address               :string
#  email                 :string
#  dob                   :datetime
#  reference             :string
#  position              :string
#  mobile_number         :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  document_file_name    :string
#  document_content_type :string
#  document_file_size    :integer
#  document_updated_at   :datetime
#  linkedin_url          :string
#  slug                  :string
#

require 'test_helper'

class FormTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
