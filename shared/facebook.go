package shared

import (
	"github.com/astaxie/beego"
	"golang.org/x/oauth2"
	"golang.org/x/oauth2/facebook"
)

var FbConfig = &oauth2.Config{
	ClientID:     beego.AppConfig.String("facebook_client_id"),
	ClientSecret: beego.AppConfig.String("facebook_client_secret"),
	RedirectURL:  beego.AppConfig.String("facebook_redirect_url"),
	Scopes:       []string{"email"},
	Endpoint:     facebook.Endpoint,
}

type FbUser struct {
	Id   string
	Name string
}

type FbError struct {
	Error ErrorDescription `error`
}

type ErrorDescription struct {
	Message   string `message`
	Type      string `type`
	Code      int `code`
	FbtraceId int `fbtrace_id`
}

type PostResult struct {
	Id string
	Post_id string
}

type PostStatsResult struct{
	Likes PostLikes
	Shares PostShares
}

type PostLikes struct {
	Summary LikeSummary
}

type PostShares struct {
	Count int
}

type LikeSummary struct {
	Total_count int
}

type Engagement struct {
	Reaction_count int
	Comment_count int
	Share_count int
	Comment_plugin_count int
}
