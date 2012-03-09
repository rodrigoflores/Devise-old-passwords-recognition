class Password < ActiveRecord::Base
  belongs_to :user

  scope :current, where(:changed_at => nil)
end