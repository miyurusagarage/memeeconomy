package controllers

import (

)

type MainController struct {
	BaseController
}

func (c *MainController) Get() {
	c.ManageLoginCookie()
	c.IsAuthorized()
	c.TplName = "recentMemes.tpl"
}
