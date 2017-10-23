var activeClassName = 'active',
    likedClassName = 'liked';

function attachHeartAnimations(key, isAuthorized, userKey) {

    var imgContainer = $("#meme-img-container" + key),
        theHeartImage = $("#js-heart-image" + key),
        likedHeart = $("#liked-heart" + key),
        likeValue = $("#like-value" + key),
        worthValue = $("[name=worth-value" + key + ']');

    if (isAuthorized) {
        imgContainer.on('click', function () {
            if (!imgContainer.hasClass(likedClassName)) {
                imgContainer.removeClass(activeClassName)
                imgContainer.addClass(activeClassName)
                imgContainer.addClass(likedClassName)
                likedHeart.addClass(likedClassName)
                likeValue.text(function (i, oldVal) {
                    return parseInt(oldVal, 10) + 1;
                });
                worthValue.text(function (i, oldVal) {
                    return parseInt(oldVal, 10) + 2;
                });

                $.ajax({
                    url: "/votememe",
                    type: "get",
                    data: {
                        type: 'up',
                        memeId: key
                    }
                });
            } else {

            }
        });
        likedHeart.on('click', function (event) {
            event.stopPropagation();
            if (likedHeart.hasClass(likedClassName)) {
                imgContainer.removeClass(likedClassName)
                likedHeart.removeClass(likedClassName)
                likeValue.text(function (i, oldVal) {
                    if(oldVal < 1) return;
                    return parseInt(oldVal, 10) - 1;
                });
                worthValue.text(function (i, oldVal) {
                    if(oldVal < 1) return;
                    return parseInt(oldVal, 10) - 2;
                });
                $.ajax({
                    url: "/votememe",
                    type: "get",
                    data: {
                        type: 'down',
                        memeId: key
                    }
                });
            } else {
                imgContainer.removeClass(activeClassName)
                imgContainer.addClass(activeClassName)
                imgContainer.addClass(likedClassName)
                likedHeart.addClass(likedClassName)
                likeValue.text(function (i, oldVal) {
                    return parseInt(oldVal, 10) + 1;
                });
                worthValue.text(function (i, oldVal) {
                    return parseInt(oldVal, 10) + 2;
                });
                $.ajax({
                    url: "/votememe",
                    type: "get",
                    data: {
                        type: 'up',
                        memeId: key
                    }
                });
            }
        });
    }else{
        imgContainer.on('click', function (){
            $('#loginModal').modal().toggle()
        });

        likedHeart.on('click', function (){
            $('#loginModal').modal().toggle()
        })
    }

    theHeartImage.on('transitionend', function () {
        imgContainer.removeClass(activeClassName)
    });

    theHeartImage.on('webkitTransitionEnd', function () {
        imgContainer.removeClass(activeClassName)
    });
}


$(document).on("click", ".btn-invest", function () {
    var memeId = $(this).data('id');
    $(".modal-body #memeId").val(memeId);
    if(user) {
        $("#investModal").modal().toggle();
    }else{
        $("#loginModal").modal().toggle();
    }
});

$(document).on("click", ".btn-share", function () {
    var memeId = $(this).data('id');
    FB.ui({
        method: 'share',
        href: siteUrl + '/getmemesingle?memeid=' + memeId,
    }, function (response) {
    });
});

$('#btn-submit-investment').on('click', function () {
    $("#investSubmitForm").submit();
})

$('#investAmount').on('input', function (e) {
    if (user) {
        if (parseInt(e.target.value, 10) > parseInt(user.CurrentCredit, 10)) {
            $("#btn-submit-investment").prop("disabled", true);
            $('#flurbowarning').show()
        } else {
            $("#btn-submit-investment").prop("disabled", false);
            $('#flurbowarning').hide()
        }
    }
});

$("#investSubmitForm").submit(function (event) {
    if (user) {
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
        /* stop form from submitting normally */
        event.preventDefault();

        /* get the action attribute from the <form action=""> element */
        var $form = $(this),
            url = $form.attr('action');
        var key = $('#memeId').val()
        /* Send the data using post with element id name and name2*/
        $.ajax({
            url: url,
            type: "get",
            data: {
                amount: $('#investAmount').val(),
                memeId: key
            },
            success: function (result) {
                iziToast.destroy();
                iziToast.success({
                    id: 'error',
                    zindex: 9000,
                    layout: 1,
                    title: 'Yaay!',
                    message: 'Investment was successful.',
                    position: 'bottomRight',
                    transitionIn: 'bounceInLeft',
                });
                $('span[name=availableFlurbos]').text(function (i, oldVal) {
                    return parseInt(oldVal, 10) - parseInt($('#investAmount').val(), 10)
                });

                $('#user-current-credit').text(function (i, oldVal) {
                    return parseInt(oldVal, 10) - parseInt($('#investAmount').val(), 10)
                })

                $("[name=worth-value" + key + ']').text(function (i, oldVal) {
                    return parseInt(oldVal, 10) + parseInt($('#investAmount').val(), 10)
                });

                $('#meme-flurbos' + key).text(function (i, oldVal) {
                    return parseInt(oldVal, 10) + parseInt($('#investAmount').val(), 10)
                });
            },
            error: function (result) {
                iziToast.warning({
                    id: 'error',
                    zindex: 9000,
                    layout: 1,
                    title: 'Whoops!',
                    message: result.responseJSON.Error + '! Cannot complete the transaction.',
                    position: 'bottomRight',
                    transitionIn: 'bounceInLeft',
                });
                console.log()
            }

        });

        $('#investModal').modal('toggle');
    }
});
