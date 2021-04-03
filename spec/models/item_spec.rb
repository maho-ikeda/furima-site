require 'rails_helper'

RSpec.describe Item, type: :model do
  describe Item do
    before do
      @item = FactoryBot.build(:item)
    end

    describe '商品出品機能' do
      context '出品する商品の登録・保存ができる時' do
        it '全ての項目が必要条件を満たし、かつ存在する' do
          expect(@item).to be_valid
        end

        it '商品名が40文字以下である' do
          @item.name = "アイテム2"
          expect(@item).to be_valid
        end

        it '商品の説明が1000文字以下である' do
          @item.explanation = "テスト説明"
          expect(@item).to be_valid
        end

        it '商品のカテゴリーが選択されている' do
          @item.category_id = "3"
          expect(@item).to be_valid
        end

        it '商品の状態が選択されている' do
          @item.condition_id = "3"
          expect(@item).to be_valid
        end

        it '配送料の負担が選択されている' do
          @item.cost_id = "3"
          expect(@item).to be_valid
        end

        it '発送元の地域が選択されている' do
          @item.prefecture_id = "3"
          expect(@item).to be_valid
        end

        it '発送までの日数が選択されている' do
          @item.lead_time_id = "3"
          expect(@item).to be_valid
        end
      end

      context '出品する商品の登録・保存ができない時' do
        it '商品名が存在しない' do
          @item.name = ""
          @item.valid?
          expect(@item.errors.full_messages).to include("Name can't be blank")
        end

        it '商品名が40文字より多い' do
          @item.name = "a" * 41
          @item.valid?
          expect(@item.errors.full_messages).to include("Name is too long (maximum is 40 characters)")
        end

        it '商品の写真が存在しない' do
          @item.image.attach ()
          @item.valid?
          expect(@item.errors.full_messages).to include("Image can't be blank")
        end

        it '商品の説明が存在しない' do
          @item.explanation = ""
          @item.valid?
          expect(@item.errors.full_messages).to include("Explanation can't be blank")
        end

        it '商品の説明が1000文字より多い' do
          @item.explanation = "a" * 1001
          @item.valid?
          expect(@item.errors.full_messages).to include("Explanation is too long (maximum is 1000 characters)")
        end

        it '商品のカテゴリーが選択されていない' do
          @item.category_id = "1"
          @item.valid?
          expect(@item.errors.full_messages).to include("Category must be other than 1")
        end

        it '商品の状態が選択されていない' do
          @item.condition_id = "1"
          @item.valid?
          expect(@item.errors.full_messages).to include("Condition must be other than 1")
        end

        it '配送料の負担が選択されていない' do
          @item.cost_id = "1"
          @item.valid?
          expect(@item.errors.full_messages).to include("Cost must be other than 1")
        end

        it '発送元の地域が選択されていない' do
          @item.prefecture_id = "1"
          @item.valid?
          expect(@item.errors.full_messages).to include("Prefecture must be other than 1")
        end

        it '発送日までの日数が選択されていない' do
          @item.lead_time_id = "1"
          @item.valid?
          expect(@item.errors.full_messages).to include("Lead time must be other than 1")
        end
      end
    end
  end
end
