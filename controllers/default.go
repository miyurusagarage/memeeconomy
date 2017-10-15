package controllers

import (

)

type MainController struct {
	BaseController
}

func (c *MainController) Get() {
	c.ManageLoginCookie()
	c.IsAuthorized()
	c.Data["blockFetchUrl"] = "getmeme"
	c.TplName = "recentMemes.tpl"
}
