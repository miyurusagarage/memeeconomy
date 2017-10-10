<script src="static/js/dropzone.js"></script>
<link rel="stylesheet" href="static/css/dropzone.css">
<div class="container" style=" ">
    <h2>Upload Meme</h2>

    <form action="/uploadimage" enctype="multipart/form-data" method="post"
          class="col-sm-12 dropzone"
          id="my-awesome-dropzone">
        <input type="hidden" id="dropzoneImageId" name="imgId" value=""/>

    </form>
    <form action="/uploadmeme" enctype="multipart/form-data" method="post" class="row">
        <div class="col-sm-12">
            <div class="form-group">
                <input type="text" value="" name="title" placeholder="Title" class="form-control">
                <input type="hidden" id="imgId" name="imgId" value=""/>

            </div>
            <div class="form-group">
                <textarea class="form-control" placeholder="Tell your fans a bit about this meme..." name="description"
                          rows="5"></textarea>
            </div>
            <div class="form-group text-center">
               <input type="submit" class="btn btn-primary btn-round btn-lg" style="display: inline-block;text-align: center" value="Post Meme">
            </div>
        </div>

    </form>


    <script>


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

        $(document).ready(function (a) {
            $('#imgId').val(uuid)
            $('#dropzoneImageId').val(uuid)
        });

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

        $(function () {

            $('#dropzone').on('dragover', function () {
                $(this).addClass('hover');
            });

            $('#dropzone').on('dragleave', function () {
                $(this).removeClass('hover');
            });

            $('#dropzone input').on('change', function (e) {
                var file = this.files[0];

                $('#dropzone').removeClass('hover');

                if (this.accept && $.inArray(file.type, this.accept.split(/, ?/)) == -1) {
                    return alert('File type not allowed.');
                }

                $('#dropzone').addClass('dropped');
                $('#dropzone img').remove();

                if ((/^image\/(gif|png|jpeg|jpg)$/i).test(file.type)) {
                    var reader = new FileReader(file);

                    reader.readAsDataURL(file);

                    reader.onload = function (e) {
                        var data = e.target.result,
                            $img = $('<img />').attr('src', data).fadeIn();

                        $('#dropzone div').html($img);
                    };
                } else {
                    var ext = file.name.split('.').pop();

                    $('#dropzone div').html(ext);
                }
            });
        });
    </script>
</div>
