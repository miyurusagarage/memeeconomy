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
    <!-- Global site tag (gtag.js) - Google Analytics -->
    <script async src="https://www.googletagmanager.com/gtag/js?id=UA-108226507-1"></script>
    <script>
        window.dataLayer = window.dataLayer || [];
        function gtag(){dataLayer.push(arguments);}
        gtag('js', new Date());

        gtag('config', 'UA-108226507-1');
    </script>


</head>

<body class="index-page">
<!-- Navbar -->
<nav class="navbar navbar-expand-lg bg-primary fixed-top navbar-inverse "  >
    <div class="container">
        <div class="navbar-translate">
            <a class="navbar-brand" href="/" rel="tooltip" href="/" data-pjax="#pjax-container"
                 data-placement="bottom" target="_blank">
                <img src="static/img/logoxs.png" style="margin-right: 16px;width: 30px;margin-top: -7px;">
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
                    <a class="nav-link    "href="/leaderboard" data-pjax="#pjax-container"  >
                        <p >Top Users</p>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link    " href="/getTopMemes" data-pjax="#pjax-container"  >
                        <p >Top Memes</p>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link   " href="/uploadmeme" data-pjax="#pjax-container"  >
                        <i  class="now-ui-icons arrows-1_share-66"></i>
                        <p >Upload Meme</p>
                    </a>
                </li>
                {{ if .authorized }}
                <li class="nav-item dropdown">
                    <a href="#" class="nav-link dropdown-toggle      " id="navbarDropdownMenuLink" data-toggle="dropdown" aria-expanded="false">
                        <p >{{.user.Username}} <i class="fa fa-money" style="margin-left: 10px" aria-hidden="true"></i>  <span id="user-current-credit">{{.user.CurrentCredit}}</span></p>
                    </a>
                    <div class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdownMenuLink">
                        <a class="dropdown-item" href="/profile" data-pjax="#pjax-container" >
                             Profile
                        </a>
                        <a class="dropdown-item" href="/transactions" data-pjax="#pjax-container" >
                            Transactions
                        </a>
                        <a class="dropdown-item" href="/logout">
                            Logout
                        </a>

                    </div>
                </li>
                {{else}}
                <li class="nav-item">
                    <a class="nav-link   " href="/login" data-pjax="#pjax-container"  >

                        <p  >Login</p>
                    </a>
                </li>
                {{end}}
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
{{if .user}}
<div class="modal fade" id="usernamePromptModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <form action="/setusername" method="get" id="usernameSubmitForm">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">Enter your Username!</h4>
                </div>
                <div class="modal-body">
                    <input name="userId" value={{.user.Key.Name}} id="userId" type="hidden"/>
                    <div class="col-sm-12">

                        <div class="form-group">

                            <input type="text" id="username" name="amount" placeholder="Enter your Username" required
                                   value="{{.user.Username}}"
                                   class="form-control">
                        </div>
                        <div class="form-group">
                            <p class="text-warning" style="display: none;" id="username-warning">That username is already taken</p>
                        </div>

                    </div>
                </div>
                <div class="modal-footer">
                    <p></p>
                    <button type="button" id="usernameFormBtn" class="btn btn-primary btn-simple">Save</button>
                </div>

            </div>
        </form>
    </div>
</div>
{{end}}
<footer class="footer">

    <div class="container text-center">
        <a class="  btn btn-neutral btn-icon btn-facebook btn-round btn-lg"
           href="https://www.facebook.com/TheMemeEconomy123/" target="_blank">
            <i class="fa fa-facebook-square"></i>
            <p class="d-lg-none d-xl-none">Facebook</p>
        </a>
        <div>
           <a href="/privacy-policy" target="_blank">Privacy Policy</a> | <a href="http://intellogic.lk" target="_blank">About Us</a>
        </div>
        <div class="  ">
            &copy;
            <script>document.write(new Date().getFullYear())</script>
            Meme Economy.
        </div>
    </div>
</footer>
</body>

<div id="fb-root"></div>
<script>(function(d, s, id) {
    var js, fjs = d.getElementsByTagName(s)[0];
    if (d.getElementById(id)) return;
    js = d.createElement(s); js.id = id;
    js.src = "//connect.facebook.net/en_US/sdk.js#xfbml=1&version=v2.10&appId=2004145103163067";
    fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));</script>

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

{{ if .authorized }}
<script type="text/javascript">
    var usernamePromptShown = {{.user.UsernamePromptShown}}
    if(!usernamePromptShown){
        $('#usernamePromptModal').modal().show()
        $('#usernameFormBtn').on('click', function () {
            $.ajax('/setusername', {data: {userId: $('#userId').val(), username : $('#username').val()}}).done(function () {
                $('#usernamePromptModal').modal('toggle')
                iziToast.success({
                    id: 'success',
                    zindex: 9000,
                    layout: 1,
                    title: 'Yaay!',
                    message:  'Username was updated.',
                    position: 'bottomRight',
                    transitionIn: 'bounceInLeft'
                });
            }).fail(function (data, status) {
                if(status = 400){
                    $('#username-warning').show()
                }
            })
        });
        $('#username').on('keyup', function () {
            $('#username-warning').hide()
        })
    }
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
{{end}}
</html>
