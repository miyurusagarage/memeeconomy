package models

import (
	"cloud.google.com/go/datastore"
	"golang.org/x/net/context"
	"github.com/miyurusagarage/memeeconomy/shared"
	"fmt"
	"time"
	"github.com/nu7hatch/gouuid"
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
	Status              string
	Title               string
	TotalFame           int
}

func (this *Meme) Save() (err error) {
	this.CreatedDate = time.Now()
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