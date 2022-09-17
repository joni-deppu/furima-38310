require 'rails_helper'

RSpec.describe Tag, type: :model do
  before do
    @tag = FactoryBot.build(:tag)
  end

  describe 'タグ新規登録' do
    context '新規登録できるとき' do
      it 'タグが存在すれば登録できる' do
        expect(@tag).to be_valid
      end
    end
    context '新規登録できないとき' do
      it 'タグが空では登録できない' do
        @tag.tag_name = ''
        @tag.valid?
        expect(@tag.errors.full_messages).to include("Tag name can't be blank")
      end
      it '重複したタグが存在する場合は登録できない' do
        @tag.save
        another_tag = FactoryBot.build(:tag)
        another_tag.tag_name = @tag.tag_name
        another_tag.valid?
        expect(another_tag.errors.full_messages).to include('Tag name has already been taken')
      end
      it 'タグが19字以上では登録できない' do
        @tag.tag_name = 'あ' * 19
        @tag.valid?
        expect(@tag.errors.full_messages).to include('Tag name is too long (maximum is 18 characters)')
      end
    end
  end
end
