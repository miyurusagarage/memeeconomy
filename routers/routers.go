package routers

import (
	"github.com/miyurusagarage/memeeconomy/controllers"
	"github.com/astaxie/beego"
)

func init() {
    beego.Router("/", &controllers.MainController{})
    beego.Router("/login", &controllers.LoginController{})
    beego.Router("/login/facebook", &controllers.LoginController{}, "get:LoginFb")
    beego.Router("/uploadmeme", &controllers.UploadController{})
    beego.Router("/uploadimage", &controllers.UploadImageController{})
}