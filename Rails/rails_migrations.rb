                                          <-----------:Migrations in Rails DB:------------->
1) Generate a Migration:
    Creates a new migration file in the db/migrate directory. You can specify changes like adding or removing columns.

    => rails generate migration <MigrationName>


2) Add Column Using Migration:->
    Generates a migration to remove a column from a specific table. Replace ColumnName, TableName, column_name, and data_type with your desired values.

   => rails generate migration AddPartNumberToProducts 

   Entering the migration file that is created and add column:

   class AddPartNumberToProducts < ActiveRecord::Migration[7.1]
      def change
        add_column :<table_name>, :<field_name>>, :string
      end
   end

  Example:
  rails g migration addColumnToFines

  class AddColumnToFines < ActiveRecord::Migration[7.1]
    def change
      add_column :fines, :fine_day, :string
    end
  end


3) Remove Column Using Migration:->
   => rails generate migration RemovePartNumberFromProducts 

   Entering the migration file that is created and remove column:

   class RemovePartNumberFromProducts < ActiveRecord::Migration[7.1]
      def change
        remove_column :<table_name>, :<field_name>>, :string
      end
   end

  Example:
  rails g migration removeColumnFromFines 

  class RemoveColumnFromFines < ActiveRecord::Migration[7.1]
    def change
      remove_column :fines, :fine_day, :string
    end
  end
  

4) Check Migration Status:->
    Displays the status of all migrations (whether they are up or down).

  => rails db:migrate:status

#Output:
database: rails_library_development

 Status   Migration ID    Migration Name
--------------------------------------------------
   up     20240718052415  Create authors
   up     20240718052419  Create genres
   up     20240718052423  Create books
   up     20240718052428  Create members
   up     20240718052432  Create librarians
   up     20240718052457  Create library transactions
   up     20240718052501  Create fines
   up     20240718072839  Add column to fines
   up     20240718074526  Remove column from fines


5) Migrate to a Specific Version:->
    Rolls forward or backward to a specific migration version. Replace timestamp with the timestamp of the desired migration.

  => rails db:migrate VERSION=timestamp


6) Redo the Last Migration:
    Rolls back the last migration and then reapplies it.

    => rails db:migrate:redo
# Output-
== 20240718074526 RemoveColumnFromFines: reverting ============================
-- add_column(:fines, :fine_day, :string)
   -> 0.0015s
== 20240718074526 RemoveColumnFromFines: reverted (0.0031s) ===================

== 20240718074526 RemoveColumnFromFines: migrating ============================
-- remove_column(:fines, :fine_day, :string)
   -> 0.0011s
== 20240718074526 RemoveColumnFromFines: migrated (0.0011s) ===================


7) Redo Multiple Migrations:
    Rolls back the last n migrations and then reapplies them.

    => rails db:migrate:redo STEP=n
# Output-
== 20240718074526 RemoveColumnFromFines: reverting ============================
-- add_column(:fines, :fine_day, :string)
   -> 0.0021s
== 20240718074526 RemoveColumnFromFines: reverted (0.0082s) ===================

== 20240718072839 AddColumnToFines: reverting =================================
-- remove_column(:fines, :fine_day, :string)
   -> 0.0016s
== 20240718072839 AddColumnToFines: reverted (0.0019s) ========================

== 20240718072839 AddColumnToFines: migrating =================================
-- add_column(:fines, :fine_day, :string)
   -> 0.0009s
== 20240718072839 AddColumnToFines: migrated (0.0009s) ========================

== 20240718074526 RemoveColumnFromFines: migrating ============================
-- remove_column(:fines, :fine_day, :string)
   -> 0.0008s
== 20240718074526 RemoveColumnFromFines: migrated (0.0008s) ===================


8) Rollback the Last Migration:
    Reverts the last migration.

  => rails db:rollback

# Output:
== 20240718074526 RemoveColumnFromFines: reverting ============================
-- add_column(:fines, :fine_day, :string)
   -> 0.0072s
== 20240718074526 RemoveColumnFromFines: reverted (0.0088s) ===================


9) Rollback Multiple Migrations:
    Rolls back the last n migrations. Replace n with the number of migrations you want to roll back.

    => rails db:rollback STEP=n

# Output:
== 20240718072839 AddColumnToFines: reverting =================================
-- remove_column(:fines, :fine_day, :string)
   -> 0.0066s
== 20240718072839 AddColumnToFines: reverted (0.0082s) ========================

== 20240718052501 CreateFines: reverting ======================================
-- drop_table(:fines)
   -> 0.0038s
== 20240718052501 CreateFines: reverted (0.0038s) =============================




                 <------------COLUMN MODIFIERS------------->

Column Modifiers
1) comment: Adds a comment for the column.
2) collation: Specifies the collation for a string or text column.
3) default: Allows setting a default value for the column.
4) limit: Sets the maximum number of characters for a string column and the maximum number of bytes for text/binary/integer columns.
5) null: Allows or disallows NULL values in the column.
6) precision: Specifies the precision for decimal/numeric/datetime/time columns.
7) scale: Specifies the scale for the decimal and numeric columns.


                  <-----------CHANGE METHOD----------->

1) add_check_constraint -> Adds a check constraint to a table
    Example:
        add_check_constraint :table_name, 'check_condition', name: 'constraint_name'

2) add_column -> Adds a new column to a table.\
    Example:
        add_column :table_name, :column_name, :column_type, options

3) add_foreign_key -> Adds a foreign key constraint to a table.
    Example:
        add_foreign_key :table_name, :referenced_table, options

4) add_index -> Adds an index to a column or columns in a table.
    Example:
        add_index :table_name, :column_name, options

5) add_reference -> Adds a reference column to a table.
    Example:
        add_reference :table_name, :referenced_table, options

6) add_timestamps ->  Adds created_at and updated_at timestamp columns to a table.
    Example:
        add_timestamps :table_name

7) change_column_comment (must supply :from and :to options) ->  Changes the comment on a column.
    Example:
        change_column_comment :table_name, :column_name, from: 'old_comment', to: 'new_comment'

8) change_column_default (must supply :from and :to options) -> Changes the default value of a column.
    Example:
        change_column_default :table_name, :column_name, from: 'old_default', to: 'new_default'

9) change_column_null -> Changes whether a column can be NULL or not.
    Example:
        change_column_null :table_name, :column_name, false

10) change_table_comment (must supply :from and :to options) -> Changes the comment on a table.
    Example:
        change_table_comment :table_name, from: 'old_comment', to: 'new_comment'

11) create_join_table -> Creates a join table for a many-to-many relationship.
    Example:
        create_join_table :table1, :table2 do |t|
            t.index [:table1_id, :table2_id]
        end

12) create_table -> Creates a new table.
    Example:
        create_table :table_name, options do |t|
            t.column :column_name, :column_type
        end

13) disable_extension -> Disables a PostgreSQL extension.
    Example:
        disable_extension :extension_name

14) drop_join_table -> : Drops a join table
    Example:
        drop_join_table :table1, :table2

15) drop_table (must supply table creation options and block) -> Drops an existing table.
    Example:
        drop_table :table_name, options do |t|
            # Block for additional options
        end

16) enable_extension -> Enables a PostgreSQL extension
    Example:
        enable_extension :extension_name

17) remove_check_constraint (must supply original constraint expression) -> Removes a check constraint from a table.
    Example:
        remove_check_constraint :table_name, name: 'constraint_name'

18) remove_column (must supply original type and column options) -> Removes a column from a table.
    Example: 
        remove_column :table_name, :column_name, :column_type, options

19) remove_columns (must supply original type and column options) -> Removes multiple columns from a table.
    Example:
        remove_columns :table_name, :column_name1, :column_name2

20) remove_foreign_key (must supply other table and original options) -> Removes a foreign key constraint from a table.
    Example:
        remove_foreign_key :table_name, :referenced_table, options

21) remove_index (must supply columns and original options) -> Removes an index from a column or columns.
    Example:
        remove_index :table_name, column: :column_name, options

22) remove_reference (must supply original options) -> Removes a reference column from a table.
    Example:
        remove_reference :table_name, :referenced_table, options

23) remove_timestamps (must supply original options) -> Removes created_at and updated_at timestamp columns.
    Example:
        remove_timestamps :table_name

24) rename_column -> Renames a column in a table.
    Example:
        rename_column :table_name, :old_column_name, :new_column_name

25) rename_index -> Renames an index on a table.
    Example:
      rename_index :table_name, :old_index_name, :new_index_name

26) rename_table -> Renames an existing table.
    Example:
      rename_table :old_table_name, :new_table_name
