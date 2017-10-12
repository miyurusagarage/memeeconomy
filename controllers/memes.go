package controllers

import (
	"github.com/miyurusagarage/memeeconomy/models"
)

type MemesController struct {
	BaseController
}

func (c *MemesController) GetRecent() {

	c.TplName = "recentMemes.tpl"
}

func (c *MemesController) GetRecentBlock() {
	c.IsAuthorized()
	offset, err := c.GetInt("offset")
	if (err != nil) {
		return
	}
	println(offset)
	memes, total, _ := models.GetRecentMemes((offset-2)*3, 3)
	if len(*memes) == 0 {
		c.Abort("404")
	}
	c.Data["data"] = memes
	c.Data["showRank"] = false
	c.Data["total"] = total
	c.TplName = "memeList.tpl"
}
