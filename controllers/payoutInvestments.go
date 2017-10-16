package controllers

import (
	"github.com/miyurusagarage/memeeconomy/models"
	"time"
)

type PayoutInvestmentsController struct {
	BaseController
}

func (c *PayoutInvestmentsController) Prepare() {
	c.Authorize()
}

func (c *PayoutInvestmentsController) Get() {
	eligibleMemes, _ := models.GetAllMemes()//
	for _, eligibleMeme := range *eligibleMemes {
		eligibleMeme.IsExpired = true
		eilgibleInvestments, _ := models.GetMemeInvestmentsByMeme(eligibleMeme.Key.Name)
		for _, eligibleMemeInvestment := range *eilgibleInvestments {
			eligibleMemeInvestment.PayoutDate = time.Now()
			eligibleMemeInvestment.PayoutAmount = getPayoutAmount(eligibleMeme, eligibleMemeInvestment)
			investmentUser, _ := models.GetUserFromId(eligibleMemeInvestment.UserId)
			investmentUser.CurrentCredit += eligibleMemeInvestment.PayoutAmount
			eligibleMemeInvestment.Update()
			investmentUser.Update()
		}
		eligibleMeme.Update()
	}
}

func getPayoutAmount(meme models.Meme, memeInvestment models.MemeInvestment) int{

	return (meme.TotalFame - memeInvestment.MomentsTotalFame - memeInvestment.BidAmount) + ((meme.TotalFame / memeInvestment.MomentsTotalFame) * memeInvestment.BidAmount)
}