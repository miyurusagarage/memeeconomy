<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8"/>

    <link rel="shortcut icon" href="favicon.ico" type="image/x-icon">
    <link rel="icon" href="favicon.ico" type="image/x-icon">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <meta http-equiv="x-pjax-version" content="v123">

    <title>The Meme Economy</title>

    <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' name='viewport'/>

    <!--     Fonts and icons     -->
    <link rel="stylesheet" type="text/css"
          href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700|Roboto+Slab:400,700|Material+Icons"/>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css"/>

    <!-- CSS Files -->
    <link rel="stylesheet" href="static/css/bootstrap.min.css">
    <link href="static/css/now-ui-kit.css?v=1.1.0" rel="stylesheet"/>
    <link rel='stylesheet' href='static/css/nprogress.css'/>
    <link rel="stylesheet" href="static/css/custom.css">

    <script src="static/js/core/jquery.3.2.1.min.js"></script>


</head>

<body class="index-page">
<!-- Navbar -->
<nav class="navbar navbar-expand-lg bg-primary fixed-top navbar-inverse "  >
    <div class="container">
        <div class="navbar-translate">
            <a class="navbar-brand" href="/" rel="tooltip" href="/" data-pjax="#pjax-container"
                 data-placement="bottom" target="_blank">
                Meme Economy
            </a>
            <button class="navbar-toggler navbar-toggler" type="button" data-toggle="collapse"
                    data-target="#navigation" aria-controls="navigation-index" aria-expanded="false"
                    aria-label="Toggle navigation">
                <span class="navbar-toggler-bar bar1"></span>
                <span class="navbar-toggler-bar bar2"></span>
                <span class="navbar-toggler-bar bar3"></span>
            </button>
        </div>
        <div class="collapse navbar-collapse justify-content-end" id="navigation"
             data-nav-image="./assets/img/blurred-image-1.jpg">
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link  btn btn-light  btn-round" href="/getTopMemes" data-pjax="#pjax-container"  >
                        <p style="color:#333; ">Top Memes</p>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link btn btn-warning btn-round" href="/uploadmeme" data-pjax="#pjax-container"  >
                        <i style="color:#333" class="now-ui-icons arrows-1_share-66"></i>
                        <p style="color:#333">Upload Meme</p>
                    </a>
                </li>




                {{ if .authorized }}
                <li class="nav-item dropdown">
                    <a href="#" class="nav-link dropdown-toggle   btn btn-light  btn-round" id="navbarDropdownMenuLink" data-toggle="dropdown" aria-expanded="false">
                         <p style="color:#333">{{.user.Username}}</p>
                    </a>
                    <div class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdownMenuLink">
                        <a class="dropdown-item" href="/profile" data-pjax="#pjax-container" >
                             Profile
                        </a>
                        <a class="dropdown-item" href="/logout" data-pjax="#pjax-container" >
                            Logout
                        </a>

                    </div>
                </li>
                {{else}}
                <li class="nav-item">
                    <a class="nav-link btn btn-warning btn-round" href="/login" data-pjax="#pjax-container"  >

                        <p style="color:#333">Login</p>
                    </a>
                </li>
                {{end}}
                <li class="nav-item">
                    <a class="nav-link" rel="tooltip" title="Like us on Facebook" data-placement="bottom"
                       href="https://www.facebook.com/CreativeTim" target="_blank">
                        <i class="fa fa-facebook-square"></i>
                        <p class="d-lg-none d-xl-none">Facebook</p>
                    </a>
                </li>

            </ul>
        </div>

    </div>
</nav>
<!-- End Navbar -->
<div class="wrapper" style="margin-top: 65px">
    <div class="main">
        <div class="section section-basic">
            <div class="container" id="pjax-container">
                {{.LayoutContent}}
            </div>
        </div>
    </div>
</div>
<footer class="footer">
    <div class="container text-center">
        <div class="  ">
            &copy;
            <script>document.write(new Date().getFullYear())</script>
            Meme Economy.
        </div>
    </div>
</footer>
</body>

<script src="static/js/core/popper.min.js" type="text/javascript"></script>
<script src="static/js/core/bootstrap.min.js" type="text/javascript"></script>
<!--  Plugin for Switches, full documentation here: http://www.jque.re/plugins/version3/bootstrap.switch/ -->
<script src="static/js/plugins/bootstrap-switch.js"></script>
<!--  Plugin for the Sliders, full documentation here: http://refreshless.com/nouislider/ -->
<script src="static/js/plugins/nouislider.min.js" type="text/javascript"></script>
<!--  Plugin for the DatePicker, full documentation here: https://github.com/uxsolutions/bootstrap-datepicker -->
<script src="static/js/plugins/bootstrap-datepicker.js" type="text/javascript"></script>
<!-- Control Center for Now Ui Kit: parallax effects, scripts for the example pages etc -->
<script src="static/js/now-ui-kit.js?v=1.1.0" type="text/javascript"></script>

<!--page loading-->
<script src='static/js/nprogress.js'></script>
<script src='static/js/pjax-standalone.min.js'></script>
<script src="static/js/pageloading.js"></script>

<!--Inf Scrolling-->
<script src="static/js/infinite-scroll.pkgd.min.js"></script>

<!--Toasts-->
<script src="static/js/iziToast.min.js"></script>
<link rel="stylesheet" href="static/css/iziToast.min.css">


<script type="text/javascript">
    $('.navbar-toggle').click(function () {
        setTimeout(function () {
            $($('.dropdown')[0]).addClass('open')
        }, 500);
    });
    if (location.hash.slice(1) != '') {
        $('#root').load('./parts/' + location.hash.slice(1) + '.html')
    }
    else {
        $('#root').load('./parts/home.html')
    }
    $(window).on('hashchange', function () {
        $('#root').load('./parts/' + location.hash.slice(1) + '.html')
    })
</script>
</html>
