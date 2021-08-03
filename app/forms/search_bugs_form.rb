class SearchBugsForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :size, :string
  attribute :color, :string
  attribute :season, :string
  attribute :capture, :string
  attribute :breeding, :string
  attribute :prevention_difficulty, :string
  attribute :injury, :string
  attribute :discomfort, :string

  attr_accessor :search_word

  def search
    relation = Bug.includes(image_attachment: :blob).distinct

    if search_word.present?
      search_words = search_word.split(/[[:blank:]]+/)
      search_words.inject(relation) do |result, word|
        relation = result.where('name LIKE ?', "%#{word}%")
                         .or(result.where('feature LIKE ?', "%#{word}%"))
                         .or(result.where('approach LIKE ?', "%#{word}%"))
                         .or(result.where('prevention LIKE ?', "%#{word}%"))
                         .or(result.where('harm LIKE ?', "%#{word}%"))
      end
    end

    relation = relation.where(size: size) if size.present?
    relation = relation.where(color: color) if color.present?
    relation = relation.where(season: season) if season.present?

    relation = search_chart(relation, capture, 'capture') if capture.present?
    relation = search_chart(relation, breeding, 'breeding') if breeding.present?
    relation = search_chart(relation, prevention_difficulty, 'prevention_difficulty') if prevention_difficulty.present?
    relation = search_chart(relation, injury, 'injury') if injury.present?
    relation = search_chart(relation, discomfort, 'discomfort') if discomfort.present?

    relation
  end

  private

  def search_chart(relation, value, column)
    case value
    when 'high'
      relation.high_chart(column)
    when 'normal'
      relation.normal_chart(column)
    when 'low'
      relation.low_chart(column)
    else
      relation
    end
  end
end
