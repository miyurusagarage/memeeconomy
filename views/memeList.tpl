{{ $showRank  := .showRank }}
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
                 src="{{$mm.ImagePath}}" onload="attachHeartAnimations('{{$mm.Key.Name}}');"/>
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

                <button class="btn btn-primary btn-block btn-lg btn-invest" data-toggle="modal" data-target="#myModal">
                    Invest
                </button>
            </div>
        </div>
    </div>
    <script>
        alert("SSS")
        $(document).ready(function () {
            $('[data-toggle="popover"]').popover();
    </script>

</div>
{{ end }}

<!-- Modal Core -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <form action="/investmeme" method="post">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="myModalLabel">Invest in this meme!</h4>
                </div>
                <div class="modal-body">
                    <div class="col-sm-12">
                        <p>You have <strong>1000 Flurbos</strong></p>

                        <p>Enter the amount of Flurbos you want to invest:</p>


                        <div class="form-group">
                            <input type="number" value="" name="title" placeholder="enter the amount"
                                   class="form-control">
                        </div>

                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default btn-simple " data-color="popover-info"
                            data-toggle="popover" data-placement="left" title="Meme Investing"
                            data-content="Here will be some very useful information about his popover.">What's this?
                    </button>
                    <button type="submit" class="btn btn-primary btn-simple ">Submit Investment</button>

                </div>

            </div>
        </form>
    </div>
</div>

