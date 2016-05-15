class Form::EstimateJobCost < EstimateJobCost
  REGISTRABLE_ATTRIBUTES = %i(id region_id solar_system_id system_cost_index base_job_cost
                              job_fee facility_cost total_job_cost _destroy)


end
