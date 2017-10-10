package controllers

import (
	"github.com/miyurusagarage/memeeconomy/models"
 )

type MemeSingleController struct {
	BaseController
}

func (c *MemeSingleController) Get() {
	c.Authorize()
	if (c.GetString("id") != "") {
		id := c.GetString("id")
		meme, _ := models.GetMemeFromId(id)
		c.Data["data"] = meme
	}
	c.TplName = "memeSingle.tpl"
}
