package controllers

import (
	"github.com/miyurusagarage/memeeconomy/models"
	"time"
	"math"
)

type PayoutInvestmentsController struct {
	BaseController
}

func (c *PayoutInvestmentsController) Prepare() {
	c.Authorize()
}

func (c *PayoutInvestmentsController) Get() {
	eligibleMemes, _ := models.GetToBeExpiredMemes()
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
	moment :=float64(memeInvestment.MomentsTotalFame - memeInvestment.BidAmount)
	bid := float64(memeInvestment.BidAmount)
	total :=float64(meme.TotalFame)
	gain := total - moment - bid
	absTotal := math.Abs(float64(total))
	fame := (bid / absTotal * gain) + bid
	fame = math.Max(fame,0)
	return int(fame)
}