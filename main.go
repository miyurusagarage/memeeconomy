package main

import (
	_ "github.com/miyurusagarage/memeeconomy/routers"
	"github.com/astaxie/beego"
	"github.com/miyurusagarage/memeeconomy/shared"
	"github.com/jasonlvhit/gocron"
	"github.com/miyurusagarage/memeeconomy/services"
)

func main() {
	projId := beego.AppConfig.String("gds_project_id")
	shared.ConnectGDS(projId)
	shared.ConnectGCS(projId)
	gocron.Every(5).Minutes().Do(services.UpdateAllMemeFbLikesAndShares)
	beego.Run()
}

