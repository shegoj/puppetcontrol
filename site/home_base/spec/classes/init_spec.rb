require 'spec_helper'
describe 'home_base' do
  context 'with default values for all parameters' do
    it { should contain_class('home_base') }
  end
end
