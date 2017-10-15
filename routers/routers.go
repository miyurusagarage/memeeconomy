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
    beego.Router("/recentmemes", &controllers.MemesController{},"get:GetRecent")
    beego.Router("/getmeme", &controllers.MemesController{},"get:GetRecentBlock")
    beego.Router("/votememe", &controllers.VoteMemeController{})
    beego.Router("/investmeme", &controllers.InvestMemeController{})
    beego.Router("/profile", &controllers.ProfileController{})
    beego.Router("/getmemesforuser", &controllers.MemesController{},"get:GetUserPosts")
    beego.Router("/getTopMemes", &controllers.MemesController{},"get:GetTop")
    beego.Router("/gettopblock", &controllers.MemesController{},"get:GetTopBlock")
}
