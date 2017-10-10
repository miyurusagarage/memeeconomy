package controllers

import (
	"github.com/miyurusagarage/memeeconomy/shared"
	"golang.org/x/net/context"
	"io"
)

type UploadImageController struct {
	BaseController
}

func (c *UploadImageController) Post() {
	ctx := context.Background()
	gcsObj := shared.Bkt.Object(c.GetString("imgId") + ".jpg")
	writer := gcsObj.NewWriter(ctx)
	f,_,_ := c.GetFile("file")
	if _, err := io.Copy(writer, f); err != nil {
		return
	}
	if err := writer.Close(); err != nil {
		return
	}
	c.TplName = "upload.tpl"
}

