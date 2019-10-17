# frozen_string_literal: true

FactoryBot.define do
  factory :budget do
    title { Faker::Lorem.sentences(number: 1) }
    date { Faker::Date.between_except(from: 1.year.ago, to: 1.year.from_now, excepted: Time.zone.today) }
    user
  end

  %i[section chapter].each do |model|
    factory model do
      ref { Faker::Alphanumeric.alphanumeric(number: 2) }
      title { Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 4) }
      budget

      unless model == :subconcept
        trait :with_childs do
          transient do
            child_count { 5 }
            child_models do
              { section: %i[service program],
                chapter: %i[article] }
            end
          end

          after(:create) do |parent, evaluator|
            evaluator.child_models[model].each do |child_model|
              create_list(child_model, evaluator.child_count, model => parent)
            end
          end
        end
      end
    end
  end

  factory :service do
    ref { Faker::Alphanumeric.alphanumeric(number: 2) }
    title { Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 4) }
    section
  end

  factory :program do
    ref { Faker::Alphanumeric.alphanumeric(number: 2) }
    title { Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 4) }
    section
  end

  factory :article do
    ref { Faker::Alphanumeric.alphanumeric(number: 2) }
    title { Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 4) }
    chapter

    trait :with_concepts do
      transient do 
        concepts_count { 5 }
      end

      after(:create) do |article, evaluator|
        create_list(:concept, evaluator.concepts_count, article: article)
      end
    end
  end

  factory :concept do
    ref { Faker::Alphanumeric.alphanumeric(number: 2) }
    title { Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 4) }
    article

    trait :with_subconcepts do
      transient do
        subconcepts_count { 5 }
      end

      after(:create) do |concept, evaluator|
        create_list(:subconcept, evaluator.subconcepts_count, concept: concept)
      end
    end
  end

  factory :subconcept do
    ref { Faker::Alphanumeric.alphanumeric(number: 2) }
    title { Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 4) }
    concept
  end
end
