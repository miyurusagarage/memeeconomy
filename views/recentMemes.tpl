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

    </script>
</div>