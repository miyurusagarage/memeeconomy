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
        {{template "investModal.tpl" .user}}
    {{end}}
    <script>
        $(document).ready(function () {
            $('.memecontainer').infiniteScroll({
                path: '/{{.blockFetchUrl}}?offset={{"{{"}}#{{"}}"}}&time={{.time}}',
                append: '.meme',
                status: '.scroller-status',
                history: false,
                checkLastPage: true,
                scrollThreshold: 400
            });
            $('.memecontainer').infiniteScroll('loadNextPage')
        })
    </script>
    <script src="/static/js/meme-operations.js" type="text/javascript"></script>
</div>