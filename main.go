package main

import (
	_ "github.com/miyurusagarage/memeeconomy/routers"
	"github.com/astaxie/beego"
	"github.com/miyurusagarage/memeeconomy/shared"
)

func main() {
	projId := beego.AppConfig.String("gds_project_id")
	beego.BConfig.WebConfig.TemplateLeft = "<<<"
	beego.BConfig.WebConfig.TemplateRight = ">>>"
	shared.ConnectGDS(projId)
	shared.ConnectGCS(projId)
	beego.Run()
}

