FactoryGirl.define do
  factory :role do

    sequence(:name, (%w[invited enrolled admin enrolled exited enrolled mentor graduated removed mentor]).cycle) do |name|
      "#{name}"
    end

  end
end
