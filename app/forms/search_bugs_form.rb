class SearchBugsForm
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
  attribute :quickness, :integer
  attribute :evil, :integer
  attribute :discomfort, :integer

  attr_accessor :search_word

  def search
    relation = Bug.distinct

    relation = relation.where('name LIKE ?', "%#{name}%")

    if search_word.present?
      search_words = search_word.split(/[[:blank:]]+/)
      search_words.inject(relation) do |result, word|
        relation = result.where('name LIKE ?', "%#{word}%").or(result.where('feature LIKE ?', "%#{word}%")).or(result.where('approach LIKE ?', "%#{word}%")).or(result.where('prevention LIKE ?', "%#{word}%")).or(result.where('harm LIKE ?', "%#{word}%"))
      end
    end

    relation = relation.where(size: size) if size.present?
    relation = relation.where(color: color) if color.present?
    relation = relation.where(season: season) if season.present?

    relation = relation.joins(:radar_chart).where(radar_chart: { capture: capture }) if capture.present?
    relation = relation.joins(:radar_chart).where(radar_chart: { breeding: breeding }) if breeding.present?
    relation = relation.joins(:radar_chart).where(radar_chart: { breeding: breeding }) if quickness.present?
    relation = relation.joins(:radar_chart).where(radar_chart: { evil: evil }) if evil.present?
    relation = relation.joins(:radar_chart).where(radar_chart: { discomfort: discomfort }) if discomfort.present?
    
    relation
  end

  private
end