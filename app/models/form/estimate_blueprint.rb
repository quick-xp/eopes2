# == Schema Information
#
# Table name: estimate_blueprints
#
#  id          :integer          not null, primary key
#  type_id     :integer
#  me          :integer
#  te          :integer
#  runs        :integer
#  estimate_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Form::EstimateBlueprint < EstimateBlueprint
  REGISTRABLE_ATTRIBUTES = %i(id type_id me price te runs _destroy)

  belongs_to :estimate, class_name: 'Form::Estimate'

end
