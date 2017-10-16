package controllers

import (
	"github.com/miyurusagarage/memeeconomy/models"
)

type ProfileController struct {
	BaseController
}

func (c *ProfileController) Get() {
	var user *models.User
	userKey := c.GetString("id")
	if userKey != "" {
		user, _ = models.GetUserFromId(userKey)

	} else {
		c.Authorize()
		user = (c.Data["user"]).(*models.User)
	}

	

	c.Data["userData"] = user
	c.Data["userRank"],_ = user.GetRank()
	c.Data["userPosts"],_ = user.GetPostCount()
	c.TplName = "profile.tpl"
}
