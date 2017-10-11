<div class="memecontainer" style=" "
     data-infinite-scroll='{ "path": "/getmeme?offset={{"{{"}}#{{"}}"}}", "append": ".meme", "history": false }'>

</div>


<script>
    $(document).ready(function () {
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

    function attachHeartAnimations(key) {
        var imgContainer = $("#meme-img-container" + key),
            theHeartImage = $("#js-heart-image" + key),
            likedHeart = $("#liked-heart" + key),
            likeValue = $("#like-value" + key);

        imgContainer.on('click', function () {
            if(!imgContainer.hasClass(likedClassName)){
                imgContainer.removeClass(activeClassName)
                imgContainer.addClass(activeClassName)
                imgContainer.addClass(likedClassName)
                likedHeart.addClass(likedClassName)
                likeValue.text(function(i,oldVal){
                    return parseInt(oldVal,10) + 1 ;
                });
            }
        });

        theHeartImage.on('transitionend', function () {
            imgContainer.removeClass(activeClassName)
        });

        theHeartImage.on('webkitTransitionEnd', function () {
            imgContainer.removeClass(activeClassName)
        });
    }

</script>