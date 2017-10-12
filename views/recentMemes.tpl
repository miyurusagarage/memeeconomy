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
        <p class="infinite-scroll-last">End of content</p>
        <p class="infinite-scroll-error">No memes to load</p>
    </div>
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
                            <p>You have <strong>1000 Flurbos</strong></p>

                            <p>Enter the amount of Flurbos you want to invest:</p>


                            <div class="form-group">

                                <input type="number" id="investAmount" name="amount" placeholder="enter the amount"
                                       class="form-control">
                            </div>

                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default btn-simple " data-color="popover-info"
                                data-toggle="popover" data-placement="left" title="Meme Investing"
                                data-content="Mung beans smell like death -Creed">What's this?
                        </button>
                        <button type="submit" class="btn btn-primary btn-simple ">Submit Investment</button>

                    </div>

                </div>
            </form>
        </div>
    </div>

    <script>
        $(document).ready(function () {
            $('.memecontainer').infiniteScroll({
                path: '/getmeme?offset={{"{{"}}#{{"}}"}}',
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
                likeValue = $("#like-value" + key);

            if (isAuthorized) {
                imgContainer.on('click', function () {
                    if (!imgContainer.hasClass(likedClassName)) {
                        imgContainer.removeClass(activeClassName)
                        imgContainer.addClass(activeClassName)
                        imgContainer.addClass(likedClassName)
                        likedHeart.addClass(likedClassName)
                        likeValue.text(function (i, oldVal) {
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

        $("#investSubmitForm").submit(function (event) {

            /* stop form from submitting normally */
            event.preventDefault();

            /* get the action attribute from the <form action=""> element */
            var $form = $(this),
                url = $form.attr('action');

            /* Send the data using post with element id name and name2*/
            $.ajax({
                url: url,
                type: "get",
                data: {
                    amount: $('#investAmount').val(),
                    memeId: $('#memeId').val()
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