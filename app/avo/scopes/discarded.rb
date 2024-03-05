# frozen_string_literal: true

# Avo scope for showing soft-deleted records.
class Avo::Scopes::Discarded < Avo::Advanced::Scopes::BaseScope
  self.name        = "Discarded"
  self.description = "Soft-deleted records only."
  self.scope       = -> { query.discarded }
  self.visible     = -> { true }
end
