class BugRadarChartForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :name, :string
  attribute :feature, :string
  attribute :approach, :string
  attribute :prevention, :string
  attribute :harm, :string
  attribute :size, :string
  attribute :color, :string
  attribute :season, :string
  attribute :capture, :integer
  attribute :breeding, :integer
  attribute :prevention_difficulty, :integer
  attribute :injury, :integer
  attribute :discomfort, :integer
  attribute :user_id, :integer

  attr_accessor :image

  def save!
    ActiveRecord::Base.transaction do
      bug = Bug.new(name: name, feature: feature, approach: approach, 
                     prevention: prevention, harm: harm, size: size, 
                     color: color, season: season, user_id: user_id, image: image)
      bug.save!

      radar_chart = bug.build_radar_chart(capture: capture, breeding: breeding, 
                                          prevention_difficulty: prevention_difficulty, 
                                          injury: injury, discomfort: discomfort)
      radar_chart.save!
    end
  end
end