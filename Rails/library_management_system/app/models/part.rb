class Part < ApplicationRecord
  # has_and_belongs_to_many :assemblies
  # has_and_belongs_to_many :assemblies, -> { readonly }, autosave: true
  # has_and_belongs_to_many :assemblies, join_table: "custom_assemblies_parts"
  # has_and_belongs_to_many :assemblies, foreign_key: "part_id", association_foreign_key: "assembly_id", join_table: "assemblies_parts"'
  # has_and_belongs_to_many :assemblies,  -> { order("created_at ASC").limit(3) }
  # has_and_belongs_to_many :assemblies, -> { order "name ASC" }
  # has_and_belongs_to_many :assemblies, -> { group("assemblies.id") }


  
end
