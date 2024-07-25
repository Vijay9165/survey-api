class Survey < ApplicationRecord
	validates :name, presence: true
	has_many :survey_questions, dependent: :destroy
end
