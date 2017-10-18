package controllers

import (

)

type MainController struct {
	BaseController
}

func (c *MainController) Get() {
	c.ManageLoginCookie()
	c.Data["blockFetchUrl"] = "getmeme"
	c.TplName = "recentMemes.tpl"
}

func (c *MainController) PrivacyPolicy() {
	c.TplName = "privacy-policy.tpl"
}
