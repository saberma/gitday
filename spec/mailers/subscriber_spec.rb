require "spec_helper"

describe Subscriber do
  describe "day" do
    let(:mail) { Subscriber.day }

    it "renders the headers" do
      mail.subject.should eq("Day")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
