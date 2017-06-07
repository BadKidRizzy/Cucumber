class HomePage
  include PageObject

  page_url('/home')

  link(:signup, :text => "Sign up")
  link(:login, :text => "Log in")

  # h4(:cardTitle, :css =>'#card-title')
  link(:cardTitle, :css =>' div:nth-child(1) > div > h2 > a')

  h1(:favorites, :text => 'Favorite Schools ?')
  h1(:assessments, :text => 'Assessments')
  h1(:highlights, :text => 'Highlights')

  # div(:favoriteButDis, :css => ".need-login")
  link(:ignoreBut, :xpath => '/html/body/app-root/main-page/main/home-page/div/div/div[1]/recommendation-card/div/div[1]/div[2]/div/div[1]/a')
  i(:favoriteBut, :css => '.icon.grunticon-star-outline')

  link(:schools, :css => '.nav-link')
  link(:majors, :css => '.nav-item ~ .nav-item > .nav-link')
  link(:occupations, :css => '.nav-item ~ .nav-item ~ .nav-item > .nav-link')

  span(:schoolsA, :css => '.nav-item .nav-link  > span')
  span(:majorsA, :css => '.nav-item ~ .nav-item  .nav-link  > span')
  span(:occupationsA, :css => '.nav-item ~ .nav-item ~ .nav-item .nav-link  > span')

  ul(:listGroupTopFavorites, :css => '.list-group')
  ul(:listGroupFavoriteSchools, :css => '.list-unstyled')

  button(:searchBut, :css => '.list-group.favorites .btn.btn-default')

  link(:startNow, :css => '.btn.btn-success')

  strong(:newsHeading, :css => '.news-heading')
  p(:readMore, :css => '.news-more')

  i(:favoriteStarMenu, :css => ".grunticon-star.icons-link")
  i(:favoriteStarTable, :css => '.fav .clickable.grunticon-star')

  link(:schoolsMenu, :css => '.nav-item .nav-link')
  link(:scholarshipsMenu, :css => '.nav-item ~ .nav-item  .nav-link')
  link(:majorsMenu, :css => '.nav-item ~ .nav-item ~ .nav-item .nav-link')
  link(:occupationsMenu, :css => '.nav-item ~ .nav-item ~ .nav-item ~ .nav-item .nav-link')


end
