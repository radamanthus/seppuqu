require 'seppuqu'

describe Seppuqu do
  it "updates the release version in Redis" do
    Seppuqu.update_release_version
  end

  it "installs the Sidekiq middleware" do
    Seppuqu.install
  end
end
