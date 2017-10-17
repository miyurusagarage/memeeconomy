{{ $showRank  := .showRank }}
{{ $authorized1  := .authorized }}
{{ $userKey1  := .userKey }}
{{ $voteMap  := .voteMap }}
{{ $memeUsers  := .memeUsers }}
{{ range $mm  := .data }}

<div class="meme" style=" ">
    <h2>{{$mm.Title}}</h2>
    <p class="meme-description" style="margin-top: -20px;">{{$mm.Description}}</p>
    <a href="/profile?id={{$mm.CreatedUserId}}"><p class="meme-description" style="margin-top: -20px;">by {{ (index $memeUsers $mm.CreatedUserId).Username}}</p></a>


    <div class="row">
        <div class="col-md-10 meme-img-container {{  index $voteMap $mm.Key.Name  }}"
             id="meme-img-container{{$mm.Key.Name}}">
            <p class="meme-likes">
                <i class="fa fa-heart like-icon {{  index $voteMap $mm.Key.Name  }}" aria-hidden="true"
                   id="liked-heart{{$mm.Key.Name}}"></i>
            </p>
            <img class='meme-img '
                 src='{{$mm.ImagePath}}'
                 onload="attachHeartAnimations('{{$mm.Key.Name}}','{{ $authorized1 }}','{{ $userKey1 }}' );"/>
            <div class="heart-container">
                <img src="data:image/svg+xml;base64,PHN2ZyB2ZXJzaW9uPSIxLjEiIGlkPSJMYXllcl8xIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHhtbG5zOnhsaW5rPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hsaW5rIiB4PSIwcHgiIHk9IjBweCINCgkgd2lkdGg9IjEwMHB4IiBoZWlnaHQ9Ijg3LjVweCIgdmlld0JveD0iMCAwIDEwMCA4Ny41IiBlbmFibGUtYmFja2dyb3VuZD0ibmV3IDAgMCAxMDAgODcuNSIgeG1sOnNwYWNlPSJwcmVzZXJ2ZSI+DQo8cGF0aCBmaWxsPSIjRkZGRkZGIiBkPSJNNTAsMTkuMUMzNy0xMS4yLDAuMi00LjEsMCwzMS4xYy0wLjEsMTkuMyw0OC44LDUyLjEsNTAuMSw1Ni40YzEuMS00LjMsNTAuMS0zNy4zLDUwLTU2LjYNCglDOTkuOC00LjQsNjIuMy0xMCw1MCwxOS4xeiIvPg0KPC9zdmc+DQo="
                     alt="heart" id="js-heart-image{{$mm.Key.Name}}"/>
            </div>
        </div>
        <div class="col-md-2">
            <div class="">
                {{ if $showRank }}
                <div class="sidebar-block">
                    <h5 class="sidebar-caption">Meme Rank</h5>
                    <h3 class="sidebar-value">#1</h3>
                </div>
                {{ end }}
                <div class="sidebar-block">
                    <h5 class="sidebar-caption">Worth</h5>
                    <h3 class="sidebar-value"  >{{ $mm.TotalFame }} F</h3>
                </div>
                <div class="sidebar-block">
                    <h5 class="sidebar-caption">Investments</h5>
                    <h3 class="sidebar-value" id="meme-flurbos{{$mm.Key.Name}}">{{ $mm.CurrentInvestments }} F</h3>
                </div>
                <div class="sidebar-block">
                    <h5 class="sidebar-caption">Likes</h5>
                    <h3 class="sidebar-value" id="like-value{{$mm.Key.Name}}">{{ $mm.TotalLikes }}</h3>
                </div>
                <div class="sidebar-block">
                    <h5 class="sidebar-caption">Share</h5>

                    <button class="btn btn-neutral btn-icon btn-facebook btn-round btn-lg btn-share" data-id={{$mm.Key.Name}}>
                        <i class="fa fa-facebook-square"></i>
                        <p class="d-lg-none d-xl-none">Facebook</p>
                    </button>
                </div>



                {{ if and $authorized1 $mm.CanInvest }}
                <button class="btn btn-default btn-block btn-lg btn-invest" style="background-color: #424242;" data-id="{{$mm.Key.Name}}"
                        data-toggle="modal" data-target="#investModal">
                    Invest
                </button>
                {{end}}

                {{ if and $authorized1 $mm.IsExpired }}
                <button class="btn btn-default btn-block btn-lg btn-invest" style="background-color: #424242;"  disabled>
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


