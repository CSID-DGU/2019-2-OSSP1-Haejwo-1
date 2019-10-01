"use strict";
var routes = [
  {
    path: '/',
    Url: './index.html',
  },

  {
    path: '/accordion/',
    url: './accordion.html',
  },

  {
    path: '/badge/',
    url: './badge.html',
  },

  {
    path: '/buttons/',
    url: './buttons.html',
  },

  {
    path: '/cards/',
    url: './cards.html',
  },

  {
    path: '/cards-expandable/',
    url: './cards-expandable.html',
  },

  {
    path: '/tags/',
    componentUrl: './tags.html',
  },

  {
    path: '/contact-list/',
    url: './contact-list.html',
  },

  {
    path: '/form-elements/',
    url: './form-elements.html',
  },

  {
    path: '/grid-system/',
    url: './grid-system.html',
  },

  {
    path: '/lazy-load/',
    componentUrl: './lazy-load.html',
  },

  {
    path: '/list-view/',
    url: './list-view.html',
  },

  {
    path: '/menu/',
    url: './menu.html',
  },

  {
    path: '/navbar/',
    url: './navbar.html',
  },

  {
    path: '/static-navbar/',
    url: './static-navbar.html',
  },

  {
    path: '/fixed-navbar/',
    url: './fixed-navbar.html',
  },

  {
    path: '/navbar-large-title/',
    url: './navbar-large-title.html',
  },

  {
    path: '/navbar-hide-on-scroll/',
    url: './navbar-hide-on-scroll.html',
  },

  {
    path: '/popover/',
    url: './popover.html',
  },

  {
    path: '/popup/',
    url: './popup.html',
  },

  {
    path: '/preloader/',
    url: './preloader.html',
  },

  {
    path: '/searchbar/',
    url: './searchbar.html',
  },

  {
    path: '/searchbar-expandable/',
    url: './searchbar-expandable.html',
  },

  {
    path: '/smart-select/',
    url: './smart-select.html',
  },

  {
    path: '/sortable/',
    url: './sortable.html',
  },

  {
    path: '/subnavbar/',
    url: './subnavbar.html',
  },

  {
    path: '/subnavbar-title/',
    url: './subnavbar-title.html',
  },

  {
    path: '/subnavbar-tabs/',
    url: './subnavbar-tabs.html',
  },

  {
    path: '/swipeout/',
    componentUrl: './swipeout.html',
  },

  {
    path: '/swiper-slider/',
    url: './swiper-slider.html',
  },

  {
    path: '/swiper-with-pagination/',
    url: './swiper-with-pagination.html',
  },

  {
    path: '/swiper-horizontal/',
    url: './swiper-horizontal.html',
  },

  {
    path: '/swiper-vertical/',
    url: './swiper-vertical.html',
  },

  {
    path: '/swiper-space-between/',
    url: './swiper-space-between.html',
  },

  {
    path: '/swiper-overlap/',
    url: './swiper-overlap.html',
  },

  {
    path: '/swiper-infinite-loop/',
    url: './swiper-infinite-loop.html',
  },

  {
    path: '/swiper-fade-effect/',
    url: './swiper-fade-effect.html',
  },

  {
    path: '/tabs/',
    url: './tabs.html',
  },

  {
    path: '/static-tabs/',
    url: './static-tabs.html',
  },

  {
    path: '/animated-tabs/',
    url: './animated-tabs.html',
  },

  {
    path: '/swipeable-tabs/',
    url: './swipeable-tabs.html',
  },

  {
    path: '/timeline/',
    url: './timeline.html',
  },

  {
    path: '/toast/',
    componentUrl: './toast.html',
  },

  {
    path: '/toggle/',
    url: './toggle.html',
  },

  {
    path: '/toolbar-tabbar/',
    url: './toolbar-tabbar.html',
  },

  {
    path: '/static-toolbar/',
    url: './static-toolbar.html',
  },

  {
    path: '/fixed-toolbar/',
    url: './fixed-toolbar.html',
  },

  {
    path: '/toolbar-hide-on-scroll/',
    url: './toolbar-hide-on-scroll.html',
  },

  {
    path: '/tabbar-with-labels/',
    url: './tabbar-with-labels.html',
  },

  {
    path: '/scrollable-tabbar/',
    url: './scrollable-tabbar.html',
  },

  {
    path: '/tooltip/',
    url: './tooltip.html',
  },




  {
    path: '/about-me/',
    url: './about-me.html',
  },
  
  {
    path: '/about-us/',
    url: './about-us.html',
  },

  {
    path: '/contact-us/',
    url: './contact-us.html',
  },

  {
    path: '/coming-soon/',
    url: './coming-soon.html',
  },

  {
    path: '/embeds/',
    url: './embeds.html',
  },

  {
    path: '/faq/',
    url: './faq.html',
  },

  {
    path: '/features/',
    url: './features.html',
  },

  {
    path: '/forum/',
    url: './forum.html',
  },

  {
    path: '/forum-single/',
    url: './forum-single.html',
  },

  {
    path: '/gallery/',
    url: './gallery.html',
  },

  {
    path: '/maintenance/',
    url: './maintenance.html',
  },

  {
    path: '/maps/',
    url: './maps.html',
  },

  {
    path: '/page-not-found/',
    url: './page-not-found.html',
  },

  {
    path: '/portfolio/',
    url: './portfolio.html',
  },

  {
    path: '/pricing-table/',
    url: './pricing-table.html',
  },

  {
    path: '/profile/',
    url: './profile.html',
  },

  {
    path: '/profile-edit/',
    url: './profile-edit.html',
  },

  {
    path: '/reservation/',
    url: './reservation.html',
  },

  {
    path: '/reset-password/',
    url: './reset-password.html',
  },

  {
    path: '/searchbar/',
    url: './searchbar.html',
  },

  {
    path: '/services/',
    url: './services.html',
  },

  {
    path: '/settings/',
    url: './settings.html',
  },

  {
    path: '/sign-in/',
    url: './sign-in.html',
  },

  {
    path: '/sign-up/',
    url: './sign-up.html',
  },

  {
    path: '/skill/',
    url: './skill.html',
  },

  {
    path: '/team/',
    url: './team.html',
  },

  {
    path: '/testimonial/',
    url: './testimonial.html',
  },


  {
    path: '/home-shop/',
    url: './home-shop.html',
  },

  {
    path: '/product/',
    url: './product.html',
  },

  {
    path: '/product-details/',
    componentUrl: './product-details.html',
  },

  {
    path: '/cart/',
    url: './cart.html',
  },

  {
    path: '/checkout/',
    url: './checkout.html',
  },

  {
    path: '/categories/',
    url: './categories.html',
  },

  {
    path: '/order-history/',
    url: './order-history.html',
  },

  {
    path: '/tracking-order/',
    url: './tracking-order.html',
  },

  {
    path: '/wishlist/',
    componentUrl: './wishlist.html',
  },

  {
    path: '/account-buyer/',
    url: './account-buyer.html',
  },

  {
    path: '/account-seller/',
    url: './account-seller.html',
  },



  {
    path: '/home-blog/',
    url: './home-blog.html',
  },

  {
    path: '/home-blog-list/',
    url: './home-blog-list.html',
  },

  {
    path: '/blog-grid/',
    url: './blog-grid.html',
  },

  {
    path: '/blog-list/',
    url: './blog-list.html',
  },

  {
    path: '/blog-single/',
    url: './blog-single.html',
  },

  {
    path: '/blog-single-gallery/',
    url: './blog-single-gallery.html',
  },

  {
    path: '/blog-single-video/',
    url: './blog-single-video.html',
  },


];
