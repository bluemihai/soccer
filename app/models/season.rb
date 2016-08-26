class Season < ApplicationRecord
  def full
    "#{id}-#{id + 1}"
  end

  def self.past_for_select
    order('id DESC').map{ |s| s.full}[1..-1]
  end
end
