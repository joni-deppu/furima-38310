require 'rails_helper'

RSpec.describe ItemForm, type: :model do
  before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      tag = FactoryBot.create(:tag)
      @item_form = FactoryBot.build(:item_form, user_id: user.id, images: item.images, tag_name: tag.tag_name)
    end

  describe '出品新規登録' do
    context '新規登録できるとき' do
      it '入力項目が存在すれば登録できる' do
        expect(@item_form).to be_valid
      end
      it ' タグが空でも登録できる' do
        @item_form.tag_name = ""
        expect(@item_form).to be_valid
      end
    end
    context '新規登録できないとき' do
      it '商品画像が空では登録できない' do
        @item_form.images = nil
        @item_form.valid?
        expect(@item_form.errors.full_messages).to include("Images can't be blank")
      end
      it '商品画像が6枚以上では登録できない' do
        @item_form.images.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
        @item_form.valid?
        expect(@item_form.errors.full_messages).to include("Images は1枚以上5枚以下にしてください")
      end
      it '商品名が空では登録できない' do
        @item_form.item_name = ''
        @item_form.valid?
        expect(@item_form.errors.full_messages).to include("Item name can't be blank")
      end
      it '商品名が41字以上では登録できない' do
        @item_form.item_name = 'あ' * 41
        @item_form.valid?
        expect(@item_form.errors.full_messages).to include('Item name is too long (maximum is 40 characters)')
      end
      it '商品の説明が空では登録できない' do
        @item_form.detail = ''
        @item_form.valid?
        expect(@item_form.errors.full_messages).to include("Detail can't be blank")
      end
      it '商品の説明が1001字以上では登録できない' do
        @item_form.detail = 'あ' * 1001
        @item_form.valid?
        expect(@item_form.errors.full_messages).to include('Detail is too long (maximum is 1000 characters)')
      end
      it 'カテゴリーに「---」が選択されている場合は出品できない' do
        @item_form.category_id = 1
        @item_form.valid?
        expect(@item_form.errors.full_messages).to include("Category can't be blank")
      end
      it '商品の状態に「---」が選択されている場合は出品できない' do
        @item_form.condition_id = 1
        @item_form.valid?
        expect(@item_form.errors.full_messages).to include("Condition can't be blank")
      end
      it '配送料の負担に「---」が選択されている場合は出品できない' do
        @item_form.cost_id = 1
        @item_form.valid?
        expect(@item_form.errors.full_messages).to include("Cost can't be blank")
      end
      it '発送元の地域に「---」が選択されている場合は出品できない' do
        @item_form.prefecture_id = 1
        @item_form.valid?
        expect(@item_form.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '発送までの日数に「---」が選択されている場合は出品できない' do
        @item_form.scheduled_day_id = 1
        @item_form.valid?
        expect(@item_form.errors.full_messages).to include("Scheduled day can't be blank")
      end
      it '価格が空では登録できない' do
        @item_form.price = ''
        @item_form.valid?
        expect(@item_form.errors.full_messages).to include("Price can't be blank")
      end
      it '価格が300未満では登録できない' do
        @item_form.price = 100
        @item_form.valid?
        expect(@item_form.errors.full_messages).to include('Price must be greater than or equal to 300')
      end
      it '価格が10000000以上では登録できない' do
        @item_form.price = 11_111_111
        @item_form.valid?
        expect(@item_form.errors.full_messages).to include('Price must be less than or equal to 9999999')
      end
      it '価格が半角数値でないと登録できない' do
        @item_form.price = '９９９'
        @item_form.valid?
        expect(@item_form.errors.full_messages).to include('Price is not a number')
      end
      it 'userが紐付いていない（user_idが空だ）と保存できない' do
        @item_form.user_id = nil
        @item_form.valid?
        expect(@item_form.errors.full_messages).to include("User can't be blank")
      end
      it 'タグが19字以上では登録できない' do
        @item_form.tag_name = 'あ' * 19
        @item_form.valid?
        expect(@item_form.errors.full_messages).to include('Tag name is too long (maximum is 18 characters)')
      end
    end
  end
end
