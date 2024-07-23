class GoodnessValidator < ActiveModel::Validator
    def validate(record)
      if record.librarian_name == "Evil"
        record.errors.add :base, "This librarian is evil"
      end
    end
  end