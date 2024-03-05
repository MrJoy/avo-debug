# frozen_string_literal: true

# Avo scope for hiding soft-deleted records.
class Avo::Scopes::Kept < Avo::Advanced::Scopes::BaseScope
  self.name        = "Kept"
  self.description = "Records that have not been soft-deleted."
  self.scope       = -> { query.kept }
  self.visible     = -> { true }
end
