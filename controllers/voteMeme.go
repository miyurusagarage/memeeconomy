package controllers

import (
	"github.com/miyurusagarage/memeeconomy/models"
	"cloud.google.com/go/datastore"
)

type VoteMemeController struct {
	BaseController
}

func(c * VoteMemeController) Prepare() {
	c.Authorize()
}

func (c *VoteMemeController) Get() {
	voteType := c.GetString("type")
	memeId := c.GetString("memeId")
	userKey := c.Data["userKey"].(*datastore.Key)
	memeVote, _ := models.GetMemeVoteFromMemeByUser(memeId, userKey.Name)
	meme, _ := models.GetMemeFromId(memeId)
	if meme != nil && userKey != nil && memeId != ""  && !meme.IsExpired{
		switch voteType {
		case "up":
			if memeVote == nil {
				memeVote = new(models.MemeVote)
				memeVote.MemeId = memeId
				memeVote.UserId = userKey.Name
				memeVote.VoteValue = 1
				err := memeVote.Save()
				if err == nil{
					meme.InternalLikes++
					meme.Update()
				}
			}
		case "down":
			if memeVote != nil {
				err := memeVote.Delete()
				if err == nil {
					meme.InternalLikes--
					meme.Update()
				}
			}
		}
	}
	c.Data["json"] = &meme
	c.ServeJSON()
}

