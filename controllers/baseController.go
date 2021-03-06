package controllers

import (
	"github.com/astaxie/beego"
	"github.com/miyurusagarage/memeeconomy/shared"

	"github.com/miyurusagarage/memeeconomy/utils"

	"time"
	"net/http"
	"github.com/miyurusagarage/memeeconomy/models"
	"net/url"
)

type BaseController struct {
	beego.Controller
	Authorized bool
}

func (c *BaseController) Prepare() {
	if c.Ctx.Request.Header.Get("X-Pjax") == "" {
		c.Layout = "index.tpl"
	}

	t := url.QueryEscape(time.Now().Format("2006-01-02 15:04:05"))
	c.Data["time"] = t
	c.Data["siteUrl"] = c.Ctx.Input.Site()
	c.Data["FbUrl"] = shared.FbConfig.AuthCodeURL("")
	c.IsAuthorized()
}

func (c *BaseController) IsAuthorized() (bool, *shared.FbError) {
	cookie, _ := c.Ctx.Request.Cookie("token")

	if (cookie != nil) {

		user, _ := models.GetUserFromFbToken(cookie.Value)
		if (user != nil) {
			fbUser := new(shared.FbUser)
			err := utils.GetFbJson("https://graph.facebook.com/me?access_token="+cookie.Value, fbUser)
			if (fbUser.Name != "") {
				c.Data["authorized"] = true
				c.Authorized = true
				dbUser, _ := models.GetUserFromFbId(fbUser.Id)
				c.Data["userKey"] = dbUser.Key
				c.Data["username"] = dbUser.Username
				c.Data["userp"] = dbUser
				var user1 models.User
				user1 = *dbUser
				c.Data["user"] = user1
				c.Data["fbId"] = dbUser.FbId
				dbUser.InitialCreditShown = true
				dbUser.MemeTipsShown = true
				go dbUser.Update()
				return true, err
			} else {
				c.Authorized = false
				c.Data["authorized"] = false
				c.Data["userKey"] = ""
				c.Data["username"] = ""
				c.Data["fbId"] = ""
				c.Data["user"] = nil
				return false, err
			}
		}
	}
	c.Authorized = false
	c.Data["authorized"] = false
	c.Data["userKey"] = ""
	c.Data["username"] = ""
	c.Data["fbId"] = ""
	c.Data["user"] = nil
	return false, nil
}

//call this before a request or in the prepare method of a controller if the user must be authorized for what ever comes next
func (c *BaseController) Authorize() {
	isAuthorized, err := c.IsAuthorized()
	if !isAuthorized {
		if err != nil {
			if (err.Error.Code == 190) {
				//somethings up or needs a refresh
				c.Redirect(shared.FbConfig.AuthCodeURL(""), 302)
				//https://developers.facebook.com/docs/facebook-login/access-tokens/expiration-and-extension/
				//https://developers.facebook.com/docs/facebook-login/access-tokens/debugging-and-error-handling
			}
		}
		//send to login if there was no cookie (new guy)
		c.Redirect("/login", 302)
		return
	}
}

func (c *BaseController) ManageLoginCookie() {
	if (c.GetString("t") != "") {
		expiration := time.Now().Add(365 * 24 * time.Hour) //1 year
		tokenCookie := http.Cookie{Name: "token", Value: c.GetString("t"), Expires: expiration}
		http.SetCookie(c.Ctx.ResponseWriter, &tokenCookie)
		c.Redirect("/?lsuccess=true", 302)
	}
}
