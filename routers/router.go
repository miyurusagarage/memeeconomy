package routers

import (
	"github.com/miyurusagarage/memeeconomy/controllers"
	"github.com/astaxie/beego"
)

func init() {
    beego.Router("/", &controllers.MainController{})
    beego.Router("/uploadmeme", &controllers.UploadController{})
    beego.Router("/uploadimage", &controllers.UploadImageController{})

}
