require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

    describe 'ユーザー新規登録' do
      context '新規登録できるとき' do
        # ユーザー新規登録についてのテストコードを記述します  
          it '入力項目が存在すれば登録できる' do
            expect(@user).to be_valid
          end
      end
      context '新規登録できないとき' do
          it 'nicknameが空では登録できない' do
            # nicknameが空では登録できないテストコードを記述します
            @user.nickname = ''
            @user.valid?
            expect(@user.errors.full_messages).to include("Nickname can't be blank") 
          end
          it 'emailが空では登録できない' do
            # emailが空では登録できないテストコードを記述します
            @user.email ="" 
            @user.valid?
            expect(@user.errors.full_messages).to include("Email can't be blank")      
          end
          it '重複したemailが存在する場合は登録できない' do
            @user.save
            another_user = FactoryBot.build(:user)
            another_user.email = @user.email
            another_user.valid?
            expect(another_user.errors.full_messages).to include('Email has already been taken')
          end
          it 'emaiは@を含まないと登録できない' do
            @user.email = 'testmail'
            @user.valid?
            expect(@user.errors.full_messages).to include('Email is invalid')
          end
          it 'passwordが空では登録できない' do
              @user.password = ''
              @user.valid?
              expect(@user.errors.full_messages).to include("Password can't be blank")
          end
          it 'passwordが5文字以下では登録できない' do
            @user.password = '00000'
            @user.password_confirmation = '00000'
            @user.valid?
            expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
          end
          it 'passwordが129文字以上では登録できない' do
            @user.password =  Faker::Internet.password(min_length: 129)
            @user.password_confirmation =  @user.password
            @user.valid?
            expect(@user.errors.full_messages).to include('Password is too long (maximum is 128 characters)')
          end
          it 'passwordは半角英数字混合でないと登録できない' do
            @user.password = "111111"
            @user.password_confirmation = @user.password
            @user.valid?
            expect(@user.errors.full_messages).to include("Password is invalid. Include both letters and numbers")
          end
          it 'passwordとpassword_confirmationが不一致では登録できない' do
              @user.password = '123456'
              @user.password_confirmation = '1234567'
              @user.valid?
              expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
          end
      end
    end
end