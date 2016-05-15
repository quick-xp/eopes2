class Form::EstimateBlueprint < EstimateBlueprint
  REGISTRABLE_ATTRIBUTES = %i(id type_id me price te runs _destroy)

  belongs_to :estimate, class_name: 'Form::Estimate'

end