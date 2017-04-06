class DetailPage
  include PageObject
  page_url('')

  i(:favoriteDetail, :css => ".social-widgets .need-login .clickable.icon.text-warning")
  link(:notes, :text => 'Notes')

  link(:academic, :text => 'Academics')
  link(:description, :text => 'Description')

  i(:addNote, :css => '.icon-circle-with-plus')
  text_field(:titleNote, :id => 'title')
  textarea(:bodyNote, :id => 'content')

  div(:noteTable, :css => '.well.content-notes .row')

  button(:delete, :text => 'Delete')
  button(:saveNote, :text => 'Save Note')
  button(:cancel, :text => 'Cancel')
  button(:yesDelete, :text => 'Yes, delete')
end
