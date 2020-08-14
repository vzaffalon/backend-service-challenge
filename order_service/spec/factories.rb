FactoryBot.define do
    factory :order do
        association :user_info, factory: :user_info
        association :address, factory: :address
        association :request_info, factory: :request_info
        latitude { nil }
        longitude { nil }
    end

    factory :user_info do
        email { 'joao_silva@exemplo.com' }
        phone { '(11) 98765-4321' }
        name { 'João da Silva' }
    end

    factory :address do
        city { "São Paulo"}
        neighborhood { "Jardim Paulista" }
        street { "Avenida São Gabriel" }
        uf { "SP" }
        zip_code { "01435-001" }
    end

    factory :request_info do
        question1 { "answer1" }
        question2 { "answer2" }
        question3 { "answer3" }
    end

end