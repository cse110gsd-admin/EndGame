class Workout < ActiveRecord::Base
  has_many   :exercises, :as => :exerciseable, :dependent => :destroy
  accepts_nested_attributes_for :exercises
  belongs_to :event
end
