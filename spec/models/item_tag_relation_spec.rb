require 'rails_helper'

RSpec.describe ItemTagRelation, type: :model do
  before do
    item = FactoryBot.create(:item)
    tag = FactoryBot.create(:tag)
    @item_tag_relation = FactoryBot.build(:item_tag_relation, item_id: item.id, tag_id: tag.id)
  end

  describe '新規登録' do
    context '新規登録できるとき' do
      it '商品とタグが存在すれば登録できる' do
        expect(@item_tag_relation).to be_valid
      end
    end
    context '新規登録できないとき' do
      it '商品が空では登録できない' do
        @item_tag_relation.item_id = nil
        @item_tag_relation.valid?
        expect(@item_tag_relation.errors.full_messages).to include("Item must exist", "Item can't be blank")
      end
        it 'タグが空では登録できない' do
          @item_tag_relation.tag_id = nil
          @item_tag_relation.valid?
          expect(@item_tag_relation.errors.full_messages).to include("Tag must exist", "Tag can't be blank")
        end
      end
    end
end
