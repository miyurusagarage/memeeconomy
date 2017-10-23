<div class="container" style=" ">

    <h2>Profile</h2>
    <div>
        <span>
            <h4 id="profile-username" style="margin-top: -20px; display: inline-block;">{{.userData.Username}} </h4>
            <a href="#" data-target="#usernamePromptModal" data-toggle="modal" style="font-size: 18px;margin-left:10px"> <i class="fa fa-pencil"></i></a>
        </span>
    </div>
    <hr/>
    <div class="row">
        <div class="col-md-3 col-sm-12 profileStatBox">
            <h2>Rank</h2>
            <i class="fa fa-hashtag stat-icon" aria-hidden="true"></i>
            <h4>#{{.userRank}}</h4>
        </div>
        <div class="col-md-3 col-sm-12 profileStatBox">
            <h2>Posts</h2>
            <i class="fa fa-picture-o stat-icon" aria-hidden="true"></i>
            <h4>{{.userPosts}}</h4>
        </div>
        <div class="col-md-3 col-sm-12 profileStatBox">
            <h2>Credit</h2>
            <i class="fa fa-money stat-icon" aria-hidden="true"></i>
            <h4>{{.userData.CurrentCredit}}</h4>
        </div>
    </div>

    <div>
        <h2 style="margin-top: 20px">Memes Posted</h2>
        <hr/>
        <div class="memecontainer usermemes" style=" ">
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
            <p class="infinite-scroll-error text-center">No more memes to load</p>
        </div>
        {{if .user}}
        {{template "investModal.tpl" .user}}
        {{end}}
        <script>
            $(document).ready(function () {
                $('.memecontainer').infiniteScroll({
                    path: '/getmemesforuser?offset={{"{{"}}#{{"}}"}}&id={{.userData.Key.Name}}',
                    append: '.meme',
                    status: '.scroller-status',
                    history: false,
                    checkLastPage: true
                });
                $('.memecontainer').infiniteScroll('loadNextPage')
            })
        </script>
        <script src="/static/js/meme-operations.js" type="text/javascript"></script>
    </div>
</div>

