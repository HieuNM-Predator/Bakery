</div>
<!--END MAIN CONTENT-->

    <div class="footer navbar-fixed-bottom">
        <div class="container-fluid bg-dark">
            <div class="row text-center">
                <div class="col-md-6">
                    <p>Copyrights © 2023 - <a href="#">Fresh Garden</a>, All Rights Reserved.</p>
                </div>
                <div class="col-md-6 logo_social">
                    <a href="#" class="social_net"> 
                        <i class="fa-brands fa-facebook-f"></i>
                    </a>
                    <a href="#" class="social_net"> 
                        <i class="fa-brands fa-twitter"></i>
                    </a>
                    <a href="#" class="social_net"> 
                        <i class="fa-brands fa-instagram"></i>
                    </a>
                    <a href="#" class="social_net"> 
                        <i class="fa-brands fa-linkedin-in"></i>
                    </a>  
                </div>
            </div>
        </div>
    </div>
    <!-- END FOOTER -->

<!--            <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ" crossorigin="anonymous"></script>
    <script>
    $(function()
        {
            $('#confirm-delete').on('show.bs.modal', function(e){
            $(this).find('.btn-delete').attr('href', $(e.relatedTarget).data('href'));
            });
        });
    </script>-->
    <script>
        $(function(){
            $('#confirm-delete').on('shown.bs.modal', function (event) {
                $(this).find('.btn-delete').attr('href', $(event.relatedTarget).data('href'));
            })
        })
    </script>
</body>
</html>