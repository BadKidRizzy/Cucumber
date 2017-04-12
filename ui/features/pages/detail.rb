class DetailPage
  include PageObject
  page_url('')

  i(:favoriteDetail, :css => ".social-widgets .need-login .clickable.icon.text-warning")
  link(:notes, :xpath => '/html/body/app-root/main-page/main/detail-page/div/detail-school/div/ul/li[4]/a')
  #line(:info, :xpath => '//*[@id="bb25cb6f-f993-4b9b-9d20-6949968a0d57"]/g[5]/circle')

  link(:academic, :text => 'Academics')
  link(:description, :text => 'Description')

  i(:addNote, :css => '.icon-circle-with-plus')
  text_field(:titleNote, :id => 'title')
  textarea(:bodyNote, :id => 'content')

  div(:noteTable, :css => '.well.content-notes .row')

  button(:delete, :text => 'Delete')
  button(:saveNote, :xpath => '/html/body/app-root/main-page/main/detail-page/div/detail-school/div/div/content-notes/div[1]/div/div/div[2]/form/div[2]/feedback-button/button')
  button(:cancel, :text => 'Cancel')
  button(:yesDelete, :text => 'Yes, delete')
end
