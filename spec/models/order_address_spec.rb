require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  describe '購入情報の保存' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @order_address = FactoryBot.build(:order_address, user_id: user.id, item_id: item.id)
    end

    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@order_address).to be_valid
      end
      it '建物名は空でも保存できること' do
        @order_address.tatemono = ''
        expect(@order_address).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it '郵便番号が空だと保存できないこと' do
        @order_address.post_code = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Post code can't be blank")
      end
      it '郵便番号が半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        @order_address.post_code = '1111111'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Post code is invalid. Enter it as follows (e.g. 123-4567)')
      end
      it '都道府県が"---"だと保存できないこと' do
        @order_address.prefecture_id = 1
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Prefecture can't be ---")
      end
      it '市区町村は空だと保存できないこと' do
        @order_address.banti = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Banti can't be blank")
      end
      it '番地は空だと保存できないこと' do
        @order_address.banti = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Banti can't be blank")
      end
      it '電話番号が空だと保存できないこと' do
        @order_address.tel = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Tel can't be blank")
      end
      it '電話番号は、10桁以上11桁以内の半角数値以外を含んだものでは保存できないこと' do
        @order_address.tel = '012345678-9'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Tel is invalid')
      end
      it '電話番号は、9桁以下の半角数値では保存できないこと' do
        @order_address.tel = '012345678'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Tel is invalid')
      end
      it '電話番号は、12桁以上の半角数値では保存できないこと' do
        @order_address.tel = '012345678901'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Tel is invalid')
      end
      it 'user_idが紐付いていないと保存できないこと' do
        @order_address.user_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("User can't be blank")
      end
      it 'item_idが紐付いていないと保存できないこと' do
        @order_address.item_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Item can't be blank")
      end
      it 'tokenが空だと保存できないこと' do
        @order_address.token = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
