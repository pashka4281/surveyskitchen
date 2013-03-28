class CreateExceptionStorages < ActiveRecord::Migration
  def change
    create_table :exception_storages do |t|
		t.string   "message"
		t.text     "trace"
		t.string   "e_class"
    end
  end
end
