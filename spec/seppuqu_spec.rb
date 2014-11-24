require 'seppuqu'

describe Seppuqu do
  it "updates the release version in Redis" do
    Seppuqu.install
    Seppuqu.update_release_version
  end

  it "installs the Sidekiq middleware" do
    Seppuqu.install
    expect Sidekiq.methods.include?(:get_release_version)
    expect Sidekiq.methods.include?(:current_release_version)
    expect Sidekiq.methods.include?(:latest_release_version)

    expect(Sidekiq.current_release_version).to eq(20141124075508)
  end
end
