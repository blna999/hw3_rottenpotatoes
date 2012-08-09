# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create(movie)
  end
  movies_table.hashes.each do |movie|
    x = Movie.find_by_title(movie["title"])
    assert x != nil and x.rating == movie["rating"] and x.release_date == movie["release_date"]
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  flunk "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list = rating_list.split(/[, ]+/)
  if uncheck
    verb = "uncheck"
  else
    verb = "check"
  end
  rating_list.each {|rating| step %Q{I #{verb} "ratings_#{rating}"}}
end

Then /^(?:|I )should see all of the movies$/ do
  assert page.all('table#movies tbody tr').count == Movie.all.count
end
