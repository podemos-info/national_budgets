# frozen_string_literal: true

FactoryBot.define do # rubocop:disable Metrics/BlockLength
  factory :budget do
    title { Faker::Lorem.sentences(number: 1) }
    date { Faker::Date.between_except(from: 1.year.ago, to: 1.year.from_now, excepted: Time.zone.today) }
    user
  end

  factory :section do
    ref { Faker::Alphanumeric.alphanumeric(number: 2) }
    title { Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 4) }
    budget

    factory :section_with_services do
      transient do
        modifications_count { 5 }
      end

      after(:create) do |section, evaluator|
        create_list(:standard_modification, evaluator.modifications_count, section: section)
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

  factory :chapter do
    ref { Faker::Alphanumeric.alphanumeric(number: 2) }
    title { Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 4) }
    budget
  end

  factory :article do
    ref { Faker::Alphanumeric.alphanumeric(number: 2) }
    title { Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 4) }
    chapter
  end

  factory :concept do
    ref { Faker::Alphanumeric.alphanumeric(number: 2) }
    title { Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 4) }
    article
  end

  factory :subconcept do
    ref { Faker::Alphanumeric.alphanumeric(number: 2) }
    title { Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 4) }
    concept
  end
end
