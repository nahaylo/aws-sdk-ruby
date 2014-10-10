require 'spec_helper'

module AWS
  module Core
    module Signers
      class Version4
        describe '#canonical_header_value' do

          def value(v)
            signer = Version4.new('credentials', 'svc', 'region')
            signer.send(:canonical_header_value, v)
          end

          it 'trims leading and trailing whitespace' do
            value(' a ').should eq('a')
          end

          it 'reduces whitespace to single space' do
            value("a  b\tc").should eq('a b c')
          end

          it 'preseves whitespace inside quoted strings' do
            value('"a  "').should eq('"a  "')
          end

          it 'condenses whitespace between quoted strings' do
            value('" a "  " b "').should eq('" a " " b "')
          end

          it 'ignores double escaped double quotes inside quoted strings' do
            value('"  \"  "').should eq('"  \"  "')
          end

          it 'recognizes escaped backslashes' do
            value('"  \\\\"  "').should eq('"  \\\\" "')
          end

          it 'deals with stacked backslashes' do
            value('"  \\\\\\"  "').should eq('"  \\\\\\"  "')
          end

        end
      end
    end
  end
end
