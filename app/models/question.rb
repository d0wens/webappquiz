# == Schema Information
#
# Table name: questions
#
#  id                  :integer(4)      not null, primary key
#  survey_id           :integer(4)
#  content             :text
#  created_at          :datetime        not null
#  updated_at          :datetime        not null
#  anonymous           :boolean(1)      default(FALSE)
#  allow_free_response :boolean(1)      default(FALSE)
#

class Question < ActiveRecord::Base
  attr_accessible :points, :content, :anonymous, :allow_free_response, :survey_id, :points, :id, :created_at, :updated_at

  belongs_to :surveys
  has_many :answers, :dependent => :destroy

  #SPEC: 5.3.1.1: Content
  accepts_nested_attributes_for :answers,
        :reject_if => lambda { |a| a[:content].blank? },
        :allow_destroy => true

  validates_presence_of :answers
  validates_presence_of :content

  scope :by_survey, lambda { |survey| where("survey_id = ?", survey) }
  scope :anonymous, where(:anonymous => true)
  scope :not_anonymous, where(:anonymous => false)

  def my_questions
    Question.by_survey(self.survey_id).map(&:id)
  end
end
