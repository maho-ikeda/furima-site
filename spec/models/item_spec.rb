require 'rails_helper'

RSpec.describe Item, type: :model do
  describe Item do
    before do
      @item = FactoryBot.build(:item)
    end

    describe '' do
      context 'ユーザー登録ができる時' do
        it '全ての項目が必要条件を満たし、かつ存在する' do
          expect(@user).to be_valid
        end
      end
    end
end
