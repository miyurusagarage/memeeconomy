package controllers

import (
	"github.com/miyurusagarage/memeeconomy/models"
	"github.com/miyurusagarage/memeeconomy/shared"
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

func(c *ProfileController) SetUsername(){
	userId := c.GetString("userId")
	username := c.GetString("username")
	if userId != "" && username != "" {
		existingUser, _ := models.GetUserFromUsername(username)
		isValidUsername := existingUser == nil || existingUser.Key.Name == userId
		if !isValidUsername{
			usernameError := new(shared.JSONResponse)
			usernameError.Error = "Username already exists"
			c.Data["json"] = &usernameError
			c.Ctx.Output.Status = 400
		}else{
			user, _ := models.GetUserFromId(userId)
			user.Username = username;
			user.UsernamePromptShown = true;
			user.Update()
			c.Data["json"] = &user
			c.Ctx.Output.Status = 200
		}
	}
	c.ServeJSON()
}