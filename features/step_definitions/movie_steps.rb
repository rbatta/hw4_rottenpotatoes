Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create!(movie) 
  end
end

Then /^the director of "([^"]*)" should be "([^"]*)"$/ do |arg1, arg2|
  if page.respond_to? :should
    page.should have_content(arg1)
    page.should have_content(arg2)
  else
    assert page.has_content?(arg1)
  end

  # assert_equal Movie.find_by_title(arg1).director, arg2 
end
