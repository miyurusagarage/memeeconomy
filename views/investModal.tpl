<div class="modal fade" id="investModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <form action="/investmeme" method="get" id="investSubmitForm">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="myModalLabel">Invest in this meme!</h4>
                </div>
                <div class="modal-body">
                    <input name="memeId" value="" id="memeId" type="hidden"/>
                    <div class="col-sm-12">
                        <p>You have <strong><span name="availableFlurbos">{{ .CurrentCredit }}</span> Flurbos</strong></p>

                        <p>Enter the amount of Flurbos you want to invest:</p>


                        <div class="form-group">

                            <input type="number" id="investAmount" name="amount" placeholder="enter the amount" required
                                   class="form-control">
                        </div>
                        <div class="form-group">
                            <p class="text-warning" style="display: none;" id="flurbowarning">Insufficient flurbos! Enter a value less than <span name="availableFlurbos">{{ .CurrentCredit }}</span></p>
                        </div>

                    </div>
                </div>
                <div class="modal-footer">
                    <p></p>
                    <button type="button" class="btn btn-primary btn-simple " id="btn-submit-investment">Submit Investment</button>
                </div>

            </div>
        </form>
    </div>
</div>