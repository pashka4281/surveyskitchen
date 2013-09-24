
  class Version < ActiveRecord::Base
    attr_accessible :item_type, :item_id, :event, :whodunnit, :object, :account_id

    serialize :object
  end
