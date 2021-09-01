class CreateUnsubscribes < ActiveRecord::Migration[6.1]
  def change
    create_table :unsubscribes do |t|

      t.timestamps
    end
  end
end
