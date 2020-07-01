RSpec.describe HeyYouNexmo do
  it { expect(HeyYouNexmo).to be_instance_of(Module) }
  it { expect(HeyYouNexmo::VERSION).to be_instance_of(String) }
end