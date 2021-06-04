class CreateFacebooks < ActiveRecord::Migration[6.1]
  def change
    create_table :facebooks do |t|
      t.string :status
      t.belongs_to :social_media_detail
      t.timestamps
    end
  end
end
