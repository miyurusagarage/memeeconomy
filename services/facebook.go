package services

import (
	"github.com/miyurusagarage/memeeconomy/models"
	"time"
	"github.com/miyurusagarage/memeeconomy/utils"
	"github.com/astaxie/beego"
	"sync"
	"strconv"
)

func UpdateMemeFbLikesAndShares(meme *models.Meme) {
	updateIntervalInMinutesConfig, _ := models.GetConfigByName("SocialUpdateIntervalInMinutes");
	updateIntervalInMinutes, _ := strconv.Atoi(updateIntervalInMinutesConfig.Value);
	if meme.SocialFbPostLink != ""  && meme.SocialUpdatedDate.Before(time.Now().Add(time.Minute * - time.Duration(updateIntervalInMinutes) )){
		println("getting likes")
		siteUrl := beego.AppConfig.String("app_url")
		postStatResult := utils.GetFbStatsForPost(meme.SocialFbPostLink)
		engagement := utils.GetFbEngagementForUrl(siteUrl + "getmemesingle?memeid=" + meme.Key.Name).Engagement
		meme.SocialLikes = postStatResult.Likes.Summary.Total_count + engagement.Reaction_count
		meme.SocialShares = postStatResult.Shares.Count + engagement.Share_count
		meme.SocialUpdatedDate = time.Now()
		meme.Update()
	}
}

func UpdateAllMemeFbLikesAndShares() {
	memes, _ := models.GetAllMemes()
	for _, meme := range *memes {
		UpdateMemeFbLikesAndShares(&meme)
	}
}

func UpdateMemeFbLikesAndSharesForMemes(objs *[]models.Meme) {
	var wg sync.WaitGroup
	for x := range *objs {
		wg.Add(1)
		go func(mm int) {
			UpdateMemeFbLikesAndShares(&(*objs)[mm])
			wg.Done()
		}(x)
	}
	wg.Wait()
	return
}
