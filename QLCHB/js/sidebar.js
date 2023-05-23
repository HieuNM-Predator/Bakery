$(function(){
   //  Khi click nutMenu
   $('.nutMenu').click(function(){
       $('.menuTrai').addClass('truotRa')
       return false
   })

   // Khi click nut anMenu để ẩn menu
   $('.anMenu').click(function() {
       $('.menuTrai').removeClass('truotRa')
       return false
   })
})