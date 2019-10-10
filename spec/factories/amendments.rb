# frozen_string_literal: true

FactoryBot.define do
  factory :amendment do
    number { Faker::Alphanumeric.alphanumeric(number: 10, min_alpha: 3) }
    explanation { Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 4) }
    budget
    user
  end

  factory :articulated_amendment, class: :'amendments/articulated_amendment', parent: :amendment do
    trait :with_articulated do
      after(:create) do |amendment|
        create(:standard_articulated, amendment: amendment)
      end
    end
  end

  factory :standard_amendment, class: :'amendments/standard_amendment', parent: :amendment do
    trait :with_modifications do
      transient do
        modifications_count { 1 }
      end

      after(:create) do |amendment, evaluator|
        create_list(:standard_modification, evaluator.modifications_count, amendment: amendment)
      end
    end
  end

  factory :transfer_amendment, class: :'amendments/transfer_amendment', parent: :amendment do
    trait :with_modifications do
      transient do
        modifications_count { 1 }
      end

      after(:create) do |amendment, evaluator|
        create_list(:transfer_modification, evaluator.modifications_count, amendment: amendment)
      end
    end
  end

  factory :articulated do
    title { Faker::Lorem.sentence(word_count: 5, supplemental: true, random_words_to_add: 15) }
    text { Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 4) }
    justification { Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 4) }
    number { Faker::Alphanumeric.alphanumeric(number: 10, min_alpha: 3) }
    section
  end

  factory :additional_articulated, class: :'articulateds/additional_articulated', parent: :articulated do
  end

  factory :final_articulated, class: :'articulateds/final_articulated', parent: :articulated do
  end

  factory :standard_articulated, class: :'articulateds/standard_articulated', parent: :articulated do
  end

  factory :modification do
    section
    service
    program
    chapter
    article
    concept
    subconcept
    project { '123' }
    project_new { [true, false].sample }
    amount { 1000 }
    amendment
  end

  factory :standard_modification, class: :'modifications/standard_modification', parent: :modification do
  end

  factory :transfer_modification, class: :'modifications/transfer_modification', parent: :modification do
  end
end
