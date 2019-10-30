# frozen_string_literal: true

FactoryBot.define do
  factory :amendment do
    number { Faker::Alphanumeric.alphanumeric(number: 10, min_alpha: 3) }
    explanation { Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 4) }
    budget { create(:budget) }
    user
  end

  factory :articulated_amendment, class: :'amendments/articulated_amendment', parent: :amendment do
    trait :with_articulated do
      after(:create) do |amendment|
        create(:standard_articulated, amendment: amendment)
        amendment.reload
      end
    end
  end

  %w[standard transfer].each do |model_prefix|
    factory "#{model_prefix}_amendment".to_sym, class: :"amendments/#{model_prefix}_amendment", parent: :amendment do
      trait :with_modifications do
        transient do
          modifications_count { 2 }
          section { create(:section, budget: budget) }
        end

        after(:create) do |amendment, evaluator|
          create_list("#{model_prefix}_modification".to_sym,
                      evaluator.modifications_count,
                      amendment: amendment,
                      section: evaluator.section)
        end
      end

      trait :completed do
        transient do
          section { create(:section, budget: budget) }
        end

        after(:create) do |amendment, evaluator|
          create("#{model_prefix}_modification".to_sym,
                 amendment: amendment, section: evaluator.section, abs_amount: '1000', amount_sign: '+')
          create("#{model_prefix}_modification".to_sym,
                 amendment: amendment, section: evaluator.section, abs_amount: '1000', amount_sign: '-')
        end
      end
    end

    factory "#{model_prefix}_modification".to_sym, class: :"modifications/#{model_prefix}_modification", parent: :modification
  end

  factory :articulated do
    amendment
    title { Faker::Lorem.sentence(word_count: 5, supplemental: true, random_words_to_add: 15) }
    text { Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 4) }
    justification { Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 4) }
    number { Faker::Alphanumeric.alphanumeric(number: 10, min_alpha: 3) }
    section { amendment&.section || create(:section, budget: amendment&.budget || create(:budget)) }
  end

  %w[additional final standard].each do |model_prefix|
    factory "#{model_prefix}_articulated".to_sym, class: :"articulateds/#{model_prefix}_articulated", parent: :articulated
  end

  factory :modification do
    amendment { create(:standard_amendment) }
    section { amendment&.section || create(:section, budget: amendment&.budget || create(:budget)) }
    service { create(:service, section: section) }
    program { create(:program, section: section) }
    chapter { create(:chapter, budget: amendment&.budget || create(:budget)) }
    article { create(:article, chapter: chapter) }
    concept { create(:concept, article: article) }
    subconcept { create(:subconcept, concept: concept) }
    project { '123' }
    project_new { [true, false].sample }
    amount { 1 }
  end
end
