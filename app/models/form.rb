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

class Form < ApplicationRecord

  extend FriendlyId
  friendly_id :name, use: :slugged

  has_attached_file :document
  validates_attachment :document, content_type: { content_type: "application/pdf" }
  validates_with AttachmentSizeValidator, attributes: :document, less_than: 2.megabytes

  validates_attachment_presence :document
  validates :name, presence: :true
  validates :address, :presence => :true
  validates :email, :presence => :true, uniqueness: true
  validates :dob, presence: :true
  validates :position, presence: :true
  validates :mobile_number, presence: :true, uniqueness: true
  validates :linkedin_url, presence: true, uniqueness: true

  def should_generate_new_friendly_id?
    name_changed?
  end

  filterrific(
      default_filter_params: { sorted_by: 'position_asc' },
      available_filters: [
          :sorted_by,
          :search_query,
      ]
  )

  scope :search_query, lambda { |query|
    # Searches the students table on the 'first_name' and 'last_name' columns.
    # Matches using LIKE, automatically appends '%' to each term.
    # LIKE is case INsensitive with MySQL, however it is case
    # sensitive with PostGreSQL. To make it work in both worlds,
    # we downcase everything.
    return nil  if query.blank?

    # condition query, parse into individual keywords
    terms = query.downcase.split(/\s+/)

    # replace "*" with "%" for wildcard searches,
    # append '%', remove duplicate '%'s
    terms = terms.map { |e|
      (e.gsub('*', '%') + '%').gsub(/%+/, '%')
    }
    # configure number of OR conditions for provision
    # of interpolation arguments. Adjust this if you
    # change the number of OR conditions.
    num_or_conds = 1
    where(
        terms.map { |term|
          "(LOWER(forms.position) LIKE ?)"
        }.join(' AND '),
        *terms.map { |e| [e] * num_or_conds }.flatten
    )
  }


  scope :sorted_by, lambda { |sort_key|
    direction = (sort_key =~ /desc$/) ? 'desc' : 'asc'
    case sort_key.to_s
      when /^position_/
        order("LOWER(forms.position) #{ direction }")
      when /^name_/
        order("LOWER(forms.name) #{ direction }")
      else
        raise(ArgumentError, "Invalid sort option: #{ sort_key.inspect }")
    end

  }

  def self.options_for_sorted_by
    [
        ['Name (a-z)', 'name_asc'],
        ['Position (a-z)', 'position_desc']
    ]
  end

end
