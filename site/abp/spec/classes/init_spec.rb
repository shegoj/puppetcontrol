require 'spec_helper'
describe 'abp' do

  context 'with defaults for all parameters' do
    it { should contain_class('abp') }
  end
end
