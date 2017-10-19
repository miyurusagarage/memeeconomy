package controllers

import (
	"github.com/miyurusagarage/memeeconomy/models"
	"time"
	"math"
	"github.com/miyurusagarage/memeeconomy/shared"
)

type PayoutInvestmentsController struct {
	BaseController
}

func (c *PayoutInvestmentsController) Prepare() {

}

func (c *PayoutInvestmentsController) Get() {
	eligibleMemes, _ := models.GetToBeExpiredMemes()
	if eligibleMemes != nil {
		for _, eligibleMeme := range *eligibleMemes {
			eligibleMeme.IsExpired = true
			eligibleInvestments, _ := models.GetMemeInvestmentsByMeme(eligibleMeme.Key.Name)
			if eligibleInvestments != nil {

				for _, eligibleMemeInvestment := range *eligibleInvestments {
					eligibleMemeInvestment.PayoutDate = time.Now()
					eligibleMemeInvestment.PayoutAmount = getPayoutAmount(eligibleMeme, eligibleMemeInvestment)
					investmentUser, _ := models.GetUserFromId(eligibleMemeInvestment.UserId)
					investmentUser.CurrentCredit += eligibleMemeInvestment.PayoutAmount
					eligibleMemeInvestment.Update()
					investmentUser.Update()
				}
			}
			eligibleMeme.Update()
		}
	}
	jsonResponse := new(shared.JSONResponse)
	jsonResponse.Message = "Success"
	c.Data["json"] = jsonResponse
	c.ServeJSON()
}

func getPayoutAmount(meme models.Meme, memeInvestment models.MemeInvestment) int {
	moment := float64(memeInvestment.MomentsTotalFame - memeInvestment.BidAmount)
	bid := float64(memeInvestment.BidAmount)
	total := float64(meme.TotalFame)
	gain := total - moment - bid
	absTotal := math.Abs(float64(total))
	fame := (bid / absTotal * gain) + bid
	fame = math.Max(fame, 0)
	return int(fame)
}
