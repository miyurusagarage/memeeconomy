package controllers

import (
	"github.com/miyurusagarage/memeeconomy/models"
	"github.com/astaxie/beego"
	"golang.org/x/oauth2"
	"golang.org/x/oauth2/facebook"
	"context"
	"github.com/miyurusagarage/memeeconomy/utils"
)

type LoginController struct {
	BaseController
}

var fbConfig = &oauth2.Config{
	ClientID:     beego.AppConfig.String("facebook_client_id"),
	ClientSecret: beego.AppConfig.String("facebook_client_secret"),
	RedirectURL:  beego.AppConfig.String("facebook_redirect_url"),
	Scopes:       []string{"email"},
	Endpoint:     facebook.Endpoint,
}

func (c *LoginController) Get() {
	c.Data["FbUrl"] = fbConfig.AuthCodeURL("")
	c.TplName = "login.tpl"
}

type FbUser struct{
	Id int
	Name string
}

func (this *LoginController) LoginFb() {

	tok, err := fbConfig.Exchange(context.Background(), this.GetString("code"))

	if err != nil{
		this.Redirect("/login", 302)
		return
	}

	fbUser := new(FbUser)
	utils.GetJson("https://graph.facebook.com/me?access_token=" + tok.AccessToken, fbUser)

	if err != nil {
		print(err)
	}

	var user = new(models.User)
	user.Username = fbUser.Name
	user.FbToken = tok.AccessToken
	user.Save()
	this.Redirect("/", 302)
	return

}


