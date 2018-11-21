class CreateShortenedUrls < ActiveRecord::Migration[5.2]
  def change
    create_table :shortened_urls do |t|
      t.string :target_url
      t.string :short_path
      t.references :user
      t.timestamps
    end
  end
end
