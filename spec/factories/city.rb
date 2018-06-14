FactoryGirl.define do
  factory :city do
    name            'An Giang'
    city_type       'tinh'
    slug            'an-giang'
    name_with_type  'Tỉnh An Giang'
    path            'An Giang'
    code            '89'
    parent_code     '89'
  end
end
