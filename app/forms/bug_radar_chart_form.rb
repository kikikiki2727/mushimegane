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

  def create!
    ActiveRecord::Base.transaction do
      bug = Bug.create!(name: name, feature: feature, approach: approach, 
                     prevention: prevention, harm: harm, size: size, 
                     color: color, season: season, user_id: user_id, image: image)

      radar_chart = bug.create_radar_chart!(capture: capture, breeding: breeding, 
                                          prevention_difficulty: prevention_difficulty, 
                                          injury: injury, discomfort: discomfort)
    end
  end

  def update!(bug, radar_chart)
    ActiveRecord::Base.transaction do
      bug.update!(name: name, feature: feature, approach: approach, 
                             prevention: prevention, harm: harm, size: size, 
                             color: color, season: season, user_id: user_id)

      radar_chart.update!(capture: capture, breeding: breeding, 
                                     prevention_difficulty: prevention_difficulty, 
                                     injury: injury, discomfort: discomfort)
                                     
      bug.image.attach(image) if image.present?
    end
  end
end