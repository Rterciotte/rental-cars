class CreateSubsidiaries < ActiveRecord::Migration[6.0]
  def change
    create_table :subsidiaries do |t|
      t.string :name
      t.string :CNPJ
      t.string :Address

      t.timestamps
    end
  end
end
