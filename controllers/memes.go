package controllers

import (
	"github.com/miyurusagarage/memeeconomy/models"
)

type TopMemesController struct {
	BaseController
}

func (c *TopMemesController) GetRecent() {
	c.Authorize()
	memes, total, _ := models.GetRecentMemes(0, 2)
	c.Data["data"] = memes
	c.Data["total"] = total
    c.TplName = "memeList.tpl"
}
