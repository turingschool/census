def stub_cohorts_with(cohort_stubs = nil)
  allow(Cohort).to receive(:all).and_return(
    cohort_stubs || [Cohort.new(RemoteCohort.new(id: 1234, status: "open", name: "1608-BE"))]
  )
end

RSpec.configure do |config|
  config.before(:each) do
    stub_cohorts_with
  end
end
