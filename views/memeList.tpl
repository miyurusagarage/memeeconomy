{{ $showRank  := .showRank }}
{{ $authorized1  := .authorized }}
{{ $userKey1  := .userKey }}
{{ range $mm  := .data }}
<div class="meme" style=" " >
    <h2>{{$mm.Title}}</h2>
    <p class="meme-description" style="margin-top: -20px;">{{$mm.Description}}</p>

    <div class="row">
        <div class="col-md-10 meme-img-container" id="meme-img-container{{$mm.Key.Name}}">
            <p class="meme-likes">
                <i class="fa fa-heart  like-icon" aria-hidden="true" id="liked-heart{{$mm.Key.Name}}"></i>
            </p>
            <img class="meme-img"
                 src="{{$mm.ImagePath}}" onload="attachHeartAnimations('{{$mm.Key.Name}}','{{ $authorized1 }}','{{ $userKey1 }}' );"/>
            <div class="heart-container">
                <img src="data:image/svg+xml;base64,PHN2ZyB2ZXJzaW9uPSIxLjEiIGlkPSJMYXllcl8xIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHhtbG5zOnhsaW5rPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hsaW5rIiB4PSIwcHgiIHk9IjBweCINCgkgd2lkdGg9IjEwMHB4IiBoZWlnaHQ9Ijg3LjVweCIgdmlld0JveD0iMCAwIDEwMCA4Ny41IiBlbmFibGUtYmFja2dyb3VuZD0ibmV3IDAgMCAxMDAgODcuNSIgeG1sOnNwYWNlPSJwcmVzZXJ2ZSI+DQo8cGF0aCBmaWxsPSIjRkZGRkZGIiBkPSJNNTAsMTkuMUMzNy0xMS4yLDAuMi00LjEsMCwzMS4xYy0wLjEsMTkuMyw0OC44LDUyLjEsNTAuMSw1Ni40YzEuMS00LjMsNTAuMS0zNy4zLDUwLTU2LjYNCglDOTkuOC00LjQsNjIuMy0xMCw1MCwxOS4xeiIvPg0KPC9zdmc+DQo="
                     alt="heart" id="js-heart-image{{$mm.Key.Name}}"  />
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
                    <h5 class="sidebar-caption">Total Worth</h5>
                    <h3 class="sidebar-value">{{ $mm.CurrentInvestments }} F</h3>
                </div>
                <div class="sidebar-block">
                    <h5 class="sidebar-caption">Total Likes</h5>
                    <h3 class="sidebar-value" id="like-value{{$mm.Key.Name}}">{{ $mm.InternalLikes }}</h3>
                </div>

                <button class="btn btn-primary btn-block btn-lg btn-invest" data-id="{{$mm.Key.Name}}" data-toggle="modal" data-target="#investModal">
                    Invest
                </button>
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


