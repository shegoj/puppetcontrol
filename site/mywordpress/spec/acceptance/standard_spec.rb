require 'spec_helper_acceptance'

describe 'Mywordpess class' do
  context 'default parameters' do
    # Using puppet_apply as a helper
    it 'should apply idempontently' do
      pp = "class { 'mywordpress':}"

      # Run it twice and test for idempotency
      expect(apply_manifest(pp, {:debug => true} ).exit_code).to_not eq(1)
      expect(apply_manifest(pp).exit_code).to eq(0)
    end
  end
end
describe file ('/opt') do
  it { should be_directory }
end
describe file ('/opt/wordpress') do
  it { should be_directory }
end
