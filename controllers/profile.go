package controllers

import (
	"github.com/miyurusagarage/memeeconomy/models"
	"github.com/miyurusagarage/memeeconomy/shared"
	"github.com/astaxie/beego/utils/pagination"
	"cloud.google.com/go/datastore"
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
		user = (c.Data["userp"].( *models.User))
	}

	c.Data["userData"] = *user
	c.Data["userRank"], _ = user.GetRank()
	c.Data["userPosts"], _ = user.GetPostCount()
	c.TplName = "profile.tpl"
}

func (c *ProfileController) GetTransactions() {
	c.Authorize()
	total,_:=models.GetAllTransactionsTotal(c.Data["userKey"].(*datastore.Key).Name)
	paginator := pagination.SetPaginator(c.Ctx, 10, int64(total))
	c.Data["data"] ,_= models.GetAllTransactions(c.Data["userKey"].(*datastore.Key).Name, paginator.Offset(), 10)
	c.TplName = "transactions.tpl"
	var user1 models.User
	user1 =  c.Data["user"].( models.User)
	user1.TransactionTipsShown=true
	go user1.Update()
}

func (c *ProfileController) SetUsername() {
	userId := c.GetString("userId")
	username := c.GetString("username")
	if userId != "" && username != "" {
		existingUser, _ := models.GetUserFromUsername(username)
		isValidUsername := existingUser == nil || existingUser.Key.Name == userId
		if !isValidUsername {
			usernameError := new(shared.JSONResponse)
			usernameError.Error = "Username already exists"
			c.Data["json"] = &usernameError
			c.Ctx.Output.Status = 400
		} else {
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
