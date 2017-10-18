package utils

import (
	"net/http"
	"encoding/json"
	"time"
	"github.com/miyurusagarage/memeeconomy/shared"
	"fmt"
	"github.com/astaxie/beego"
	"net/url"
	"strings"
)

var simpleHttpClient = &http.Client{Timeout: 10 * time.Second}


//use this for decoding json from fb, it will load the custom fb error upon failure
func GetFbJson(url string, target *shared.FbUser) *shared.FbError {
	r, err := simpleHttpClient.Get(url)

	if err != nil {
		return nil
	}
	defer r.Body.Close()

	if (r.StatusCode != 200) {
		fbErrorObj := new(shared.FbError)
		json.NewDecoder(r.Body).Decode( fbErrorObj)
		fmt.Println( fbErrorObj.Error.Code)
		return   fbErrorObj
	}

	json.NewDecoder(r.Body).Decode(target)

	return nil
}

func PostMemeToFb(memeImageUrl string, memeTitle string) (string){
	fbGraphUrl := beego.AppConfig.String("facebook_graph_url")
	fbPageAccessToken := beego.AppConfig.String("facebook_page_access_token")
	fbPageId := beego.AppConfig.String("facebook_page_id")
	form := url.Values{}
	form.Add("message", memeTitle)
	form.Add("url", memeImageUrl)
	form.Add("access_token", fbPageAccessToken)
	response, err := simpleHttpClient.Post(fbGraphUrl + "/" + fbPageId + "/photos", "application/x-www-form-urlencoded", strings.NewReader(form.Encode()))
	if err == nil{
		postResult := new(shared.PostResult)
		json.NewDecoder(response.Body).Decode(postResult)
		return postResult.Post_id
	}
	return ""
}

func GetFbStatsForPost(postId string) (*shared.PostStatsResult){
	fbGraphUrl := beego.AppConfig.String("facebook_graph_url")
	fbPageAccessToken := beego.AppConfig.String("facebook_page_access_token")

	response, err := simpleHttpClient.Get(fbGraphUrl + "/" + postId + "?fields=likes.limit(0).summary(true),shares" + "&access_token=" + fbPageAccessToken)
	if err == nil{
		postStatResult := new(shared.PostStatsResult)
		json.NewDecoder(response.Body).Decode(postStatResult)
		return postStatResult
	}
	return nil
}

func GetFbEngagementForUrl(urlPath string) (*shared.EngagementResponse){
	fbGraphUrl := beego.AppConfig.String("facebook_graph_url")
	fbPageAccessToken := beego.AppConfig.String("facebook_page_access_token")

	response, err := simpleHttpClient.Get(fbGraphUrl + "/?id=" + url.PathEscape(urlPath) + "&fields=engagement" + "&access_token=" + fbPageAccessToken)
	if err == nil{
		engagement := new(shared.EngagementResponse)
		json.NewDecoder(response.Body).Decode(engagement)
		return engagement
	}
	return nil
}
