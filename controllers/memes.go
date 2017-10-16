package controllers

import (
	"github.com/miyurusagarage/memeeconomy/models"
	"cloud.google.com/go/datastore"
	"time"
	"net/url"
)

type MemesController struct {
	BaseController
}

func (c *MemesController) GetRecent() {
	c.Data["blockFetchUrl"] = "getmeme"
	c.TplName = "recentMemes.tpl"
}

func (c *MemesController) GetTop() {
	c.Data["blockFetchUrl"] = "gettopblock"
	c.TplName = "recentMemes.tpl"
}

func (c *MemesController) GetRecentBlock() {
	offset, err := c.GetInt("offset")
	t,_ := url.QueryUnescape(c.GetString("time"))
	startingTime, _ := time.Parse("2006-01-02 15:04:05", t)

	if (err != nil) {
		return
	}

	println(offset)
	memes, total, _ := models.GetRecentMemes((offset-2)*3, 3, startingTime)

	var keys []string
	for _, mem := range *memes {
		key := mem.Key.Name
		keys = append(keys, key)
	}

	var voteMapCss = make(map[string]string)
	if (c.Authorized) {
		voteMap, _ := models.GetMemeVoteFromMemesByUser(keys, c.Data["userKey"].(*datastore.Key).Name)
		for k, v := range *voteMap {
			if (&v != nil) {
				voteMapCss[k] = "liked"
			}
		}
	}
	c.Data["voteMap"] = voteMapCss

	var users []string
	for _, mem := range *memes {
		key := mem.CreatedUserId
		users = append(users, key)
	}
	c.Data["memeUsers"],_ = models.GetUsersFromUserIds(users)

	if len(*memes) == 0 {
		c.Abort("404")
	}

	c.Data["data"] = memes
	c.Data["showRank"] = false
	c.Data["total"] = total
	c.TplName = "memeList.tpl"
}

func (c *MemesController) GetTopBlock() {
	offset, err := c.GetInt("offset")

	if (err != nil) {
		return
	}

	println(offset)
	memes, total, _ := models.GetTopMemes((offset-2)*3, 3)

	var keys []string
	for _, mem := range *memes {
		key := mem.Key.Name
		keys = append(keys, key)
	}


	var voteMapCss = make(map[string]string)
	if (c.Authorized) {
		voteMap, _ := models.GetMemeVoteFromMemesByUser(keys, c.Data["userKey"].(*datastore.Key).Name)
		for k, v := range *voteMap {
			if (&v != nil) {
				voteMapCss[k] = "liked"
			}
		}
	}

	c.Data["voteMap"] = voteMapCss

	if len(*memes) == 0 {
		c.Abort("404")
	}

	var users []string
	for _, mem := range *memes {
		key := mem.CreatedUserId
		users = append(users, key)
	}
	c.Data["memeUsers"],_ = models.GetUsersFromUserIds(users)

	c.Data["data"] = memes
	c.Data["showRank"] = false
	c.Data["total"] = total
	c.TplName = "memeList.tpl"
}

func (c *MemesController) GetUserPosts() {
	offset, err := c.GetInt("offset")

	if (err != nil) {
		return
	}

	println(offset)
	var user *models.User
	userKey := c.GetString("id")

	if userKey != "" {
		user, _ = models.GetUserFromId(userKey)
	} else {
		user = (c.Data["user"]).(*models.User)
	}

	memes, total, _ := models.GetRecentMemesByUser(user.Key.Name, (offset-2)*3, 3)

	var keys []string
	for _, mem := range *memes {
		key := mem.Key.Name
		keys = append(keys, key)
	}

	var voteMapCss = make(map[string]string)
	if (c.Authorized) {
		voteMap, _ := models.GetMemeVoteFromMemesByUser(keys, c.Data["userKey"].(*datastore.Key).Name)
		for k, v := range *voteMap {
			if (&v != nil) {
				voteMapCss[k] = "liked"
			}
		}
	}
	c.Data["voteMap"] = voteMapCss

	var users []string
	for _, mem := range *memes {
		key := mem.CreatedUserId
		users = append(users, key)
	}
	c.Data["memeUsers"],_ = models.GetUsersFromUserIds(users)

	if len(*memes) == 0 {
		c.Abort("404")
	}

	c.Data["data"] = memes
	c.Data["showRank"] = false
	c.Data["total"] = total
	c.TplName = "memeList.tpl"
}
