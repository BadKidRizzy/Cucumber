Then(/^find all rest button$/) do
  
  sleep 15
  reset_elements = @page_object.searchRelated.resetEles_elements
  p reset_elements.size
  
  for i in 0..reset_elements.size-1
    reset_elements[i].click
    sleep 2
  end
  sleep 15

  all_reset = @page_object.searchRelated.allReset_element.click
  
end

Then(/^sleep for (\d+)$/) do |sleep_time|
  p "Sleep " * 10
  sleep sleep_time.to_i
end

Then(/^find page number$/) do 
  sleep 5
  p @page_object.searchRelated.pageNum_element
  p @page_object.searchRelated.pageNum_element.text

  x = 5
  p 3 <= x && x <= 10
end