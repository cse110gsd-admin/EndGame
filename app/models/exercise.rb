class Exercise < ActiveRecord::Base
  belongs_to :exerciseable, :polymorphic => true
 # validates_presence_of :name
  #validates_presence_of :reps
  #validates :name => { :maximum => 20 }, :reps => { :maximum => 20 }

end
