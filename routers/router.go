package routers

import (
	"github.com/miyurusagarage/memeeconomy/controllers"
	"github.com/astaxie/beego"
)

func init() {
    beego.Router("/", &controllers.MainController{})
    beego.Router("/berzerkzerglongstringsabcdesanchez", &controllers.UploadController{})
}
