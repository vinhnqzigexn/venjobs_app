require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe "job_apply" do
    let(:mail) { UserMailer.job_apply }

    it "renders the headers" do
      expect(mail.subject).to eq("Job apply")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
