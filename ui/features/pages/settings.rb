class SettingsPage
  include PageObject
  page_url('/profile/settings')

  h1(:title, :css => '.text-primary')

  #profile links
  h3(:aboutMe,:css =>' li:nth-child(1) > a > h3')
  h3(:contact,:css =>' li:nth-child(2) > a > h3')
  h3(:payment,:css =>' li:nth-child(3) > a > h3')
  h3(:settings,:css =>' li:nth-child(4) > a > h3')
  h3(:education,:css =>'div > ul > li:nth-child(1) > a > h3')
  h3(:courses,:css =>'div > ul > li:nth-child(2) > a > h3')
  h3(:tests,:css =>'div > ul > li:nth-child(3) > a > h3')
  h3(:activities,:css =>'div > ul > li:nth-child(4) > a > h3')
  h3(:achievements, :css =>'div > ul > li:nth-child(5) > a > h3')

  #aboutme elements

  #contact elements

  #payment elements

  #settings elements

  #education elements

  #courses elements

  #tests elements

  #activities elements

  #achievements elements

  radio_button(:emailOn, :id =>'email-on')
  radio_button(:textOn, :id =>'text-on')

  radio_button(:emailOff, :id =>'email-off')
  radio_button(:textOff, :id =>'text-off')

  text_field(:currentPassword, :id => 'current')
  text_field(:newPassword, :id => 'new')
  text_field(:reType, :id => 'confirm')

  button(:save, :css => '.btn.btn-primary.save')
  button(:cancel, :css => '.btn.btn-danger')

  link(:forget, :href => '/auth/forgot-pass')
end
