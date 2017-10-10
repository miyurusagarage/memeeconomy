package models

import (
	"cloud.google.com/go/datastore"
	"golang.org/x/net/context"
	"github.com/miyurusagarage/memeeconomy/shared"
	"fmt"
	"time"

	"github.com/nu7hatch/gouuid"
)

type MemeInvestment struct {
	Key                   *datastore.Key `datastore:"__key__"`
	BidAmount             int
	CreatedDate           time.Time
	MomentsInternalLikes  int
	MomentsMemeInvestment int
	MomentsSocialLikes    int
	MomentsSocialShares   int
	InvestmentPoints      int
	MemeId                string
	PayoutAmount          int
	PayoutDate            time.Time
	UserId                string
}

func (this *MemeInvestment) Save() (err error) {
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

func (this *MemeInvestment) Update() (err error) {
	ctx := context.Background()
	if _, err := shared.DatastoreClient.Put(ctx, this.Key, this); err != nil {
		fmt.Println(err)
		return err
	}
	return nil
}

func (this *MemeInvestment) kind() (str string) {
	return "meme"
}

func GetMemeInvestmentFromId(id string) (objs *User, err error) {
	ctx := context.Background()

	key := datastore.NameKey("meme", id, nil)
	var data User
	er := shared.DatastoreClient.Get(ctx, key, &data)

	if er != nil {
		return nil, er
	}

	return &data, nil

}
