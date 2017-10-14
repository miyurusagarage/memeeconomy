package controllers

import (
	"github.com/miyurusagarage/memeeconomy/models"
	"github.com/miyurusagarage/memeeconomy/shared"
	"context"
	"github.com/miyurusagarage/memeeconomy/utils"
)

type LoginController struct {
	BaseController
}

func (c *LoginController) Get() {
	c.Data["FbUrl"] = shared.FbConfig.AuthCodeURL("")
	c.TplName = "login.tpl"
}

func (this *LoginController) LoginFb() {
	tok, err := shared.FbConfig.Exchange(context.Background(), this.GetString("code"))

	if err != nil {
		this.Redirect("/login", 302)
		return
	}

	fbUser := new(shared.FbUser)
	utils.GetFbJson("https://graph.facebook.com/me?access_token="+tok.AccessToken, fbUser)

	if err != nil {
		print(err)
	}

	dbUser, err := models.GetUserFromFbId(fbUser.Id)

	if dbUser == nil{
		dbUser = new(models.User)
		dbUser.Username = fbUser.Name
		dbUser.CurrentCredit = 100
		dbUser.FbId = fbUser.Id
		dbUser.FbToken = tok.AccessToken
		dbUser.Save()
	}else{
		dbUser.FbToken = tok.AccessToken
		dbUser.Update()
	}

	this.Redirect("/?t=" + tok.AccessToken, 302)
	return

}
