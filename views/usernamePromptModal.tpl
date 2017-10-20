<div class="modal fade" id="usernamePromptModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <form id="usernameSubmitForm">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">Enter your Username!</h4>
                </div>
                <div class="modal-body">
                    <div class="col-sm-12">

                        <div class="form-group">

                            <input type="text" id="username" name="username" placeholder="Enter your Username" required
                                   value="{{.Username}}"
                                   class="form-control">
                        </div>
                        <div class="form-group">
                            <p class="text-warning" style="display: none;" id="username-warning">That username is already taken</p>
                        </div>

                    </div>
                </div>
                <div class="modal-footer">
                    <p></p>
                    <button type="button" id="usernameFormBtn" class="btn btn-primary btn-simple">Save</button>
                </div>

            </div>
        </form>
    </div>
</div>