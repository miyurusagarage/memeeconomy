package controllers

import (
	"github.com/miyurusagarage/memeeconomy/models"
)

type MemesController struct {
	BaseController
}

func (c *MemesController) GetRecent() {
	memes, total, _ := models.GetRecentMemes(0, 2)
	c.Data["data"] = memes
	c.Data["total"] = total
    c.TplName = "recentMemes.tpl"
}

func (c *MemesController) GetRecentBlock() {
	offset,err := c.GetInt("offset")
	if(err!=nil){
		return
	}
	memes, total, _ := models.GetRecentMemes(offset-2, 1)

	c.Data["data"] = memes
	c.Data["showRank"] = false
	c.Data["total"] = total
	c.TplName = "memeList.tpl"
}