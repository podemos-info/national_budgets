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
        create :standard_articulated, amendment: amendment
      end
    end
  end

  %w[standard transfer].each do |model_prefix|
    factory "#{model_prefix}_amendment".to_sym, class: :"amendments/#{model_prefix}_amendment", parent: :amendment do
      trait :with_modifications do
        transient do
          modifications_count { 2 }
          section { create(:section) }
        end

        after(:create) do |amendment, evaluator|
          create_list("#{model_prefix}_modification".to_sym,
                      evaluator.modifications_count,
                      amendment: amendment, section: evaluator.section)
        end
      end

      trait :completed do
        transient do
          modifications_count { 1 }
          section { create(:section) }
        end

        after(:create) do |amendment, evaluator|
          create_list("#{model_prefix}_modification".to_sym,
                      evaluator.modifications_count,
                      amendment: amendment, section: evaluator.section, abs_amount: '1000', amount_sign: '+')
          create_list("#{model_prefix}_modification".to_sym,
                      evaluator.modifications_count,
                      amendment: amendment, section: evaluator.section, abs_amount: '1000', amount_sign: '-')
        end
      end
    end

    factory "#{model_prefix}_modification".to_sym, class: :"modifications/#{model_prefix}_modification", parent: :modification do
    end
  end

  factory :articulated do
    title { Faker::Lorem.sentence(word_count: 5, supplemental: true, random_words_to_add: 15) }
    text { Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 4) }
    justification { Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 4) }
    number { Faker::Alphanumeric.alphanumeric(number: 10, min_alpha: 3) }
    section
  end

  %w[additional final standard].each do |model_prefix|
    factory "#{model_prefix}_articulated".to_sym, class: :"articulateds/#{model_prefix}_articulated", parent: :articulated do
    end
  end

  factory :modification do
    section { amendment&.section || create(:section) }
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
end
