class Assembly < ApplicationRecord
  # has_and_belongs_to_many :parts
  # has_and_belongs_to_many :parts, strict_loading: true
  # has_and_belongs_to_many :parts, validate: false
  # has_and_belongs_to_many :parts, join_table: "custom_assemblies_parts"
  # has_and_belongs_to_many :parts, foreign_key: "assembly_id", association_foreign_key: "part_id", join_table: "assemblies_parts"
  # has_and_belongs_to_many :parts, -> { where(active: true) }
  # has_and_belongs_to_many :parts, -> { readonly }
  # has_and_belongs_to_many :parts, -> { distinct }
  has_and_belongs_to_many :parts, -> { group("parts.id") }
  
end