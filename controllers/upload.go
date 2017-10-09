package controllers

import (
	//"golang.org/x/net/context"
	//"google.golang.org/appengine/datastore"

)

type UploadController struct {
	BaseController
}

func (c *UploadController) Get() {
	c.TplName = "upload.tpl"
}

