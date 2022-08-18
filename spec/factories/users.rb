FactoryBot.define do
  factory :user do

   nickname              {Faker::Name.name}
   first_name_zenkaku    {"田中"}
   last_name_zenkaku     {"信玄"}
   first_name_katakana   {"カトウ"}
   last_name_katakana    {"ケンシン"}
   email                 {Faker::Internet.free_email}
   password              {Faker::Internet.password(min_length: 6)}
   password_confirmation {password}
   birthday              {Faker::Date.birthday}

  end
 end