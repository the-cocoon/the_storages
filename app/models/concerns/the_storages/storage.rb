module TheStorages
  module Storage
    extend ActiveSupport::Concern

    included do
      has_many :attached_files, as: :storage
    end
  end
end
