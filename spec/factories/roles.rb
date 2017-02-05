FactoryGirl.define do
  factory :role do
    sequence(:name, (%w[invited enrolled exited mentor graduated removed]).cycle) do |name|
      "#{name}"
    end
  end
end
