module FindRecentExtension
  def find_recent
    where("created_at > ?", 2.days.ago)
  end
end