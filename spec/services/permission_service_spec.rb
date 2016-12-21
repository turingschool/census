require 'rails_helper'

RSpec.describe Permission do
  it "Prints a warning to stdout" do
    current_user = nil
    controller = "users"
    action = "index"
    current_permission = Permission.new(current_user)

    expected_output = "**********\nCHECK PERMISSIONS\nCurrent User: false\nController: users\nAction: index\n**********\n"

    expect {
      current_permission.print_warning(current_user, controller, action)
    }.to output(expected_output).to_stdout
  end
end
