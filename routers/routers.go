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
    beego.Router("/logout", &controllers.LoginController{},"get:LogOut")
    beego.Router("/getmemesingle", &controllers.MemesController{},"get:GetMemeSingle")
    beego.Router("/setusername", &controllers.ProfileController{},"get:SetUsername")
    beego.Router("/payoutinvestments", &controllers.PayoutInvestmentsController{})
    beego.Router("/transactions", &controllers.ProfileController{},"get:GetTransactions")
    beego.Router("/leaderboard", &controllers.LeaderboardController{})
}
