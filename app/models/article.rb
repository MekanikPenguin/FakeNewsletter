class Article < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  validates :pertinence, inclusion: { in: %w[forte moyenne faible] }, allow_nil: true
  validates :category, inclusion: { in: %w[Études\ et\ chiffres Propagande Nos\ complotistes\ ont\ du\ talent Outils Médias Réformes\ et\ institutions Podcasts Fact-Checking Dérives\ sectaires QAnon Intelligence\ artificielle Réseaux\ sociaux Autres] }, allow_nil: true
end
