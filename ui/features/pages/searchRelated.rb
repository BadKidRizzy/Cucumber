class SearchRelated
  include PageObject

  page_url('')
  span(:dropDownIcon, :css => '.btn.btn-primary')

  # link(:schoolsDrop, :css => '.dropdown-menu li a')
  # link(:majorsDrop, :css => '.dropdown-menu li~li a')
  # link(:occupationsDrop, :css => '.dropdown-menu li~li~li a')
  # link(:jobsDrop, :css => '.dropdown-menu li ~ li ~li ~li a')
  link(:schoolsDrop, :css => "a[href$='schools']")
  link(:majorsDrop, :css => "a[href$='majors']")
  link(:occupationsDrop, :css => "a[href$='occupations']")
  link(:jobsDrop, :css => "a[href$='jobs']")

  div(:searchFilters, :css => '.well')
  button(:firstSelected, :css => '.active-filters button')

  # text_field(:searchBox, :css => ".NaN")
  text_field(:searchBox, :css => "[name='search'] input")
  text_field(:jobSearchBox, :css => "[name = 'search']")

  button(:search, :css => "button[type='submit']")
  table(:searchResults, :css => '.table.table-sortable')

  # link(:allReset, :css => '.btn.reset-all')
  # span(:allReset, :css => '.col-md-8 .clickable')
  link(:allReset, :text => 'Reset')
  spans(:resetEles, :text => 'Reset')

  li(:pageNum, :css => '.alignment li.active')

end