package controllers

import (
	//"golang.org/x/net/context"
	//"google.golang.org/appengine/datastore"

	"github.com/miyurusagarage/memeeconomy/models"
	"time"
	"github.com/miyurusagarage/memeeconomy/shared"
	"cloud.google.com/go/datastore"
)

type UploadController struct {
	BaseController
}

func (c *UploadController) Get() {
	c.Authorize()
	c.TplName = "upload.tpl"
}

func (c *UploadController) Post() {

	title := c.GetString("title")
	description := c.GetString("description")
	imageid := c.GetString("imgId")
	meme := models.Meme{
		Title:title,
		Description:description,
		CreatedDate: time.Now(),
		ImagePath: shared.CreateObjectPath(imageid + ".jpg"),
		CreatedUserId: c.Data["userKey"].(*datastore.Key).Name,
	}
	meme.Save()
	c.Ctx.Redirect(302, "/?usuccess=true")
}

