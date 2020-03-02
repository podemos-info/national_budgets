# frozen_string_literal: true

FactoryBot.define do
  factory :amendment do
    territory { create(%i[country community province].sample) }
    explanation { Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 4) }
    budget { create(:budget) }
    user
  end

  factory :standard_amendment, class: :"amendments/standard", parent: :amendment do
    trait :with_modifications do
      transient do
        modifications_count { 2 }
        section { create(:section, budget: budget) }
        program { create(:program, section: section) }
      end

      after(:create) do |amendment, evaluator|
        create_list(:addition_modification,
                    evaluator.modifications_count,
                    amendment: amendment,
                    section: evaluator.section,
                    program: evaluator.program,
                    &proc { amendment.reload })
        amendment.reload
      end
    end

    trait :completed do
      transient do
        section { create(:section, budget: budget) }
        program { create(:program, section: section) }
      end

      after(:create) do |amendment, evaluator|
        create(:addition_modification,
               amendment: amendment,
               section: evaluator.section,
               program: evaluator.program,
               amount: '1000',
               &proc { amendment.reload })
        create(:removal_modification,
               amendment: amendment,
               section: evaluator.section,
               program: evaluator.program,
               amount: '1000',
               &proc { amendment.reload })
      end
    end
  end

  factory :transfer_amendment, class: :"amendments/transfer", parent: :amendment do
    trait :with_modifications do
      transient do
        modifications_count { 2 }
        section { create(:section, budget: budget) }
        program { create(:program, section: section) }
      end

      after(:create) do |amendment, evaluator|
        create_list(:addition_modification,
                    evaluator.modifications_count,
                    amendment: amendment,
                    section: evaluator.section,
                    program: evaluator.program,
                    &proc { amendment.reload })
      end
    end

    trait :completed do
      transient do
        section { create(:section, budget: budget) }
        program { create(:program, section: section) }
      end

      after(:create) do |amendment, evaluator|
        create(:addition_modification,
               amendment: amendment,
               section: evaluator.section,
               program: evaluator.program,
               amount: '1000',
               &proc { amendment.reload })
        create(:removal_modification,
               amendment: amendment,
               section: evaluator.section,
               program: evaluator.program,
               amount: '1000',
               &proc { amendment.reload })
      end
    end
  end

  factory :addition_modification, class: :"modifications/addition", parent: :modification
  factory :removal_modification, class: :"modifications/removal", parent: :modification
  factory :organism_budget_income_modification, class: :"modifications/organism_budget_income", parent: :modification
  factory :organism_budget_expenditure_modification, class: :"modifications/organism_budget_expenditure", parent: :modification

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

  factory :articulated_amendment, class: :'amendments/articulated', parent: :amendment do
    trait :with_articulated do
      after(:create) do |amendment|
        create(:standard_articulated, amendment: amendment)
        amendment.reload
      end
    end
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
    factory "#{model_prefix}_articulated".to_sym, class: :"articulateds/#{model_prefix}", parent: :articulated
  end
end
