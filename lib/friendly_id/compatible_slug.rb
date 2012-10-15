module FriendlyId
  # A FriendlyId v3.x slug stored in an external table.
  #
  # @see FriendlyId::CompatibleHistory
  class CompatibleSlug < ActiveRecord::Base
    self.table_name = "slugs"
    belongs_to :sluggable, :polymorphic => true

    def to_param
      slug
    end

    def slug
      return unless name
      sequence == 1 ? name : "#{name}#{separator}#{sequence}"
    end

    private

    def separator
      sluggable_type.constantize.friendly_id_config.sequence_separator
    end
  end
end
