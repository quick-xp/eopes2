# == Schema Information
#
# Table name: user_skills
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  skill_id    :integer
#  skill_level :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class UserSkill < ActiveRecord::Base
end
