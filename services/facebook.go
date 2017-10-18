package services

import (
	"github.com/miyurusagarage/memeeconomy/models"
	"time"
	"github.com/miyurusagarage/memeeconomy/utils"
	"github.com/astaxie/beego"
)

func UpdateMemeFbLikesAndShares(meme models.Meme) {
	if meme.SocialFbPostLink != "" && meme.SocialUpdatedDate.Before(time.Now().Add(time.Minute * -5)) {
		siteUrl := beego.AppConfig.String("app_url")
		postStatResult := utils.GetFbStatsForPost(meme.SocialFbPostLink)
		engagement := utils.GetFbEngagementForUrl(siteUrl + "getmemesingle?memeid=" + meme.Key.Name)
		meme.SocialLikes = postStatResult.Likes.Summary.Total_count + engagement.Reaction_count
		meme.SocialShares = postStatResult.Shares.Count + engagement.Share_count
		meme.SocialUpdatedDate = time.Now()
		meme.Update()
	}
}

func UpdateAllMemeFbLikesAndShares() {
	memes, _ := models.GetAllMemes()
	for _, meme := range *memes {
		UpdateMemeFbLikesAndShares(meme)
	}
}
