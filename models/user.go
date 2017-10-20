package models

import (
	"cloud.google.com/go/datastore"
	"golang.org/x/net/context"
	"github.com/miyurusagarage/memeeconomy/shared"
	"fmt"
	"time"

	"github.com/nu7hatch/gouuid"
)

type User struct {
	Key                  *datastore.Key `datastore:"__key__"`
	Username             string
	FbId                 string
	FbToken              string
	CurrentCredit        int
	CreatedDate          time.Time
	UpdateDate           time.Time
	UsernamePromptShown  bool
	InitialCreditShown   bool
	MemeTipsShown        bool
	TransactionTipsShown bool
}

func (this *User) Save() (err error) {
	this.CreatedDate = time.Now()
	this.CurrentCredit = 1000
	this.InitialCreditShown = false
	var id *uuid.UUID
	id, _ = uuid.NewV4()
	urlId := id.String()
	key := datastore.NameKey(this.kind(), urlId, nil)
	ctx := context.Background()
	if _, err := shared.DatastoreClient.Put(ctx, key, this); err != nil {
		fmt.Println(err)
		return err
	}
	this.Key = key
	return nil
}

func (this *User) Update() (err error) {
	this.UpdateDate = time.Now()
	ctx := context.Background()
	if _, err := shared.DatastoreClient.Put(ctx, this.Key, this); err != nil {
		fmt.Println(err)
		return err
	}
	return nil
}

func (this *User) kind() (str string) {
	return "user"
}

func GetUserFromId(id string) (objs *User, err error) {
	ctx := context.Background()

	key := datastore.NameKey("user", id, nil)
	var data User
	er := shared.DatastoreClient.Get(ctx, key, &data)

	if er != nil {
		return nil, er
	}

	return &data, nil
}

func GetUserFromFbId(fbId string) (objs *User, err error) {
	ctx := context.Background()

	q := datastore.NewQuery("user").
		Filter("FbId =", fbId)

	var users []User
	_, er := shared.DatastoreClient.GetAll(ctx, q, &users)

	if er != nil {
		return nil, er
	}

	if len(users) > 0 {
		return &users[0], nil
	}
	return nil, nil
}

func GetUserFromFbToken(fbToken string) (objs *User, err error) {
	ctx := context.Background()

	q := datastore.NewQuery("user").
		Filter("FbToken =", fbToken)

	var users []User
	_, er := shared.DatastoreClient.GetAll(ctx, q, &users)

	if er != nil {
		return nil, er
	}

	if len(users) > 0 {
		return &users[0], nil
	}
	return nil, nil
}

func (this *User) GetRank() (rank int, err error) {
	ctx := context.Background()

	q := datastore.NewQuery("user").
		Filter("CurrentCredit >", this.CurrentCredit)

	rank, er := shared.DatastoreClient.Count(ctx, q)

	if er != nil {
		return -1, er
	}

	return rank + 1, nil
}

func (this *User) AddOne() (rank int) {

	return rank + 1
}

func (this *User) GetPostCount() (count int, err error) {
	ctx := context.Background()
	q := datastore.NewQuery("meme").
		Filter("CreatedUserId =", this.Key.Name)

	count, er := shared.DatastoreClient.Count(ctx, q)

	if er != nil {
		return -1, er
	}

	return count, nil
}

func GetUserFromUsername(username string) (objs *User, err error) {
	ctx := context.Background()

	q := datastore.NewQuery("user").
		Filter("Username =", username)

	var users []User
	_, er := shared.DatastoreClient.GetAll(ctx, q, &users)

	if er != nil {
		return nil, er
	}

	if len(users) > 0 {
		return &users[0], nil
	}
	return nil, nil
}

func GetLeaders() (objs *[]User, err error) {
	ctx := context.Background()

	q := datastore.NewQuery("user").
		Order("-CurrentCredit")
	q = q.Limit(100)

	var users []User
	_, er := shared.DatastoreClient.GetAll(ctx, q, &users)

	if er != nil {
		return nil, er
	}

	println(&users)

	return &users, nil
}
