# rails runner "Jobs::IndustrySystemCrawler.new.run"
class Jobs::IndustrySystemCrawler
  def run
    client = CrestClient.new("")
    items = client.get_industry_system.items

    cost_results = []
    items.each do |item|
      solar_system_id = item.solarSystem.id
      item.systemCostIndices.each do |c|
        r = IndustrySystem.new
        r.solar_system_id = solar_system_id
        r.cost_index = c['costIndex']
        r.activity_id = c['activityID']
        cost_results << r
      end
    end
    IndustrySystem.delete_all
    IndustrySystem.import cost_results
  end
end
