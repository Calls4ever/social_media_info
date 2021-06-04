class CreateSocialMediaDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :social_media_details do |t|

      t.timestamps
    end
  end
end
