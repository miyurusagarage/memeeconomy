{{ $showRank  := .showRank }}
{{ $authorized1  := .authorized }}
{{ $userKey1  := .userKey }}
{{ $voteMap  := .voteMap }}
{{ $memeUsers  := .memeUsers }}
{{ $isSingleMeme  := .isSingleMeme }}
{{ range $mm  := .data }}

<div class="meme" style=" ">
    <div class="row" style="position: relative;">
        <div class="meme-title col-md-10">
            <div class="col-md-12">
                <div style="float: left">
                    <a href="/getmemesingle?memeid={{$mm.Key.Name}}" data-pjax="#pjax-container"><h4 style="margin-top: 12px;">{{$mm.Title}}</h4>
                    </a>
                    <a href="/profile?id={{$mm.CreatedUserId}}"><p class="meme-description" data-pjax="#pjax-container" style="margin-top: -20px;">
                        by
                        {{(index $memeUsers $mm.CreatedUserId).Username}}</p></a>
                </div>
                <p class="days-left">{{$mm.DaysToExpire}}</p>
            </div>
        </div>

        <div class="col-md-12 col-lg-10 col-xl-10 meme-img-container col-sm-12 {{  index $voteMap $mm.Key.Name  }}"
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
            <div class="image-controls-strip">
                <a class="pull-right" style="color: white" href="/getmemesingle?memeid={{$mm.Key.Name}}" data-pjax="#pjax-container" onclick="event.stopPropagation();" >
                    Comments
                </a>
            </div>
        </div>

        <div class="col-md-2 col-xs-2  col-sm-2 sidebar   ">
            <div class="">
                {{ if $showRank }}
                <div class="sidebar-block">
                    <h5 class="sidebar-caption">Meme Rank</h5>
                    <h3 class="sidebar-value">#1</h3>
                </div>
                {{ end }}
                <div class="sidebar-block">
                    <h5 class="sidebar-caption">Worth</h5>
                    <h3 class="sidebar-value" style="float: left" name="worth-value{{$mm.Key.Name}}">{{ $mm.TotalFame}} </h3><i
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
                        <img style="float: left;width: 23px;" src="static/img/logoxs.png"></img><h4
                            id="like-value{{$mm.Key.Name}}" class="like-counter">
                        {{$mm.InternalLikes }}</h4></div>
                </div>
                <div class="sidebar-block">
                    <h5 class="sidebar-caption">Share</h5>

                    <button class="btn btn-neutral btn-icon btn-facebook btn-round btn-share btn-block btn-share"
                            style=""
                            data-id={{$mm.Key.Name}}>
                        <i class="fa fa-facebook-square" style="left: 30px;"></i>
                        <p>{{$mm.SocialShares}}</p>
                    </button>
                </div>

                {{ if $mm.CanInvest }}
                <button class="btn btn-default btn-block btn-invest" style="background-color: #f96332;"
                        data-id="{{$mm.Key.Name}}">
                    Invest
                </button>
                {{end}}

                {{ if and $authorized1 $mm.IsExpired }}
                <button class="btn btn-default btn-block  btn-invest" style="background-color: #424242;" disabled>
                    Invest
                </button>
                {{end}}

            </div>
        </div>


        <!--mobile strip-->
        <div class="col-xs-12 mobile-control-strip d-lg-none d-xl-none ">
            <div class="">
                <div class="mobile-control-block mobile-control-left mobile-control-first">
                    <h5 class="mobile-control-caption">Worth</h5>
                    <h3 class="mobile-control-value" style="float: left" name="worth-value{{$mm.Key.Name}}">{{ $mm.TotalFame}} </h3><i
                        style="margin-left: 5px;margin-top: 9px;font-size: 18px" class="fa fa-star"
                        aria-hidden="true"></i>
                </div>
                <div class="mobile-control-block mobile-control-left">
                    <h5 class="mobile-control-caption">Shares</h5>
                    <button class="btn btn-neutral btn-icon btn-facebook mobile-control-value btn-md btn-share btn-block btn-share"
                            style=""
                            data-id={{$mm.Key.Name}}>
                        <i class="fa fa-facebook-square" style="left: 25px;"></i>
                    </button>
                </div>
                <div class="mobile-control-block mobile-control-right" >
                    {{ if $mm.CanInvest }}
                    <button class="btn btn-default  btn-md btn-invest" style="background-color: #f96332;"
                            data-id="{{$mm.Key.Name}}">
                        Invest
                    </button>
                    {{end}}

                    {{ if and $authorized1 $mm.IsExpired }}
                    <button class="btn btn-default btn-md btn-invest" style="background-color: #424242;"
                            disabled>
                        Invest
                    </button>
                    {{end}}
                </div>
            </div>
        </div>

    </div>

</div>
{{ end }}

<ins class="adsbygoogle"
     style="display:block"
     data-ad-format="fluid"
     data-ad-layout-key="-8i+2n-gm+b5+tt"
     data-ad-client="ca-pub-1537045865676187"
     data-ad-slot="7980200758"></ins>
<script>
    (adsbygoogle = window.adsbygoogle || []).push({});
</script>

{{if $isSingleMeme}}
<div class="col-md-12 comment-box" >
    <div class="fb-comments" data-colorscheme="dark" data-width="100%" data-numposts="10"></div>
</div>
{{end}}



