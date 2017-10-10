package controllers

import (
	"github.com/astaxie/beego"
	"github.com/miyurusagarage/memeeconomy/shared"

	"github.com/miyurusagarage/memeeconomy/utils"

	"time"
	"net/http"
)

type BaseController struct {
	beego.Controller
}

func (c *BaseController) Prepare() {
	if c.Ctx.Request.Header.Get("X-Pjax") == "" {
		c.Layout = "index.tpl"
	}

}

//call this before a request or in the prepare method of a controller if the user must be authorized for what ever comes next
func (c *BaseController) Authorize() {
	cookie, _ := c.Ctx.Request.Cookie("token")
	if (cookie != nil) {
		println("Cookie have")
		fbUser := new(shared.FbUser)
		err := utils.GetFbJson("https://graph.facebook.com/me?access_token="+cookie.Value, *fbUser)

		if err != nil {

			if (err.Error.Code == 190) {
				//somethings up or needs a refresh
				//https://developers.facebook.com/docs/facebook-login/access-tokens/expiration-and-extension/
				//https://developers.facebook.com/docs/facebook-login/access-tokens/debugging-and-error-handling
			}
			//no access gtfo
			c.Abort("401")
		}

		if (&fbUser.Name != nil) {
			//all goood
			c.Data["authorized"] = true
			c.Data["username"] = fbUser.Name

		} else {
			//no access gtfo
			c.Abort("401")
		}
	} else {
		println("no cookie sending to login")
		//send to login if there was no cookie (new guy)
		c.Redirect("/login", 302)
	}
}

func (c *BaseController) ManageLoginCookie() {
	if (c.GetString("t") != "") {
		expiration := time.Now().Add(365 * 24 * time.Hour) //1 year
		c.Ctx.Request.Header.Set("domain", "localhost")
		tokenCookie := http.Cookie{Name: "token", Value: c.GetString("t"), Expires: expiration}
		http.SetCookie(c.Ctx.ResponseWriter, &tokenCookie)
		c.Redirect("/", 302)
	}
}
