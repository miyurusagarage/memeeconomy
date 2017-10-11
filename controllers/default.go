package controllers

import (

)

type MainController struct {
	BaseController
}

func (c *MainController) Get() {
	c.ManageLoginCookie()
	c.Authorize()
	c.TplName = "home.tpl"
}
