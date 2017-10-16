package models

import (
	"cloud.google.com/go/datastore"
	"golang.org/x/net/context"
	"github.com/miyurusagarage/memeeconomy/shared"
	"fmt"
	"time"
	"github.com/nu7hatch/gouuid"
	"github.com/miyurusagarage/memeeconomy/utils"
)

const SocialPostThreshold = 1
const MemeExpirationInDays = 5

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
	this.SocialPostThreshold = SocialPostThreshold
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
			this.ExpirationDate = time.Now().Add(MemeExpirationInDays * (time.Hour * 24))
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

func GetRecentMemes(offset int, pageSize int) (objs *[]Meme, total int, err error) {

	ctx := context.Background()
	q := datastore.NewQuery("meme")
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
	q = q.Order("-CurrentInvestments")
	q = q.Offset(offset)
	q = q.Limit(pageSize)

	var data []Meme
	_, er := shared.DatastoreClient.GetAll(ctx, q, &data)

	//count for pagination
	q = datastore.NewQuery("meme")
	count := 0
	count, er = shared.DatastoreClient.Count(ctx, q, )
	println(count)
	if er != nil {
		return nil, 0, er
	}

	return &data, count , nil
}

func GetRecentMemesByUser(key string ,offset int, pageSize int) (objs *[]Meme, total int, err error) {

	ctx := context.Background()
	q := datastore.NewQuery("meme")
	println(pageSize)


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
