package models

import (
	"cloud.google.com/go/datastore"
	"golang.org/x/net/context"
	"github.com/miyurusagarage/memeeconomy/shared"
	"fmt"
	"time"
	"github.com/nu7hatch/gouuid"
	"github.com/miyurusagarage/memeeconomy/utils"
	"google.golang.org/api/iterator"
	"strconv"
)

type Meme struct {
	Key                 *datastore.Key `datastore:"__key__"`
	CreatedDate         time.Time
	CreatedUserId       string
	CurrentInvestments  int
	Description         string
	ExpirationDate      time.Time
	ImagePath           string
	InternalLikes       int
	ModifiedDate        time.Time
	SocialPostThreshold int
	SocialFbPostLink    string
	SocialLikes         int
	SocialPostsCreated  bool
	SocialPostedDate    time.Time
	SocialShares        int
	SocialUpdatedDate   time.Time
	IsExpired           bool
	Title               string
	TotalFame           int
}

func (this *Meme) Save() (err error) {
	this.CreatedDate = time.Now()
	socialPostThreshold, _ := GetConfigByName("SocialPostThreshold")
	this.SocialPostThreshold, _ = strconv.Atoi(socialPostThreshold.Value)
	var id *uuid.UUID
	id, _ = uuid.NewV4()
	urlId := id.String()
	key := datastore.NameKey(this.kind(), urlId, nil)
	ctx := context.Background()
	if _, err := shared.DatastoreClient.Put(ctx, key, this); err != nil {
		fmt.Println(err)
		return err
	}
	return nil
}

func (this *Meme) Update() (err error) {
	this.ModifiedDate = time.Now()
	if this.CurrentInvestments >= this.SocialPostThreshold {
		if this.SocialFbPostLink == "" {
			postId := utils.PostMemeToFb(this.ImagePath, this.Title)
			this.SocialFbPostLink = postId
			this.SocialPostedDate = time.Now()
			memeExpirationInDaysConfig , _ := GetConfigByName("MemeExpirationInDays")
			memeExpirationInDays , _ := strconv.Atoi(memeExpirationInDaysConfig.Value)
			this.ExpirationDate = time.Now().Add(time.Duration(memeExpirationInDays) * (time.Hour * 24))
			this.SocialPostsCreated = true
		}
	}
	this.TotalFame = this.SocialLikes + this.SocialShares + this.CurrentInvestments + this.InternalLikes
	ctx := context.Background()
	if _, err := shared.DatastoreClient.Put(ctx, this.Key, this); err != nil {
		fmt.Println(err)
		return err
	}
	return nil
}

func (this *Meme) kind() (str string) {
	return "meme"
}

func (this *Meme) TotalLikes() (str int) {
	return this.InternalLikes + this.SocialLikes
}

func (this *Meme) CanInvest() ( bool) {

	return !this.IsExpired
}

func (this *Meme) DaysToExpire() ( int) {

	diff := this.ExpirationDate.Sub(time.Now()).Hours()
	return int(diff/24)
}


func GetMemeFromId(id string) (objs *Meme, err error) {
	ctx := context.Background()

	key := datastore.NameKey("meme", id, nil)
	var data Meme
	er := shared.DatastoreClient.Get(ctx, key, &data)

	if er != nil {
		return nil, er
	}

	return &data, nil

}

func GetMemeFromKey(key *datastore.Key) (objs *Meme, err error) {
	ctx := context.Background()

	var data Meme
	er := shared.DatastoreClient.Get(ctx, key, &data)

	if er != nil {
		return nil, er
	}

	return &data, nil

}

func GetRecentMemes(offset int, pageSize int, fromTime time.Time) (objs *[]Meme, total int, err error) {

	ctx := context.Background()
	q := datastore.NewQuery("meme")
	q = q.Filter("CreatedDate <", fromTime)
	q = q.Order("-CreatedDate")
	q = q.Offset(offset)
	q = q.Limit(pageSize)

	var data []Meme
	_, er := shared.DatastoreClient.GetAll(ctx, q, &data)

	//count for pagination
	q = datastore.NewQuery("meme")
	count := 0
	count, er = shared.DatastoreClient.Count(ctx, q, )

	if er != nil {
		return nil, 0, er
	}
	return &data, count , nil
}

func GetTopMemes(offset int, pageSize int) (objs *[]Meme, total int, err error) {
	ctx := context.Background()
	q := datastore.NewQuery("meme")
	q = q.Filter("IsExpired =",false)
	q = q.Order("-TotalFame")
	q = q.Offset(offset)
	q = q.Limit(pageSize)
	var data []Meme
	it := shared.DatastoreClient.Run(ctx, q)
	for {
		var meme Meme
		_, err := it.Next(&meme)
		if err == iterator.Done {
			break
		}
		if err != nil {
			println(err.Error())
			break
		}
		data = append(data, meme)

	}

	//count for pagination
	q = datastore.NewQuery("meme")

	count, er := shared.DatastoreClient.Count(ctx, q, )

	if er != nil {
		return nil, 0, er
	}

	return &data, count , nil
}

func GetRecentMemesByUser(key string ,offset int, pageSize int) (objs *[]Meme, total int, err error) {

	ctx := context.Background()
	q := datastore.NewQuery("meme")


	q = q.Filter("CreatedUserId =", key)
	q = q.Offset(offset)
	q = q.Limit(pageSize)

	var data []Meme
	_, er := shared.DatastoreClient.GetAll(ctx, q, &data)

	//count for pagination
	q = datastore.NewQuery("meme")
	count := 0
	count, er = shared.DatastoreClient.Count(ctx, q, )

	if er != nil {
		return nil, 0, er
	}
	return &data, count , nil
}

func GetAllMemes( ) (objs *[]Meme, err error) {
	ctx := context.Background()
	q := datastore.NewQuery("meme")

	var data []Meme
	_, er := shared.DatastoreClient.GetAll(ctx, q, &data)

	if er != nil {
		return nil, er
	}
	return &data , nil
}

func GetToBeExpiredMemes( ) (objs *[]Meme, err error) {
	ctx := context.Background()
	q := datastore.NewQuery("meme").Filter("ExpirationDate <", time.Now()).Filter("IsExpired !=", true)

	var data []Meme
	_, er := shared.DatastoreClient.GetAll(ctx, q, &data)

	if er != nil {
		return nil, er
	}
	return &data , nil
}
