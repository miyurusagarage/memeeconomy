<div>
    <div class="memecontainer" style=" ">
        <!--data-infinite-scroll='{ "path": "/getmeme?offset={{"{{"}}#{{"}}"}}", "append": ".meme", "history": false , status: ".scroller-status"}'-->
    </div>
    <div class="scroller-status">
        <div class="infinite-scroll-request loader-ellips">
            <span class="loader-ellips__dot"></span>
            <span class="loader-ellips__dot"></span>
            <span class="loader-ellips__dot"></span>
            <span class="loader-ellips__dot"></span>
        </div>
        <p class="infinite-scroll-last text-center">End of content</p>
        <p class="infinite-scroll-error text-center">No memes to load</p>
    </div>

    {{if .user}}
    <!-- Modal Core -->
    <div class="modal fade" id="investModal" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog">
            <form action="/investmeme" method="get" id="investSubmitForm">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title" id="myModalLabel">Invest in this meme!</h4>
                    </div>
                    <div class="modal-body">
                        <input name="memeId" value="" id="memeId" type="hidden"/>
                        <div class="col-sm-12">
                            <p>You have <strong><span name="availableFlurbos">{{ .user.CurrentCredit }}</span> Flurbos</strong></p>

                            <p>Enter the amount of Flurbos you want to invest:</p>


                            <div class="form-group">

                                <input type="number" id="investAmount" name="amount" placeholder="enter the amount" required
                                       class="form-control">
                            </div>
                            <div class="form-group">

                               <p class="text-warning" style="display: none;" id="flurbowarning">Insufficient flurbos! Enter a value less than <span name="availableFlurbos">{{ .user.CurrentCredit }}</span></p>
                            </div>

                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default btn-simple " data-color="popover-info"
                                data-toggle="popover" data-placement="left" title="Meme Investing"
                                data-content="Mung beans smell like death -Creed">What's this?
                        </button>
                        <button type="submit" class="btn btn-primary btn-simple " id="btn-submit-investment">Submit Investment</button>

                    </div>

                </div>
            </form>
        </div>
    </div>
{{end}}
    <script>
        $(document).ready(function () {
            $('.memecontainer').infiniteScroll({
                path: '/{{.blockFetchUrl}}?offset={{"{{"}}#{{"}}"}}&time={{.time}}',
                append: '.meme',
                status: '.scroller-status',
                history: false,
                checkLastPage: true
            });
            $('.memecontainer').infiniteScroll('loadNextPage')
        })


        //heart animation
        var activeClassName = 'active',
            likedClassName = 'liked';


        function addClass(domObj, className) {
            if (domObj) {
                domObj.className += ' ' + className;
            }
        }

        function removeClass(domObj, className) {
            if (domObj) {
                if (domObj.classList) {
                    domObj.classList.remove(className);
                } else {
                    domObj.className = domObj.className.replace(new RegExp('(^|\\b)' + className.split(' ').join('|') + '(\\b|$)', 'gi'), ' ');
                }
            }
        }

        function attachHeartAnimations(key, isAuthorized, userKey) {

            var imgContainer = $("#meme-img-container" + key),
                theHeartImage = $("#js-heart-image" + key),
                likedHeart = $("#liked-heart" + key),
                likeValue = $("#like-value" + key),
                worthValue = $("#worth-value" + key);

            if (isAuthorized=='true') {
                imgContainer.on('click', function () {
                    if (!imgContainer.hasClass(likedClassName)) {
                        imgContainer.removeClass(activeClassName)
                        imgContainer.addClass(activeClassName)
                        imgContainer.addClass(likedClassName)
                        likedHeart.addClass(likedClassName)
                        likeValue.text(function (i, oldVal) {
                            return parseInt(oldVal, 10) + 1;
                        });
                        worthValue.text(function (i, oldVal) {
                            return parseInt(oldVal, 10) + 1;
                        });

                        $.ajax({
                            url: "/votememe",
                            type: "get",
                            data: {
                                type: 'up',
                                memeId: key
                            }
                        });
                    }else{
                        imgContainer.removeClass(likedClassName)
                        likedHeart.removeClass(likedClassName)
                        likeValue.text(function (i, oldVal) {
                            return parseInt(oldVal, 10) - 1;
                        });
                        worthValue.text(function (i, oldVal) {
                            return parseInt(oldVal, 10) - 1;
                        });
                        $.ajax({
                            url: "/votememe",
                            type: "get",
                            data: {
                                type: 'down',
                                memeId: key
                            }
                        });
                    }
                });
                likedHeart.on('click', function (event ) {
                    event.stopPropagation();
                    if (likedHeart.hasClass(likedClassName)) {
                        imgContainer.removeClass(likedClassName)
                        likedHeart.removeClass(likedClassName)
                        likeValue.text(function (i, oldVal) {
                            return parseInt(oldVal, 10) - 1;
                        });
                        worthValue.text(function (i, oldVal) {
                            return parseInt(oldVal, 10) - 1;
                        });
                        $.ajax({
                            url: "/votememe",
                            type: "get",
                            data: {
                                type: 'down',
                                memeId: key
                            }
                        });
                    }else{
                        imgContainer.removeClass(activeClassName)
                        imgContainer.addClass(activeClassName)
                        imgContainer.addClass(likedClassName)
                        likedHeart.addClass(likedClassName)
                        likeValue.text(function (i, oldVal) {
                            return parseInt(oldVal, 10) + 1;
                        });
                        worthValue.text(function (i, oldVal) {
                            return parseInt(oldVal, 10) + 1;
                        });
                        $.ajax({
                            url: "/votememe",
                            type: "get",
                            data: {
                                type: 'up',
                                memeId: key
                            }
                        });
                    }
                });
            }

            theHeartImage.on('transitionend', function () {
                imgContainer.removeClass(activeClassName)
            });

            theHeartImage.on('webkitTransitionEnd', function () {
                imgContainer.removeClass(activeClassName)
            });
        }


        $(document).on("click", ".btn-invest", function () {
            var memeId = $(this).data('id');
            $(".modal-body #memeId").val(memeId);
        });

        $(document).on("click", ".btn-share", function () {
            var memeId = $(this).data('id');
            var siteUrl =  {{.siteUrl}}
            FB.ui({
                method: 'share',
                href: siteUrl + '/getmemesingle?memeid=' + memeId,
            }, function(response){});
        });

        {{if .user }}
        $('#investAmount').on('input',function(e){
           if(parseInt(e.target.value, 10)>parseInt('{{.user.CurrentCredit }}',10)){
                $("#btn-submit-investment").prop( "disabled", true );
                $('#flurbowarning').show()
           }else{
               $("#btn-submit-investment").prop( "disabled", false );
               $('#flurbowarning').hide()
           }
        });
        {{end}}
        $("#investSubmitForm").submit(function (event) {

            /* stop form from submitting normally */
            event.preventDefault();

            /* get the action attribute from the <form action=""> element */
            var $form = $(this),
                url = $form.attr('action');
    var key = $('#memeId').val()
            /* Send the data using post with element id name and name2*/
            $.ajax({
                url: url,
                type: "get",
                data: {
                    amount: $('#investAmount').val(),
                    memeId: key
                },
                success: function (result) {
                    iziToast.success({
                        id: 'error',
                        zindex: 9000,
                        layout: 1,
                        title: 'Yaay!',
                        message:  'Investment was successful.',
                        position: 'bottomRight',
                        transitionIn: 'bounceInLeft',
                    });
                    $('span[name=availableFlurbos]').text(function (i, oldVal) {
                        return parseInt(oldVal, 10) - parseInt($('#investAmount').val(),10)
                    });

                    $('#user-current-credit').text(function (i, oldVal) {
                        return parseInt(oldVal, 10) - parseInt($('#investAmount').val(),10)
                    })

                    $("#worth-value" + key).text(function (i, oldVal) {
                        return parseInt(oldVal, 10) + parseInt($('#investAmount').val(),10)
                    });

                    $('#meme-flurbos'+key).text(function (i, oldVal) {
                        return parseInt(oldVal, 10) + parseInt($('#investAmount').val(),10)
                    });
                },
                error: function (result) {
                    iziToast.warning({
                        id: 'error',
                        zindex: 9000,
                        layout: 1,
                        title: 'Whoops!',
                        message: result.responseJSON.Error + '! Cannot complete the transaction.',
                        position: 'bottomRight',
                        transitionIn: 'bounceInLeft',
                    });
                    console.log()
                }

            });

            $('#investModal').modal('toggle');

        });

    </script>
</div>