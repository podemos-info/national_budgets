class Modification < ApplicationRecord
  belongs_to :amendment
  belongs_to :section
  belongs_to :service
  belongs_to :program
  belongs_to :chapter
  belongs_to :article
  belongs_to :concept, optional: true
  belongs_to :subconcept, optional: true
end