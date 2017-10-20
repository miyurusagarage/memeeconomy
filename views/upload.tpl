<div class="container" style=" ">

    <link rel="stylesheet" href="static/css/dropzone.css">
    <div class="alert alert-warning col-md-12" role="alert" style="    background-color: rgb(252, 109, 45); margin-bottom: 50px;color: #ffffff;">
        <div class="container">
            <div class="alert-icon">
                <i class="now-ui-icons travel_info"></i>
            </div>
            <strong>Heads up!</strong> If your meme exceeds 500 investments, we will post it to our facebook page with
            due credits to you.
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">
                                <i class="now-ui-icons ui-1_simple-remove"></i>
                            </span>
            </button>
        </div>
    </div>
    <h2>Upload Meme</h2>

    <form action="/uploadimage" enctype="multipart/form-data" method="post"
          class="col-sm-12"
          id="my-awesome-dropzone">
        <input type="hidden" id="dropzoneImageId" name="imgId" value=""/>

    </form>
    <form action="/uploadmeme" enctype="multipart/form-data" method="post" class="row" id="upload-form">
        <div class="col-sm-12">
            <div class="form-group">
                <input type="text" value="" name="title" placeholder="Title" class="form-control" required>
                <input type="hidden" id="imgId" name="imgId" value=""/>

            </div>

            <div class="form-group text-center" style="margin-top: 40px;">
                <input type="submit" class="btn btn-primary btn-round btn-lg" id="submit-meme" disabled
                       style="display: inline-block;text-align: center" value="Post Meme">
            </div>
        </div>

    </form>


    <script>

        $.getScript('static/js/dropzone.js', function () {
            onPageLoad()
        });

        $('#upload-form').on('submit', function () {
            iziToast.info({
                id: 'info',
                zindex: 9000,
                layout: 1,
                timeout: 2000,
                title: 'Hold on!',
                message: 'Processing.',
                position: 'bottomRight',
                transitionIn: 'bounceInLeft'
            });
        })

        function onPageLoad() {
            Dropzone.autoDiscover = false;
            function guid() {
                function s4() {
                    return Math.floor((1 + Math.random()) * 0x10000)
                        .toString(16)
                        .substring(1);
                }

                return s4() + s4() + '-' + s4() + '-' + s4() + '-' +
                    s4() + '-' + s4() + s4() + s4();
            }

            var uuid = guid();

            $('#imgId').val(uuid)
            $('#dropzoneImageId').val(uuid)

            Dropzone.options.myAwesomeDropzone = {
                paramName: "file", // The name that will be used to transfer the file
                maxFilesize: 5, // MB
                thumbnailWidth: null,
                thumbnailHeight: 357,
                maxFiles: 1,
                dictDefaultMessage: "drop your memes here",
                maxfilesexceeded: function (file) {
                    this.removeAllFiles();
                    this.addFile(file);

                },
                accept: function (file, done) {
                    if (file.name == "justinbieber.jpg") {
                        done("Naha, you don't.");
                    }
                    else {
                        done();
                        uuid = guid();
                        $('#imgId').val(uuid)
                        $('#dropzoneImageId').val(uuid)

                    }
                }
            };

            $('#my-awesome-dropzone').addClass('dropzone')
            var myDropzone = new Dropzone("#my-awesome-dropzone");
            myDropzone.on("addedfile", function (file) {
                $('#submit-meme').attr("disabled", true)
            });
            myDropzone.on("success", function (file) {
                $('#submit-meme').removeAttr("disabled")
            });
        }

    </script>
</div>

