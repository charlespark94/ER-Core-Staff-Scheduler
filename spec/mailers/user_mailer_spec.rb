require "spec_helper"

describe UserMailer do
  describe "password_reset" do
    let(:user_params) do
        {
          first_name: 'bob',
          last_name: 'smith',
          usertype: 'Administrator',
          email: 'vacorescheduling@gmail.com',
          fte: '0.8',
          username: 'admin',
          password: 'admin',
          password_confirmation: 'admin'
        }
    end
    let(:user) { User.create(user_params) }
    let(:mail) { UserMailer.password_reset(user) }

    it "renders the headers" do
      user.send_password_reset
      mail.subject.should eq("Password Reset")
      mail.to.should eq([user.email])
      mail.from.should eq(["vacorescheduling@gmail.com"])
    end
  end

end
