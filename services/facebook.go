package services

import (
	"github.com/miyurusagarage/memeeconomy/models"
	"time"
	"github.com/miyurusagarage/memeeconomy/utils"
)

func UpdateMemeFbLikesAndShares(meme models.Meme) {
	if meme.SocialFbPostLink != "" && meme.SocialUpdatedDate.Before(time.Now().Add(time.Minute * -5)) {
		postStatResult := utils.GetFbStatsForPost(meme.SocialFbPostLink)
		meme.SocialLikes = postStatResult.Likes.Summary.Total_count
		meme.SocialShares = postStatResult.Shares.Count
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
