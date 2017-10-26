<div>
    <div class="col-md-12 fblike-box">
        <div class="fb-like" data-href="https://www.facebook.com/TheMemeEconomy123/" data-layout="standard" data-action="like" data-size="large" data-show-faces="true" data-share="true"></div>
    </div>
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
    {{template "investModal.tpl" .user}}
    {{end}}
    <script>
        $(document).ready(function () {
            $('.memecontainer').infiniteScroll({
                path: '/{{.blockFetchUrl}}?offset={{"{{"}}#{{"}}"}}&time={{.time}}',
                append: '.memeobj',
                status: '.scroller-status',
                history: false,
                checkLastPage: true,
                scrollThreshold: 1000,
                prefill: false,
                loadOnScroll: true,
            });
            $('.memecontainer').infiniteScroll('loadNextPage')
            var memeTipsShown = false;
            $('.memecontainer').on('append.infiniteScroll', function (event, response, path) {
                if (user && !user.MemeTipsShown && !memeTipsShown) {
                    memeTipsShown = true;
                    var tour = {
                        id: "memeTips",
                        steps: [
                            {
                                title: "Like Memes?",
                                content: "Click on the image to like or dislike",
                                target: $(".meme-likes")[0],
                                placement: "right"
                            },
                            {
                                title: "Such worth, Much Wow",
                                content: "The worth is increased from likes, facebook shares and likes",
                                target: $(".sidebar-block")[0],
                                placement: "left"
                            },
                            {
                                title: "Invest and Earn",
                                content: "By investing in this meme you can gain flurbos as the meme worth increases over time.",
                                target: $(".sidebar-block")[1],
                                placement: "left"
                            }
                        ]
                    };
                    hopscotch.startTour(tour);
                    $(".like-icon").one('click', function () {
                        if (hopscotch.getCurrStepNum() == 0) {
                            hopscotch.nextStep()
                        }
                    });
                    $(".meme-img").one('click', function () {
                        if (hopscotch.getCurrStepNum() == 0) {
                            hopscotch.nextStep()
                        }
                    })
                }
            });

        })
    </script>
</div>