{{ $showRank  := .showRank }}
{{ $authorized1  := .authorized }}
{{ $userKey1  := .userKey }}
{{ $voteMap  := .voteMap }}
{{ $memeUsers  := .memeUsers }}
{{ range $mm  := .data }}

<div class="meme" style=" ">


    <div class="row" style="position: relative;">
        <div class="meme-title col-md-10">
            <div class="col-md-10">
                <h4 style="    margin-top: 12px;">{{$mm.Title}}</h4>
                <a href="/profile?id={{$mm.CreatedUserId}}"><p class="meme-description" style="margin-top: -20px;">by
                    {{(index $memeUsers $mm.CreatedUserId).Username}}</p></a>
            </div>
        </div>
        <div class="col-md-10 meme-img-container col-sm-12 {{  index $voteMap $mm.Key.Name  }}"
             id="meme-img-container{{$mm.Key.Name}}">
            <p class="meme-likes">
                <i class="fa fa-heart like-icon {{  index $voteMap $mm.Key.Name  }}" aria-hidden="true"
                   id="liked-heart{{$mm.Key.Name}}"></i>
            </p>
            <img class='meme-img '
                 src='{{$mm.ImagePath}}'
                 onload="attachHeartAnimations('{{$mm.Key.Name}}',{{ $authorized1 }},'{{ $userKey1 }}' );"/>
            <div class="heart-container">
                <img src="data:image/svg+xml;base64,PHN2ZyB2ZXJzaW9uPSIxLjEiIGlkPSJMYXllcl8xIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHhtbG5zOnhsaW5rPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hsaW5rIiB4PSIwcHgiIHk9IjBweCINCgkgd2lkdGg9IjEwMHB4IiBoZWlnaHQ9Ijg3LjVweCIgdmlld0JveD0iMCAwIDEwMCA4Ny41IiBlbmFibGUtYmFja2dyb3VuZD0ibmV3IDAgMCAxMDAgODcuNSIgeG1sOnNwYWNlPSJwcmVzZXJ2ZSI+DQo8cGF0aCBmaWxsPSIjRkZGRkZGIiBkPSJNNTAsMTkuMUMzNy0xMS4yLDAuMi00LjEsMCwzMS4xYy0wLjEsMTkuMyw0OC44LDUyLjEsNTAuMSw1Ni40YzEuMS00LjMsNTAuMS0zNy4zLDUwLTU2LjYNCglDOTkuOC00LjQsNjIuMy0xMCw1MCwxOS4xeiIvPg0KPC9zdmc+DQo="
                     alt="heart" id="js-heart-image{{$mm.Key.Name}}"/>
            </div>
        </div>
        <div class="col-md-2 col-xs-2  col-sm-2 sidebar  hidden-sm-down hidden-xs">
            <div class="">
                {{ if $showRank }}
                <div class="sidebar-block">
                    <h5 class="sidebar-caption">Meme Rank</h5>
                    <h3 class="sidebar-value">#1</h3>
                </div>
                {{ end }}
                <div class="sidebar-block">
                    <h5 class="sidebar-caption">Worth</h5>
                    <h3 class="sidebar-value" style="float: left"  id="worth-value{{$mm.Key.Name}}">{{ $mm.TotalFame }} </h3><i
                        style="margin-left: 5px;margin-top: 9px;font-size: 18px" class="fa fa-star"
                        aria-hidden="true"></i>
                </div>
                <div class="sidebar-block">
                    <h5 class="sidebar-caption">Investments</h5>
                    <h3 class="sidebar-value" id="meme-flurbos{{$mm.Key.Name}}" style="float: left">
                        {{$mm.CurrentInvestments }}</h3>
                    <p style="font-size: 22px;display: inline;margin-left: 5px;">ƒ</p>
                </div>
                <div class="sidebar-block">
                    <h5 class="sidebar-caption">Likes</h5>
                    <div class="sidebar-value" style="margin-bottom: 0"><i
                            class="fa fa-facebook-square pull-left fb-likes"></i><h4 class="like-counter">
                        {{$mm.SocialLikes }}</h4></div>
                    <div class="sidebar-value" style="margin-bottom: 0">
                        <img  style="float: left;width: 23px;" src="static/img/logoxs.png"></img><h4 id="like-value{{$mm.Key.Name}}" class="like-counter">
                        {{$mm.InternalLikes }}</h4></div>
                </div>
                <div class="sidebar-block">
                    <h5 class="sidebar-caption">Share</h5>

                    <button class="btn btn-neutral btn-icon btn-facebook btn-round btn-lg btn-share btn-block btn-share"
                            style=""
                            data-id={{$mm.Key.Name}}>
                        <i class="fa fa-facebook-square" style="left: 30px;"></i>
                        <p>{{$mm.SocialShares}}</p>
                    </button>
                </div>

                {{ if and $authorized1 $mm.CanInvest }}
                <button class="btn btn-default btn-block btn-lg btn-invest" style="background-color: #424242;"
                        data-id="{{$mm.Key.Name}}"
                        data-toggle="modal" data-target="#investModal">
                    Invest
                </button>
                {{end}}

                {{ if and $authorized1 $mm.IsExpired }}
                <button class="btn btn-default btn-block btn-lg btn-invest" style="background-color: #424242;" disabled>
                    Invest
                </button>
                {{end}}

            </div>
        </div>
    </div>
    <script>
        alert("SSS")
        $(document).ready(function () {
            $('[data-toggle="popover"]').popover()
    </script>

</div>
{{ end }}



