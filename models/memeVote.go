package models

import (
	"cloud.google.com/go/datastore"
	"golang.org/x/net/context"
	"github.com/miyurusagarage/memeeconomy/shared"
	"fmt"
	"time"

	"github.com/nu7hatch/gouuid"
	"sync"
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

func GetMemeVoteFromMemeByUser(memeId string, userId string) (objs *MemeVote, err error) {
	ctx := context.Background()

	q := datastore.NewQuery("meme_vote").
		Filter("MemeId =", memeId).Filter("UserId =", userId)

	var memeVotes []MemeVote
	_, er := shared.DatastoreClient.GetAll(ctx, q, &memeVotes)

	if er != nil {
		return nil, er
	}

	if len(memeVotes) > 0 {
		return &memeVotes[0], nil
	}
	return nil, nil
}

func GetMemeVoteFromMemesByUser(memeIds []string, userId string) (objs *map[string]MemeVote, err error) {
	ctx := context.Background()
	var bufferedChan = make(chan *MemeVote, len(memeIds))
	var wg sync.WaitGroup
	voteMap := make(map[string]MemeVote)
	for _, memeIdx := range memeIds {
		wg.Add(1)
		go func(memeId string) {
			q := datastore.NewQuery("meme_vote").
				Filter("MemeId =", memeId).Filter("UserId =", userId)

			var memeVotes []MemeVote
			_, er := shared.DatastoreClient.GetAll(ctx, q, &memeVotes)
			if er != nil {
				bufferedChan <- nil
			}
			if len(memeVotes) > 0 {
				bufferedChan <- &memeVotes[0]
			}
			wg.Done()
		}(memeIdx)
	}

	go func() {
		wg.Wait()
		close(bufferedChan)
	}()

	for v := range bufferedChan {
		if (v != nil) {
			voteMap[v.MemeId] = *v
		}
	}

	return &voteMap, nil
}

func GetUsersFromUserIds(userIds []string) (objs *map[string]User, err error) {
 	var bufferedChan = make(chan *User, len(userIds))
	var wg sync.WaitGroup
	voteMap := make(map[string]User)
	for _, userIdx := range userIds {
		wg.Add(1)
		go func(userId string) {
			user, er := GetUserFromId(userId)

			if er != nil {
				bufferedChan <- nil
			}

				bufferedChan <- user

			wg.Done()
		}(userIdx)
	}

	go func() {
		wg.Wait()
		close(bufferedChan)
	}()

	for v := range bufferedChan {
		if (v != nil) {
			voteMap[v.Key.Name] = *v
		}
	}

	return &voteMap, nil
}
