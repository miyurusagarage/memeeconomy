<<< $showRank  := .showRank >>>
<<< range $mm  := .data >>>
<div class="meme" style=" ">
    <h2><<<$mm.Title>>></h2>
    <p class="meme-description" style="margin-top: -20px;"><<<$mm.Description>>></p>

    <div class="row">
        <div class="col-md-10">
            <p class="meme-likes"
               style="margin-top: -20px; float:right;    position: absolute; right: 25px;  top: 25px;">
                <i class="now-ui-icons  like-icon   ui-2_favourite-28"></i>
            </p>
            <img class="meme-img"
                 src="<<<$mm.ImagePath>>>"
            />

        </div>
        <div class="col-md-2">
            <div class="">
                <<< if $showRank >>>
                <div class="sidebar-block">
                    <h5 class="sidebar-caption">Meme Rank</h5>
                    <h3 class="sidebar-value">#1</h3>
                </div>

                <<< end >>>
                <div class="sidebar-block">
                    <h5 class="sidebar-caption">Total Worth</h5>
                    <h3 class="sidebar-value"><<< $mm.CurrentInvestments >>> F</h3>
                </div>
                <div class="sidebar-block">
                    <h5 class="sidebar-caption">Total Likes</h5>
                    <h3 class="sidebar-value"><<< $mm.InternalLikes >>> </h3>
                </div>

                <button class="btn btn-primary btn-block btn-lg btn-invest" data-toggle="modal" data-target="#myModal">
                    Invest
                </button>
            </div>
        </div>
    </div>
</div>
<<< end >>>

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

<script>
    $('[data-toggle="popover"]').popover();
</script>