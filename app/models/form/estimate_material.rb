class Form::EstimateMaterial < EstimateMaterial
  REGISTRABLE_ATTRIBUTES = %i(id type_id require_count base_quantity price adjusted_price
                              total_price jita_total_price jita_average_price universe_total_price
                              universe_average_price volume total_volume _destroy)

  belongs_to :estimate, class_name: 'Form::Estimate'

end
