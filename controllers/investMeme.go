package controllers

import (
	"github.com/miyurusagarage/memeeconomy/models"
	"cloud.google.com/go/datastore"
	"github.com/miyurusagarage/memeeconomy/shared"
)

type InvestMemeController struct {
	BaseController
}

func (c *InvestMemeController) Prepare() {
	c.Authorize()
}

func (c *InvestMemeController) Get() {
	investmentBidAmount, err := c.GetInt("amount")
	memeId := c.GetString("memeId")
	userKey := c.Data["userKey"].(*datastore.Key)
	meme, _ := models.GetMemeFromId(memeId)
	dbUser, _ := models.GetUserFromId(userKey.Name)
	investMemeError := new(shared.JSONResponse)
	if meme != nil && userKey != nil && memeId != "" && err == nil && dbUser != nil && !meme.IsExpired {

		if dbUser.CurrentCredit >= investmentBidAmount && investmentBidAmount > 0 {

			memeInvestment := new(models.MemeInvestment)
			memeInvestment.MemeId = memeId
			memeInvestment.UserId = userKey.Name
			memeInvestment.BidAmount = investmentBidAmount

			// Deduct From User
			dbUser.CurrentCredit -= memeInvestment.BidAmount
			dbUser.Update()

			// Add to Current Investment
			meme.CurrentInvestments += memeInvestment.BidAmount
			meme.Update()

			// Meme's current values
			memeInvestment.MomentsInternalLikes = meme.InternalLikes
			memeInvestment.MomentsMemeInvestment = meme.CurrentInvestments
			memeInvestment.MomentsSocialLikes = meme.SocialLikes
			memeInvestment.MomentsSocialShares = meme.SocialShares
			memeInvestment.MomentsTotalFame = meme.TotalFame

			err := memeInvestment.Save()

			if err == nil {
				c.Data["json"] = &meme
				c.ServeJSON()
				return
			}

		} else {
			investMemeError.Error = "Insufficient Credit"
			c.Data["json"] = &investMemeError
			c.Ctx.Output.Status = 400
			c.ServeJSON()
			return
		}
	}
	investMemeError.Error = "Internal Server Error"
	c.Data["json"] = &investMemeError
	c.ServeJSON()
	c.Ctx.Output.Status = 500
}
