require 'rails_helper'
RSpec.describe User, type: :model do
describe User do
  before do
    @user = FactoryBot.build(:user)
  end

  describe '新規登録/ユーザー情報' do
    context 'ユーザー登録ができる時' do
      it '全ての項目が必要条件を満たし、かつ存在する' do
        expect(@user).to be_valid
      end

      it 'ニックネームがあること' do
        @user.nickname = "テスト太郎"
        expect(@user).to be_valid
      end

      it 'メールアドレスがあること' do
        @user.email = "test.taro@gmail.com"
        expect(@user).to be_valid
      end

      it 'メールアドレスは、@を含むこと' do
        @user.email = "test.taro@gmail.com"
        expect(@user).to be_valid
      end

      it 'パスワードは、6文字以上かつ半角英数字混合での入力が必須であること' do
        @user.password = "test00"
        @user.password_confirmation = "test00"
        expect(@user).to be_valid
      end
    end


      context 'ユーザー登録ができない時' do
        it 'ニックネームが存在しない' do
          @user.nickname = ""
          @user.valid?
          expect(@user.errors.full_messages).to include("Nickname can't be blank")
        end

        it 'メールアドレスが存在しない' do
          @user.email = ""
          @user.valid?
          expect(@user.errors.full_messages).to include("Email can't be blank")
        end

        it 'メールアドレスが重複している' do
            @user.save
            @another_user = FactoryBot.build(:user)
            @another_user.email = "test@gmail.com" 
            @another_user.valid?
            expect(@another_user.errors.full_messages).to include("Email has already been taken")
        end

        it 'メールアドレスに@がない' do
          @user.email = "test.tarogmail.com"
          @user.valid?
          expect(@user.errors.full_messages).to include("Email is invalid")
        end

        it 'パスワードが存在しない' do
          @user.password = ""
          @user.password_confirmation = ""
          @user.valid?
          expect(@user.errors.full_messages).to include("Password can't be blank", "Password パスワードは英数字混合で入力してください")
        end

        it 'パスワードが6文字以下' do
          @user.password = "te00"
          @user.password_confirmation = "te00"
          @user.valid?
          expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
        end

        it 'パスワードに半角の英文字しかない' do
          @user.password = "testab"
          @user.password_confirmation = "testab"
          @user.valid?
          expect(@user.errors.full_messages).to include("Password パスワードは英数字混合で入力してください")
        end

        it 'パスワードが数字のみ' do
          @user.password = "000000"
          @user.password_confirmation = "000000"
          @user.valid?
          expect(@user.errors.full_messages).to include("Password パスワードは英数字混合で入力してください")
        end

        it 'パスワードは全角では登録できないこと' do
          @user.password = "あかさたなは"
          @user.password_confirmation = "あかさたなは"
          @user.valid?
          expect(@user.errors.full_messages).to include("Password パスワードは英数字混合で入力してください")
        end

        it 'パスワード確認用に値が存在しない' do
          @user.password = "test00"
          @user.password_confirmation = ""
          @user.valid?
          expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
        end

        it 'パスワードとパスワード（確認用）、値が一致していない' do
          @user.password = "test00"
          @user.password_confirmation = "test11"
          @user.valid?
          expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
        end

      end
    end
  end
end
