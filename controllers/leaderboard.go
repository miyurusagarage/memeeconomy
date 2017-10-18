package controllers

import (
	"github.com/miyurusagarage/memeeconomy/models"

)

type LeaderboardController struct {
	BaseController
}

func (c *LeaderboardController) Get() {

	users,_ := models.GetLeaders()
	x:=models.User{}
	n:=[]models.User{x}
	vc := append(n ,*users...)
	c.Data["data"] = vc
	c.TplName = "leaderboard.tpl"
}
