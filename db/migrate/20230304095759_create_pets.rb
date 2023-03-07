class CreatePets < ActiveRecord::Migration[6.1]
  def change
    create_table :pets do |t|
      t.string :breed_name
      t.string :breed
      t.string :color
      t.string :breed_for
      t.string :sex
      t.string :lifespan
      t.string :temperament
      t.string :image_url
      t.integer :user_id
      t.timestamps
    end
  end
end
