FactoryGirl.define do
  factory :group do
    sequence(:name, (%w[Pahlka TuringLab Armstrong LBTQTuring JoanClarke]).cycle) do |name|
      "#{name}"
    end
  end
end
