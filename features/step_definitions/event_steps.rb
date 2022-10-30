
Given /the following events exist/ do |event_table|
    event_table.hashes.each do |event|
      Event.create event
    end
end
  

Then /(.*) seed events should exist/ do | n_seeds |
    expect(Event.count).to eq n_seeds.to_i
end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
    #  ensure that that e1 occurs before e2.
    #  page.body is the entire content of the page as a string.
    expect(page.body.index(e1) < page.body.index(e2))
end
  
  When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
    rating_list.split(', ').each do |rating|
      step %{I #{uncheck.nil? ? '' : 'un'}check "ratings_#{rating}"}
    end
  end
  
  Then /I should see all the movies/ do
    # Make sure that all the movies in the app are visible in the table
    Movie.all.each do |movie|
      step %{I should see "#{movie.title}"}
    end
  end
  
  Then /^the director of "(.+)" should be "(.+)"/ do |movie_name, director|
    movie = Movie.find_by(title: movie_name)
    visit movie_path(movie)
    expect(movie.director).to eq director
  end