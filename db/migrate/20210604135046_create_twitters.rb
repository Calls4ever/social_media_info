class CreateTwitters < ActiveRecord::Migration[6.1]
  def change
    create_table :twitters do |t|
      t.string :tweet
      t.belongs_to :social_media_detail
      t.timestamps
    end
  end
end
