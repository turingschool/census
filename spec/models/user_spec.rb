require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should have_many(:affiliations).dependent(:destroy) }
  it { should have_many(:groups).through(:affiliations) }
  it { should have_many(:user_roles).dependent(:destroy) }
  it { should have_many(:roles).through(:user_roles) }
  it { should have_many(:invitations) }
  it { should have_many(:oauth_applications) }

  # testing paperclip
  it { should have_attached_file(:image) }
  it { should validate_attachment_content_type(:image).
                allowing('image/png', 'image/gif', 'image/png').
                rejecting('text/plain', 'text/xml') }

  it "has a full name" do
    user = create(:user)
    expect(user.full_name).to eq("#{user.first_name} #{user.last_name}")
  end

  it "can report out its roles" do
    user = create :enrolled_user

    expect(user.list_roles).to eq("enrolled")
  end

  it "can find specific role associated with it" do
    user = create :user
    role_1 = create :role, name: "enrolled"
    role_2 = create :role, name: "active student"
    user.roles << [role_1, role_2]

    expect(user.has_role?("enrolled")).to be(true)
    expect(user.has_role?("active student")).to be(true)
    expect(user.has_role?("admin")).to be(false)
  end

  it "can return users by name search" do
    dan  = create :user, first_name: "Dan", last_name: "Broadbent"
    susi = create :user, first_name: "Susi", last_name: "Irwin"
    nate = create :user, first_name: "Nate", last_name: "Anderson"

    users = User.search_by_name("an")

    expect(users.sort).to eq([dan, nate])
  end

  context 'add identifying information' do
    it "rejects invalid twitter usernames" do
      okay = build(:user, twitter: "_calaway_")
      invalid_characters = build(:user, twitter: "_ca!away_")
      too_long = build(:user, twitter: "1234567890123456")

      expect(okay.valid?).to be true
      expect(invalid_characters.valid?).to be false
      expect(too_long.valid?).to be false
    end

    it "rejects invalid LinkedIn usernames" do
      okay = build(:user, linked_in: "calaway")
      invalid_characters = build(:user, linked_in: "ca!away_")
      too_short = build(:user, linked_in: "1234")
      too_long = build(:user, linked_in: "1234567890123456789012345678901")

      expect(okay.valid?).to be true
      expect(invalid_characters.valid?).to be false
      expect(too_short.valid?).to be false
      expect(too_long.valid?).to be false
    end

    it "allows LinkedIn username to have hyphens" do
      okay = build(:user, linked_in: "matthew-leo-kaufman")
      expect(okay.valid?).to be true
    end

    it "creates user with gender pronouns" do
      user = create :user, gender_pronouns: "she/her"

      expect(user).to be_valid
    end
  end

  context 'Role change' do
    it 'can change students to graduated' do
      user = create :user
      student = create :role, name: 'active student'
      graduated = create :role, name: 'graduated'
      user.roles << student
      user.change_role('graduated')
      expect(user.roles).to include(graduated)
      expect(user.roles).not_to include(student)
    end

    it 'can change applicant to student' do
      user = create :user
      student = create :role, name: 'active student'
      applicant = create :role, name: 'applicant'
      user.roles << applicant
      user.change_role('active student')
      expect(user.roles).to include(student)
      expect(user.roles).not_to include(applicant)
    end

    it 'can change student to exited' do
      user = create :user
      student = create :role, name: 'active student'
      exited = create :role, name: 'exited'
      user.roles << student
      user.change_role('exited')

      expect(user.roles).to include(exited)
      expect(user.roles).not_to include(student)
    end

    it 'knows its own cohort if it belongs to one' do
      user = create :user, cohort_id: 123

      expect(user.cohort_id).to eq(123)
    end

    it 'reports that it does not belong to a cohort' do
      user = create :user, cohort_id: nil

      expect(user.cohort_name).to eq("n/a")
    end
  end

  context "Groups" do
    it "lists its own groups" do
      groups = create_list(:group, 3)
      user = create(:user)
      user.groups = groups

      expect(user.list_groups.include?(groups.first.name)).to be_truthy
    end
  end

  context "Class Methods" do
    context "#search_all" do
      it "returns users by partial search terms" do
        # cohort_1 = create(:cohort, name: "1608")
        # cohort_2 = create(:cohort, name: "1610")
        # cohort_3 = create(:cohort, name: "1701")

        role_1 = create(:role, name: "mentor")
        role_2 = create(:role, name: "enrolled")
        role_3 = create(:role, name: "exited")

        users = create_list(:user, 3)
        # users.first.cohort = cohort_1
        # users.second.cohort = cohort_2
        # users.third.cohort = cohort_3

        users.first.roles << role_1
        users.second.roles << role_2
        users.third.roles << role_3

        group_1 = create(:group, users: [users.first], name: "grouping")
        group_2 = create(:group, users: [users.second], name: "groupers")
        group_2 = create(:group, users: [users.third], name: "having")


        # search_return = User.search_all('16')
        #
        # expect(search_return).to include(users.first)
        # expect(search_return).to include(users.second)

        search_return = User.search_all("ed")

        expect(search_return).to include(users.second)
        expect(search_return).to include(users.third)

        search_return = User.search_all("ing")

        expect(search_return).to include(users.first)
        expect(search_return).to include(users.third)
      end
    end
    #
    # context "#search_cohorts" do
    #   it "returns users by partial cohort search terms" do
    #     cohort_1 = create(:cohort, name: "1608")
    #     cohort_2 = create(:cohort, name: "1610")
    #     cohort_3 = create(:cohort, name: "1701")
    #
    #     users = create_list(:user, 3)
    #     users.first.cohort = cohort_1
    #     users.second.cohort = cohort_2
    #     users.third.cohort = cohort_3
    #     group = create(:group, users: users)
    #
    #     search_return = User.search_cohorts(["%16%"])
    #
    #     expect(search_return).to include(users.first)
    #     expect(search_return).to include(users.second)
    #   end
    # end

    context "#search_roles" do
      it "returns users by partial role search terms" do
        role_1 = create(:role, name: "mentor")
        role_2 = create(:role, name: "enrolled")
        role_3 = create(:role, name: "exited")
        users = create_list(:user, 3)
        users.first.roles << role_1
        users.second.roles << role_2
        users.third.roles << role_3
        group = create(:group, users: users)

        search_return = User.search_roles(["%ED%"])

        expect(search_return).to include(users.second)
        expect(search_return).to include(users.third)
      end
    end

    context "#search_groups" do
      it "returns users by partial role search terms" do
        role_1 = create(:role, name: "mentor")
        users = create_list(:user, 3, roles: [role_1])
        group_1 = create(:group, users: [users.first], name: "Turing Lab")
        group_2 = create(:group, users: [users.second], name: "Pahlka")
        group_2 = create(:group, users: [users.third], name: "Turing LGBTQ")

        search_return = User.search_groups(["%TURING%"])

        expect(search_return).to include(users.first)
        expect(search_return).to include(users.third)
      end
    end

    context "#search_groups" do
      it "returns users by partial role search terms" do
        users = []
        users << create(:user, first_name: "Name")
        users << create(:user, last_name: "Name")
        users << create(:user, last_name: "Nope")
        group = create(:group, users: users)

        search_return = User.search_users(["%NAME%"])

        expect(search_return).to include(users.first)
        expect(search_return).to include(users.second)
      end
    end

  end
end
