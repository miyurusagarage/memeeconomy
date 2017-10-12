package models

import (
	"cloud.google.com/go/datastore"
	"golang.org/x/net/context"
	"github.com/miyurusagarage/memeeconomy/shared"
	"fmt"
	"time"

	"github.com/nu7hatch/gouuid"
)

type MemeVote struct {
	Key         *datastore.Key `datastore:"__key__"`
	MemeId      string
	UserId      string
	VoteValue   int
	CreatedDate time.Time
}

func (this *MemeVote) Save() (err error) {
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

func (this *MemeVote) Update() (err error) {
	ctx := context.Background()
	if _, err := shared.DatastoreClient.Put(ctx, this.Key, this); err != nil {
		fmt.Println(err)
		return err
	}
	return nil
}

func (this *MemeVote) Delete() (err error) {
	ctx := context.Background()
	if err := shared.DatastoreClient.Delete(ctx, this.Key); err != nil {
		fmt.Println(err)
		return err
	}
	return nil
}

func (this *MemeVote) kind() (str string) {
	return "meme_vote"
}

func GetMemeVoteFromId(id string) (objs *MemeVote, err error) {
	ctx := context.Background()

	key := datastore.NameKey("meme_vote", id, nil)
	var data MemeVote
	er := shared.DatastoreClient.Get(ctx, key, &data)

	if er != nil {
		return nil, er
	}

	return &data, nil
}

func GetMemeVoteFromMemeAndUser(memeId string, userId string) (objs *MemeVote, err error) {
	ctx := context.Background()

	q := datastore.NewQuery("meme_vote").
		Filter("MemeId =", memeId).Filter("UserId =", userId)

	var memeVotes []MemeVote
	_, er := shared.DatastoreClient.GetAll(ctx, q,  &memeVotes)

	if er != nil {
		return nil, er
	}

	if len(memeVotes) > 0{
		return &memeVotes[0], nil
	}
	return nil, nil
}

