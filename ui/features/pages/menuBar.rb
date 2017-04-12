class MenuBar
  include PageObject

  page_url('')

  link(:homeIcon, :xpath => "/html/body/app-root/main-page/pathevo-header/header/nav[2]/ul[2]/li[1]/a")
  link(:signup, :text => "Sign up")
  link(:login, :text => "Log in")

  link(:home, :text => "Home")
  link(:search, :text => "Search")
  link(:discover, :text => "Discover")
  link(:apply, :text => "Apply")
  link(:tasks, :text => "Tasks")
  link(:advisor, :text => "Advisor")

  i(:favoriteStarMenu, :css => '.grunticon-star.clickable.icons-link')
  span(:usernameMenu, :css => '.name')

end
